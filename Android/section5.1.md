# ANR

## 参考文档

1.  什么是ANR
    
    https://mp.weixin.qq.com/s/ApNSEWxQdM19QoCNijagtg
    
2. 如何监控ANR

	https://blog.csdn.net/ljcITworld/article/details/104420422
	
3. 线上ANR实例分析：

	https://mp.weixin.qq.com/s/TDtjQdOktLcUYec3ldhh5g

## ANR概念

**与系统交互的组件（activity，service，provider, receiver）以及与用户交互的组件（InputEvent）进行超时监控，判断主进程是否卡死或者响应缓慢的情况。**

>系统通过Binder机制向应用进程发消息或者事件的时候，会开启一个计时监控，超过计时就会触发ANR

## 超时时间

一般是10s，Input事件是5s。
后台服务和后台广播时间会长一些，但是不同手机有定制。

    override fun onCreate(savedInstanceState: Bundle?) {
        try {
            Thread.sleep(10000)
        }catch (exception:Throwable){
            
        }
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }
    
    这种并不会导致ANR

## ANR原理（以BroadCastReceiver为例）

1.无序广播不进行监控

2.有序广播才进行ANR监控

```java
	核心代码： BroadCastQueue

        // Get the next receiver...
        int recIdx = r.nextReceiver++;

        // Keep track of when this receiver started, and make sure there
        // is a timeout message pending to kill it if need be.
        r.receiverTime = SystemClock.uptimeMillis();
        if (recIdx == 0) {
            r.dispatchTime = r.receiverTime;
            r.dispatchClockTime = System.currentTimeMillis();
            if (Trace.isTagEnabled(Trace.TRACE_TAG_ACTIVITY_MANAGER)) {
                Trace.asyncTraceEnd(Trace.TRACE_TAG_ACTIVITY_MANAGER,
                    createBroadcastTraceTitle(r, BroadcastRecord.DELIVERY_PENDING),
                    System.identityHashCode(r));
                Trace.asyncTraceBegin(Trace.TRACE_TAG_ACTIVITY_MANAGER,
                    createBroadcastTraceTitle(r, BroadcastRecord.DELIVERY_DELIVERED),
                    System.identityHashCode(r));
            }
            if (DEBUG_BROADCAST_LIGHT) Slog.v(TAG_BROADCAST, "Processing ordered broadcast ["
                    + mQueueName + "] " + r);
        }
        if (! mPendingBroadcastTimeoutMessage) {
            long timeoutTime = r.receiverTime + mTimeoutPeriod;
            if (DEBUG_BROADCAST) Slog.v(TAG_BROADCAST,
                    "Submitting BROADCAST_TIMEOUT_MSG ["
                    + mQueueName + "] for " + r + " at " + timeoutTime);
            setBroadcastTimeoutLocked(timeoutTime); -------------------》 这一行代码
        }



    final void setBroadcastTimeoutLocked(long timeoutTime) {
        if (! mPendingBroadcastTimeoutMessage) {
            Message msg = mHandler.obtainMessage(BROADCAST_TIMEOUT_MSG, this);
            mHandler.sendMessageAtTime(msg, timeoutTime);   ------》 发送一个延迟消息
            mPendingBroadcastTimeoutMessage = true;
        }
    }



    private final class BroadcastHandler extends Handler {
        public BroadcastHandler(Looper looper) {
            super(looper, null, true);
        }

        @Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case BROADCAST_INTENT_MSG: {
                    if (DEBUG_BROADCAST) Slog.v(
                            TAG_BROADCAST, "Received BROADCAST_INTENT_MSG");
                    processNextBroadcast(true);
                } break;
                case BROADCAST_TIMEOUT_MSG: {
                    synchronized (mService) {
                        broadcastTimeoutLocked(true);
                    }
                } break;
            }
        }
    }
    
在finishReceiver的时候取消监控，如果指定时间未收到，则认为超时。

发生ANR的时候，系统会进行dump trace。

```

