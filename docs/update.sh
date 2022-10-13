gitbook init
sleep 1
gitbook build ./ docs   //发布书籍
sleep 1
git add .
git commit -m "update"
git push -f
