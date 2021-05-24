# on 2021.4.18 by xcbyao
echo 'auto-update.sh from https://www.zhihu.com/question/38962022/answer/113416387'
echo '----------------------------------------------------------------------------'
hexo d -g && git add . && git commit -m auto-update && git push origin hexo