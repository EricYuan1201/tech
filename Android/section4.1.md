# 引用类型

## 参考文档
彻底理解堆外内存：
https://www.jianshu.com/p/0c5941cee075

引用类型：
https://www.cnblogs.com/nullzx/p/7406151.html

## 概念
### 1.什么是堆外内存

由JVM直接分配的内存是堆内内存，不由JVM控制的内存就是堆外内存，有点类似c分配的机器内存。

### 2.堆外内存有什么用？

![2022-11-01_d05c0d17db85.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img/2022-11-01_d05c0d17db85.jpg)

1.主要还是为了减少GC压力，GC的时候会导致一些框架延迟时间增加。

2.减少复制次数
> jvm内存必须先复制到堆外，然后才能和底层socket进行交互
  因为jvm gc导致内存地址变化，必须要使用堆外内存才行）

### 使用方式：
ByteBuffer

![2022-11-01_96b988cccbee.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img/2022-11-01_96b988cccbee.jpg)

### 核心API：
1.

```java
1.创建堆外内存
public static ByteBuffer allocateDirect(int capacity) {
    return new DirectByteBuffer(capacity);
}
2.在构造里面创建了虚引用，同时有一个runnable
cleaner = Cleaner.create(this, new Deallocator(base, size, cap));
3.当GC回收的时候，ByteBuffer被回收了。
  虚引用就会没有引用对象了，z执行clean方法，释放堆外内存。
```

### 堆外内存和虚引用：

	ByteBuffer directByteBuffer = ByteBuffer.allocateDirect(1024);
	分配堆外内存，ByteBuffer保存了堆外地址。
	GC发生了用于通知堆外内存进行回收空间。
	PhantomReference

## 总结

	强引用：即使是OOM也不会被回收
	软引用：内存不足的时候才进行回收软引用关联的对象。
	弱引用：GC的时候就进行回收弱引用关联的对象。
	虚引用：用于管理堆外内存

![2022-12-13_61a1f06d2a12.jpg](https://cdn.jsdelivr.net/gh/EricYuan1201/img@main/2022-12-13_61a1f06d2a12.jpg)

**其实本意是控制一些对象的回收优先级。引用的对象回收之后，这些引用也需要进行回收。**

<font color="#dd0000">**软引用、弱引用都非常适合来保存那些可有可无的缓存数据。如果这么做，当系统内存不足时，这些缓存数据会被回收，不会导致内存溢出。而当内存资源充足时，这些缓存数据又可以存在相当长的时间，从而起到加速系统的作用。**</font>

**可以使用referenceQueue，当引用的对象要被回收的时候，会把这些引用添加到一个reference Queue里面，然后再手动释放这些引用对象。**

## WeakHashMap使用：

	1.Entry继承了WeakReference
	2.当entry不被使用且被GC之后，entry就会进入到referenceQueue
	3.当调用get, put的时候会清空这些被回收的entry。

核心代码：

```java
private void expungeStaleEntries() {
    for (Object x; (x = queue.poll()) != null; ) {
        synchronized (queue) {
            @SuppressWarnings("unchecked")
                Entry<K,V> e = (Entry<K,V>) x;
            int i = indexFor(e.hash, table.length);

            Entry<K,V> prev = table[i];
            Entry<K,V> p = prev;
            while (p != null) {
                Entry<K,V> next = p.next;
                if (p == e) {
                    if (prev == e)
                        table[i] = next;
                    else
                        prev.next = next;
                    // Must not null out e.next;
                    // stale entries may be in use by a HashIterator
                    e.value = null; // Help GC
                    size--;
                    break;
                }
                prev = p;
                p = next;
            }
        }
    }
}
```