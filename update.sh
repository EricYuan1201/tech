cd /Users/ylw/Desktop/gitbook
gitbook build ./ docs   //发布书籍
sleep 1
git add .
git commit -m "update"
git push -f