## 导致ANR的原因：

### 1.应用层

	  a. 函数阻塞：如死循环、主线程IO、处理大数据
	
	  b. 锁出错：主线程等待子线程的锁
	
	  c. 内存紧张：系统分配给一个应用的内存是有上限的，长期处于内存紧张，会导致频繁内存交换，进而导致应用的一些操作超时


### 2.系统层

	  a. CPU被抢占：一般来说，前台在玩游戏，可能会导致你的后台广播被抢占CPU
	
	  b. 系统服务无法及时响应：比如获取系统联系人等，系统的服务都是Binder机制，服务能力也是有限的，有可能系统服务长时间不响应导致ANR
	
	  c. 其他应用占用的大量内存
  
  
## 监控ANR

1. BlockCannary

```java
public static void loop() {
    final Looper me = myLooper();
    if (me == null) {
        throw new RuntimeException("No Looper; Looper.prepare() wasn't called on this thread.");
    }
    final MessageQueue queue = me.mQueue;

    ...

    boolean slowDeliveryDetected = false;

    for (;;) {
        Message msg = queue.next(); // might block
        if (msg == null) {
            // No message indicates that the message queue is quitting.
            return;
        }

        // This must be in a local variable, in case a UI event sets the logger
        final Printer logging = me.mLogging;
        if (logging != null) {
            logging.println(">>>>> Dispatching to " + msg.target + " " +
                    msg.callback + ": " + msg.what);
        }

        ...

        final long dispatchStart = needStartTime ? SystemClock.uptimeMillis() : 0;
        final long dispatchEnd;
        try {
            msg.target.dispatchMessage(msg);
            dispatchEnd = needEndTime ? SystemClock.uptimeMillis() : 0;
        } finally {
            if (traceTag != 0) {
                Trace.traceEnd(traceTag);
            }
        }
        ...

        if (logging != null) {
            logging.println("<<<<< Finished to " + msg.target + " " + msg.callback);
        }

        // Make sure that during the course of dispatching the
        // identity of the thread wasn't corrupted.
        final long newIdent = Binder.clearCallingIdentity();
        if (ident != newIdent) {
            Log.wtf(TAG, "Thread identity changed from 0x"
                    + Long.toHexString(ident) + " to 0x"
                    + Long.toHexString(newIdent) + " while dispatching to "
                    + msg.target.getClass().getName() + " "
                    + msg.callback + " what=" + msg.what);
        }

        msg.recycleUnchecked();
    }
}


Looper.getMainLooper().setMessageLogging {  } 监控第一个任务start,end的时间。
```
优点：使用简单

缺点：有局限性，webview可能会更改这个logger。


2.ANR watchDog

	开启个单独线程向主线程发送一个变量+1的操作，然后休眠一定时间阈值（阈值可自定义，例如5s），
	休眠	过后再判断变量是否已经+1，如果未完成则ANR告警
	    

3.SafeLooper, 通过asm包裹原来的Runnable

4.FileObserver，监控 data/anr目录下 是否有 .trace文件，并且要过滤包名。

5.监听native信号。


## 识别线上ANR：

1.main线程处于 BLOCK、WAITING、TIMEWAITING状态，那基本上是函数阻塞导致ANR；
如果main线程无异常，则应该排查CPU负载和内存环境。


2.waiting to lock <0x01aed1da> (a java.lang.Object) held by thread 3
  主线程被子线程的锁
  常见的就是SharedPreference


3.cpu抢占
  如上日志，第二行是钉钉的进程，占据CPU高达543%，抢占了大部分CPU资源，因而导致发生ANR。


4.内存紧张
  onTrimMemory


5.at android.os.Binder.blockUntilThreadAvailable(Native method)
  前文有讲过：系统的服务都是Binder机制（16个线程），服务能力也是有限的，有可能系统服务长时间不响应导致ANR。如果其他应用占用了所有Binder线程，那么当前应用只能等待。


