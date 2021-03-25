---
title: Self-shortcuts & commands
date: 2020-11-13 16:43:15
categories: Programming
sticky: 4
---
## OD
设置/删除断点(F2)
打开新的可执行程序(F3)

单步步入 Call(F7)
单步步过 Call(F8)

暂停执行 (F12)
运行(F9)
到返回 (Ctrl + F9)
跳过异常 (Shift + F9)

重新运行 (Ctrl + F2)
关闭程序 (Alt + F2)

跟踪步入 Call (Ctrl + F11)
跟踪步过 Call (Ctrl + F12)

撤销修改(Alt + backspace)

查找地址(Ctrl + G)
补丁窗口 (Ctrl + P)
API 函数 (Ctrl + N)
查找二进制字符串 (Ctrl + B)
查找 (Ctrl + L)
查找命令 (Ctrl + F)

显示记录窗口 (Alt + L)
显示模块窗口 (Alt + E)
显示内存窗口 (Alt + M)
显示 CPU 窗口 (Alt + C)
显示呼叫堆栈 (Alt + K)
显示断点窗口 (Alt + B)
调试选项窗口 (Alt + O)


## Markdown grammar
[toc]
#1-6

- “- + *” 与 “1.” 结合
  1. 开头两空格

\ 转义

\[名称](url) 图片前加 !

> 但行好事，莫问前程。
 >>内层引用 前空一格

*我是小妖怪* **吃人不眨眼** `hello world`

\*** --- ___ 分割线

~~删除线~~

\^上标^ \~下标~

```yml
|左|右|居中|
|:--|--:|:-:|
|单|元|格|
```


## Chrome Shortcut
打开主页 Alt + Home
关闭当前窗口 Alt + F4
打开菜单 Alt + f/e
跳转到地址栏 Alt + d

切换用户 Ctrl + shift + m
当前页面补充`www.com` Ctrl + Enter
打开“清除浏览数据”选项 Ctrl + Shift + backspace

打开新窗口 Ctrl + n
无痕打开新窗口 Ctrl + Shift + n
打开跳转新标签页 Ctrl + t
关闭当前标签页 Ctrl + W

跳转到下一个标签页 Ctrl + PgDn
跳转到上一个标签页 Ctrl + PgUp
跳转到特定标签页 Ctrl + 1~8

查找 Ctrl + f 或 F3 (切换 Ctrl + g)
历史 Ctrl + h
下载 Ctrl + j
书签 Ctrl + Shift + o
保存书签 Ctrl + d
保存所有书签 Ctrl + Shift + d
显示/隐藏书签栏 Ctrl + Shift + b

检查 Ctrl + Shift + j/i 或 F12
源代码 Ctrl + u

放大/缩小 Ctrl +/-
恢复大小 Ctrl + 0


## [Windows Shortcut](https://support.microsoft.com/en-us/windows/windows-10-keyboard-tips-and-tricks-588e0b72-0fff-6d3f-aeee-6e5116097942)
Win + 上下左右
任务栏切换 Win + 数字
创建新文件夹 Ctrl + Shift + N

显示桌面 win + d/m
预览桌面 win + ，
表情符号 win + .
显示设置 win + i
文件资源管理器 win + e
左侧工具栏 win + x
右侧设置 Win + a
锁定计算机 Win + L
任务视图 win + tab
轻松使用 win + u
切换输入法 win + 空格 / alt + 左/右 shift
创建虚拟桌面 Win + Ctrl + D
关闭虚拟桌面 Win + Ctrl + F4
切换虚拟桌面 Win + Ctrl + 左/右

设置自启动 win+R 复制，添加快捷键
```yml
%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
```

【ctrl】+【Home】 光标到达txt文本最前面
【ctrl】+【End】 光标到达txt文本最后面

【ctrl】+【shift】+【Home】 选中光标所在位置到txt文本最前面的部分
【ctrl】+【shift】+【End】 选中光标所在位置到txt文本最后面的部分

【ctrl+shift+F】输入法繁简转换


## Vimium Shortcut
向下/上/左/右移动 j/k/h/l
后退/前进网页 H/L
选择左/右标签 J/K
**向下/上跳动 d/u-e**
回到顶/尾部 gg/G

本窗口/新窗口 f/F
刷新 r
创建/查看标签页 t/T(数字nt)
新标签打开多个链接 alt + f
**打开新页面并切换 S**
查找历史书签 o/O
查找书签 b/B

**关闭/恢复标签 x/X-z**
**切换到刚才标签 ^-q**
**移动当前标签到左/右侧边 <<-</>>->**
**将标签页移动到新窗口 W-ww**

搜索剪贴板关键字 在当前/新窗口 p/P
开/关静音 alt + m
固定标签栏 alt + p

**[[,]]-[,] 上/下一页**
yt 复制当前页面
yy 复制当前网址
yf 复制网址拷贝

第一/n 个输入框 ngi
编辑当前网址 ge/gE
显示网页源代码 gs
跳转到当前 url 上一级/最高级 gu/gU
切换到第一个 tab g0
**切换到最后一个 tab g$-g9**

i 插入模式
/ 查找模式
n/N 下/上一个匹配

当页标记 m + 一个小写字母
全局标记 m + 一个大写字母
跳转到当页标记 \`小写字母
跳转到全局标记 \`大写字母


## VS Shortcut
ctrl + shift + a 新建项
alt + shift + a 现有项
ctrl + d 复制上一行
ctrl + b 生成

F10 逐过程
F11 逐语句
ctrl + alt + d 反汇编
ctrl + backspace 删除整行


## git & hexo
```yml
npm install hexo-deployer-git --save
```
`hexo clean`
`hexo s -o` 实时预览
`hexo d -g` 生成部署
`hexo new "post"` 新建文章
`hexo new page "page"` 新建页面
---

### theme update
```git
git add . //更新工作的状态树
git stash //将未提交修改保存至堆栈中
git pull  //获取更新
git stash pop //弹栈
```
---

### hexo Upgrade
```yml
npm -v
node -v
hexo -v

npm install npm@latest -g  //npm更新
[node](https://nodejs.org/zh-cn/download/) 下载覆盖安装

npm install -g npm-check     //安装 npm-check
npm-check                    //查看系统插件是否需要升级
npm install -g npm-upgrade   //安装 npm-upgrade
npm-upgrade                  //更新 package.json
//在执行 npm-upgrade 命令后会要求输入 yes 或 no ，直接输入 Y 即可
npm update -g                //更新全局插件
npm update --save            //更新系统插件
```
---

`git init`
`git status`
`git add filename`
`git commit -m "commit filename"`
`git log` 按 Q 退出
`git branch [a] [-d/D a]` 新建分支 a / 删除/强制删除分支 a
`git push origin --delete` 删除远程分支
`git checkout [a] [v1] [-b b]` 切换到 a 分支 / v1 标签 / 创建并切换到 b 分支
`git merge [a]` 将 a 分支合并到 master 分支
`git tag [v1]` 添加标签
`git remote add origin url` 关联远程仓库
`git pull/push origin master:djs` 拉/推 远程主机名 远程分支名:本地分支名
---

### 删除所有远程标签
```yml
git show-ref --tag | awk '{print ":" $2}' | xargs git push origin
```

### 删除所有本地标签
```yml
git tag -l |awk '/1\.1\../' | xargs git tag -d
```

### 从远程仓库获取所有分支
```yml
git clone xxx
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote";
git fetch --all
git pull --all
```

### 合并两个仓库
现在有两个仓库 kktjs/kkt 和 kktjs/kkt-next 我们需要将 kkt-next 仓库合并到 kkt 并保留 kkt-next 的所有提交内容。

> 1.克隆主仓库代码
```yml
git clone git@github.com:kktjs/kkt.git
```
> 2.将 kkt-next 作为远程仓库，添加到 kkt 中，设置别名为 other
```yml
git remote add other git@github.com:kktjs/kkt-next.git
```
> 3.从 kkt-next 仓库中拉取数据到本仓库
```yml
git fetch other
```
> 4.将 kkt-next 仓库拉取的 master 分支作为新分支 checkout 到本地，新分支名设定为 kkt-next
```yml
git checkout -b kkt-next other/master
```
> 5.切换回 kkt 的 master 分支
```yml
git checkout master
```
> 6.将 kkt-next 合并入 kkt 的 master 分支
```yml
git merge kkt-next
```
> 如果第 6 步报错 `fatal: refusing to merge unrelated histories`，执行下面：
```yml
git merge kkt-next --allow-unrelated-histories
```
在合并时有可能两个分支对同一个文件都做了修改，这时需要解决冲突，对文本文件来说很简单，根据需要对冲突的位置进行处理就可以。对于二进制文件，需要用到如下命令:
```yml
git checkout --theirs YOUR_BINARY_FILES     # 保留需要合并进来的分支的修改
git checkout --ours YOUR_BINARY_FILES       # 保留自己的修改
git add YOUR_BINARY_FILES
```
---

### 创建密钥
```yml
ssh-keygen -t rsa
```
```yml
ssh -T git@github.com
```

### 别名
```yml
git config --global alias.plm 'pull origin master'
```
```yml
git config --global alias.psm 'push origin master'
```

### 其他配置
```yml
git config -l
```
```yml
git log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
```
```yml
git config --global http.http://github.com.proxy 127.0.0.1:10808
```
```yml
git config --global https.https://github.com.proxy 127.0.0.1:10808
```

### Failed to connect to github.com port 443: Operation timed out
`/etc/hosts` 把 GitHub 相关的几行代码注释掉，保存 hosts 文件
这种的 #192.30.253.112 github.com

### Failed to connect to 127.0.0.1 port 1080: Connection refused
查询是否使用代理：
```yml
git config --global http.proxy
```
取消代理：
```yml
git config --global --unset http.proxy
```

> https://blog.csdn.net/qq_35246620/article/details/66973794


## [GitHub](https://www.zhihu.com/question/36974348)
shift + / 查看快捷键

在github上任意项目加个"gh-pages"分支，通过github page/你项目的名称就可以访问到那个分支的静态文件
issue 模板 https://github.blog/2016-02-17-issue-and-pull-request-templates/
小绿点可以通过修改系统时间再commit来控制形状。

github.githistory.xyz

Site wide shortcuts
s or / Focus the search bar.

g n	Go to your notifications.

esc	When focused on a user, issue, or pull request hovercard, closes the hovercard and refocuses on the element the hovercard is in

Repositories
g c	Go to the Code tab

g i	Go to the Issues tab. 

g p	Go to the Pull requests tab.

g a	Go to the Actions tab.

g b	Go to the Projects tab.

g w	Go to the Wiki tab.

Source code editing
e	Open source code file in the Edit file tab

control f or command f	Start searching in file editor

control g or command g	Find next

shift control g or shift command g	Find previous

shift control f or command option f	Replace

shift control r or shift command option f	Replace all

alt g	Jump to line

control z or command z	Undo

control y or command y	Redo

cmd + shift + p	Toggles between the Edit file and Preview changes tabs

Source code browsing
t	Activates the file finder

l	Jump to a line in your code

w	Switch to a new branch or tag

y	Expand a URL to its canonical form

i	Show or hide comments on diffs.

a	Show or hide annotations on diffs

b	Open blame view.


## Vim
|左|右|居中|
|:-|:-|:-|
|单|元|格|

ctrl + f/b/d/u 向下/上移动一/半页
+/- 移动到非空白字符下/上一列
n空格 向右移动 n 字符
n回车 向下移动 n 行
0/Home $/End 移动到这一列最前/后面字符处
H/M/L 移动到屏幕最上方/中间/下方那一列的第一个字符
nG 移动到这个文件的第 n 列
/? 向下/上搜索

:n1,n2s/word1/word2/g 在第 n1 与 n2 列之间寻找 word1 字串，并将该字串取代为 word2
:1,$s/word1/word2/g / gc 从第一列到最后一列寻找 word1 字串，并将该字串取代为 word2 / 在取代前显示提示字符给使用者确认是否需要取代

nx(del)/nX(backspace) 向后/前删除 n 个字符
ndd 删除光标所在的一整行/向下 n 行
nyy 复制光标所在的那一行/向下 n 行
p/P 将已复制数据在光标下/上一列贴上

J 将光标所在列与下一列的数据结合成同一列
c 重复删除多个数据，例如向下删除 10 列，10cj
u 复原前一个动作
Ctrl + r 重做上一个动作
. 重复前一个动作

i/I 从目前光标处插入/在目前所在列的第一个非空白字符处开始插入
a/A 从目前光标所在的下一个字符处插入/从光标所在列的最后一个字符处插入
o/O 在目前光标所在的下/上一列处插入新的一列
r/R 取代模式，取代光标所在的那一个字符一次/一直取代光标所在的文字，直到 ESC

:w 写入硬盘文件
:q! （强制离开不储存）离开
:wq 储存后离开
ZZ 文件没有更动，则不储存离开/文件已经更动过，则储存后离开
:w file 另存新文件
:r file 在编辑的数据中，读入另一个文件的数据
:n1,n2 w file 将 n1 到 n2 的内容储存成 file
:! command 暂时离开 vi 到命令行界面下执行 command 的显示结果

:set nu 显示行号
:set nonu 取消行号
:set	hlsearch	:setnohlsearch 高亮度搜寻
:set	autoindent	:set noautoindent 自动缩排
（setting）
自建 ~/.vimrc 
[dmtsai@study	~]$	vim	~/.vimrc
"这个文件的双引号	（"）	是注解
set	hlsearch												"高亮度反白
set	backspace=2									"可随时用倒退键删除
set	autoindent										"自动缩排
set	ruler															"可显示最后一列的状态
set	showmode												"左下角那一列的状态
set	nu																		"可以在每一列的最前面显示行号啦！
set	bg=dark													"显示不同的底色色调
syntax	on															"进行语法检验，颜色显示。



:files 列出目前这个 vim 的打开的所有文件 :n/N
:sp {filename} 多窗口 ctrl + w + j/k 先按下	[ctrl]	不放，	再按下	w	后放开所有的按键，然后再按下	j	（或向下方向键），则光标可移动到下方的窗口
[ctrl]+x	->	[ctrl]+n 通过目前正在编辑的这个“文件的内容文字”作为关键字，予以补齐
[ctrl]+x	->	[ctrl]+f 以当前目录内的“文件名”作为关键字，予以补齐
[ctrl]+x	->	[ctrl]+o 以扩展名作为语法补充，以	vim	内置的关键字，予以补齐


按下‘q’键让vim开始记录，然后按任意键，来告诉vim你想把保存的记录下次通过这个键来调出。本次案例中，这个键设置为‘a’，所以完整的指令就是‘qa’。
执行你的命令。
按下‘q’来结束记录。
需要重复保存的系列动作时，输入‘@a’即可。

相对行号
.vimrc中加入set relativenumber
删除其后的25行：25dd

.vimrc中加入以下指令：
set clipboard=unnamed 
set clipboard=unnamedplus 
加入这项指令后，在vim中复制粘贴文本就从“CTRL+V”, 和“CTRL+C”这一过程变为简单地输入‘p’。
如果你想在不重写你的寄存器的情况下删除文本，你可以在指令前加上“_符号：“_dd 来删除一行。

重映射Escape操作
.vimrc中加入：
cnoremap kj <C-C> 
cnoremap jk <C-C> 
键入’jk’或者‘kj’来离开一个指令

动词+修饰词+宾语

处理空白格(White space fixing)
.vimrc加入：
set list
这个指令会在每行结尾显示一个$符号，并且用^I代替tabs。你从而能更容易地识别出tabs和行尾。除此之外，下面的例子中，使用了空代替所有的tabs，这也让空白格更加便于处理：

快速查找(navigate)
敲击‘gg’来移动到文档的顶部，‘G’来移动到最底部。
敲击CTRL+F来快速向前移动，CTRL+B来快速向后移动。
敲击‘zz’来重新定位页的中心，这也你的光标就成为新的中心。
遇到上括号像‘{’或者‘(’，你可以敲击‘%’来移动到它们所匹配的下括号。
‘/’可以开始查找你想要的词。

日期(date)
nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc> 
imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR> 
从而可以只通过键入F3来给文档加日期和时间。

x → 删当前光标所在的一个字符。
:wq → 存盘 + 退出 (:w 存盘, :q 退出)   （陈皓注：:w 后可以跟文件名）
dd → 删除当前行，并把删除的行存到剪贴板里
p → 粘贴剪贴板
:help <command> → 显示相关命令的帮助。你也可以就输入 :help 而不跟命令。（陈皓注：退出帮助需要输入:q）

a → 在光标后插入
o → 在当前行后插入一个新行
O → 在当前行前插入一个新行
cw → 替换从光标所在位置后到一个单词结尾的字符

0 → 数字零，到行头
^ → 到本行第一个不是blank字符的位置（所谓blank字符就是空格，tab，换行，回车等）
$ → 到本行行尾
g_ → 到本行最后一个不是blank字符的位置。
/pattern → 搜索 pattern 的字符串（陈皓注：如果搜索出多个匹配，可按n键到下一个）

P → 粘贴
yy → 拷贝当前行当行于 ddP
p/P都可以，p是表示在当前位置之后，P表示在当前位置之前）

u → undo
<C-r> → redo

:e <path/to/file> → 打开一个文件
:w → 存盘
:saveas <path/to/file> → 另存为 <path/to/file>
:x， ZZ 或 :wq → 保存并退出 (:x 表示仅在需要时保存，ZZ不需要输入冒号并回车)
:q! → 退出不保存 :qa! 强行退出所有的正在编辑的文件，就算别的文件有更改。
:bn 和 :bp → 你可以同时打开很多文件，使用这两个命令来切换下一个或上一个文件。（陈皓注：我喜欢使用:n到下一个文件）

. → (小数点) 可以重复上一次的命令
N<command> → 重复某个命令N次

NG → 到第 N 行 （陈皓注：注意命令中的G是大写的，另我一般使用 : N 到第N行，如 :137 到第137行）
gg → 到第一行。（陈皓注：相当于1G，或 :1）
G → 到最后一行。
w → 到下一个单词的开头。
e → 到下一个单词的结尾。
如果你认为单词是由默认方式，那么就用小写的e和w。默认上来说，一个单词由字母，数字和下划线组成（陈皓注：程序变量）
> 如果你认为单词是由blank字符分隔符，那么你需要使用大写的E和W。（陈皓注：程序语句）

% : 匹配括号移动，包括 (, {, [. （陈皓注：你需要把光标先移到括号上）
* 和 #:  匹配光标当前所在的单词，移动光标到下一个（或上一个）匹配单词（*是下一个，#是上一个）

<start position><command><end position>
0y$ 命令意味着：
0 → 先到行头
y → 从这里开始拷贝
$ → 拷贝到本行最后一个字符

d (删除 )
v (可视化的选择)
gU (变大写)
gu (变小写)
可视化选择是一个很有意思的命令，你可以先按v，然后移动光标，你就会看到文本被选择，然后，你可能d，也可y，也可以变大写等）

在当前行上移动光标:
0 → 到行头
^ → 到本行的第一个非blank字符
$ → 到行尾
g_ → 到本行最后一个不是blank字符的位置。
fa → 到下一个为a的字符处，你也可以fs到下一个为s的字符。
t, → 到逗号前的第一个字符。逗号可以变成其它字符。
3fa → 在当前行查找第三个出现的a。
F 和 T → 和 f 和 t 一样，只不过是相反方向。

dt" → 删除所有的内容，直到遇到双引号—— "

区域选择
在visual 模式下
<action>a<object> 和 <action>i<object>
action可以是任何的命令，如 d (删除), y (拷贝), v (可以视模式选择)。
object 可能是： w 一个单词， W 一个以空格为分隔的单词， s 一个句字， p 一个段落。也可以是一个特别的字符："、 '、 )、 }、 ]。

假设你有一个字符串 (map (+) ("foo")).而光标键在第一个 o 的位置。

vi" → 会选择 foo.
va" → 会选择 "foo".
vi) → 会选择 "foo".
va) → 会选择("foo").
v2i) → 会选择 map (+) ("foo")
v2a) → 会选择 (map (+) ("foo"))

块操作，典型的操作： 0 <C-v> <C-d> I-- [ESC]

^ → 到行头
<C-v> → 开始块操作
<C-d> → 向下移动 (你也可以使用hjkl来移动光标，或是使用%，或是别的)
I-- [ESC] → I是插入，插入“--”，按ESC键来为每一行生效。

自动提示： <C-n> 和 <C-p>
在 Insert 模式下，你可以输入一个词的开头，然后按 <C-p>或是<C-n>，自动补齐功能就出现了……


宏录制： qa 操作序列 q, @a, @@
qa 把你的操作记录在寄存器 a。
于是 @a 会replay被录制的宏。
@@ 是一个快捷键用来replay最新录制的宏。

在一个只有一行且这一行只有“1”的文本中，键入如下命令：

qaYp<C-a>q→
qa 开始录制
Yp 复制行.
<C-a> 增加1.
q 停止录制.
@a → 在1下面写下 2
@@ → 在2 正面写下3
现在做 100@@ 会创建新的100行，并把数据增加到 103.


可视化选择： v,V,<C-v>
前面，我们看到了 <C-v>的示例 （在Windows下应该是<C-q>），我们可以使用 v 和 V。一但被选好了，你可以做下面的事：

J → 把所有的行连接起来（变成一行）
< 或 > → 左右缩进
= → 自动给缩进
在所有被选择的行后加上点东西：

<C-v>
选中相关的行 (可使用 j 或 <C-d> 或是 /pattern 或是 % 等……)
$ 到行最后
A, 输入字符串，按 ESC。


分屏: :split 和 vsplit
:help split
:split → 创建分屏 (:vsplit创建垂直分屏)
<C-w><dir> : dir就是方向，可以是 hjkl 或是 ←↓↑→ 中的一个，其用来切换分屏。
<C-w>_ (或 <C-w>|) : 最大化尺寸 (<C-w>| 垂直分屏)
<C-w>+ (或 <C-w>-) : 增加尺寸

https://coolshell.cn/articles/11312.html#%E7%AA%97%E5%8F%A3%E5%88%86%E5%B1%8F%E6%B5%8F%E8%A7%88


## Linux
观察系统的使用状态：	如果要看目前有谁在线上，可以下达“who”这个指令，而如果要看
网络的连线状态，可以下达	“	netstat	-a	”这个指令，而要看背景执行的程序可以执行“	ps
-aux	”这个指令。

chgrp	：改变文件所属群组
chown	：改变文件拥有者
chmod	：改变文件的权限,	SUID,	SGID,	SBIT等等的特性

因此FHS标准建议：根目录（/）所在分区应该越小越好，	且应用程序所安装的软件最好不要
与根目录放在同一个分区内，保持根目录越小越好。	如此不但性能较佳，根目录所在的文件
系统也较不容易发生问题。

其实usr是Unix	Software	Resource的缩写，	也就
是“Unix操作系统软件资源”所放置的目录

.									代表此层目录
..								代表上一层目录
-									代表前一个工作目录
~									代表“目前使用者身份”所在的主文件夹
~account		代表	account	这个使用者的主文件夹（account是个帐号名称

cd：变换目录
pwd：显示目前的目录-P		：显示出确实的路径，而非使用链接	（link）	路径。
mkdir：创建一个新的目录-m	：设置文件的权限喔！直接设置，不需要看默认权限	（umask）	的脸色～
-p	：帮助你直接将所需要的目录（包含上层目录）递回创建起来！
rmdir：删除一个空的目录-p	：连同“上层”“空的”目录也一起删除

将	ll	（L	的小写）	设置成为	ls	-l	

cat	由第一行开始显示文件内容
tac	从最后一行开始显示，可以看出	tac	是	cat	的倒着写！
nl	显示的时候，顺道输出行号！
more	一页一页的显示文件内容
less	与	more	类似，但是比	more	更好的是，他可以往前翻页！
head	只看头几行
tail	只看尾巴几行
od	以二进制的方式读取文件内容！

echo password	|	od	-t	oCc	echo  ASCII	对照

如果你还想要从文字压缩文件当中找数据的话，可以通过	egrep	来搜寻关键字喔！而
不需要将压缩文件解开才以	grep	进行！	这对查询备份中的文本文件数据相当有用！

另外值得一提的是，tar	打包出来的文件有没有进行压缩所得到文件称呼不同喔！	如果仅是打
包而已，就是“	tar	-cv	-f	file.tar	”而已，这个文件我们称呼为	tarfile	。	如果还有进行压缩的支
持，例如“	tar	-jcv	-f	file.tar .bz2	”时，我们就称呼为	tarball	


linux cat/proc/cpuinfo及Ispci命令
- Ctrl + Alt + F1\~F6
变量\~符号代表的是“使用者的主文件夹”



^M$ CRLF 转换成 LF
#	mount	/dev/sr0	/mnt
#	rpm	-ivh	/mnt/Packages/dos2unix-*
# umount	/mnt
#	exit
(transformer)

bash
[ctrl]+u/[ctrl]+k 分别是从光标处向前删除指令串	（[ctrl]+u）	及向后删除指令串（[ctrl]+k）。
[ctrl]+a/[ctrl]+e 分别是让光标移动到整个指令串的最前面	（[ctrl]+a）	或最后面（[ctrl]+e）。

echo	$PATH echo	${HOME}
(base)
变量与变量内容以一个等号“=”来链接
等号两边不能直接接空白字符
变量名称只能是英文字母与数字，但是开头字符不能是数字

如你想要让该变量内容继续的在子程序中使用，那么就请执行： export	变量名称

环境变量转成自订变量 declare
declare	/	typeset

基本上，指令运行的顺序可以这样看
1 .	 以相对/绝对路径执行指令，例如“	/bin/ls	”或“	./ls	”；
2 .	 由	alias	找到该指令来执行；
3 .	 由	bash	内置的	（builtin）	指令来执行；
4 .	 通过	$P A TH	这个变量的顺序搜寻到的第一个指令来执行。
通过	type	-a	ls 查询

bash	的进站与欢迎讯息(bash12)

1 .	 标准输入　　（stdin）	：代码为	0	，使用	<	或	<<	；
2 .	 标准输出　　（stdout）：代码为	1	，使用	>	或	>>	；
3 .	 标准错误输出（stderr）：代码为	2	，使用	2>	或	2>>	；

1>	：以覆盖的方法将“正确的数据”输出到指定的文件或设备上；
1>>：以累加的方法将“正确的数据”输出到指定的文件或设备上；
2>	：以覆盖的方法将“错误的数据”输出到指定的文件或设备上；
2>>：以累加的方法将“错误的数据”输出到指定的文件或设备上；

/dev/null	垃圾桶黑洞设备与特殊写法

cmd	;	cmd	（不考虑指令相关性的连续指令下达）
$?	（指令回传值）	与	&&	或	||
(bash17)

管线命令	（pipe）
管线命令仅会处理	standard	output，对于	standard	error	output	会予以忽略
管线命令必须要能够接受来自前一个指令的数据成为	standard	input	继续处理才行。

撷取命令：	cut,	grep
(bash18)
cut在处理多空格相连的数据时，可能会比较吃力一点

排序命令：	sort,	wc,	uniq
双向重导向：	tee
字符转换命令：	tr ,	col,	join,	paste,	expand
tr	可以用来删除一段讯息当中的文字，或者是进行文字讯息的替换！

join	看字面上的意义	（加入/参加）	就可以知道，他是在处理两个文件之间的数据，	而且，
主要是在处理“两个文件当中，有	"相同数据"	的那一行，才将他加在一起”的意思。我们利用
下面的简单例子来说明：
在使用	join	之前，你所需要处理的文件应该要事先经过排序
（sort）	处理！	否则有些比对的项目会被略过呢

这个	paste	就要比	join	简单多了！相对于	join	必须要比对两个文件的数据相关性，	paste	就
直接“将两行贴在一起，且中间以	[tab]	键隔开”而已

分区命令：	split
参数代换：	xargs
xargs	是在做什么的呢？就以字面上的意义来看，	x	是加减乘除的乘号，args	则是
arguments	（参数）	的意思，所以说，这个玩意儿就是在产生某个指令的参数的意思！
xargs	可以读入	stdin	的数据，并且以空白字符或断行字符作为分辨，将	stdin	的数据分隔成
为	arguments	。	因为是以空白字符作为分隔，所以，如果有一些文件名或者是其他意义的名
词内含有空白字符的时候，	xargs	可能就会误判了～他的用法其实也还满简单的！就来看一
看先！

正则表达式	（Regular	Expression,	RE
（bash19）568

shell script
直接指令下达：	shell.sh	文件必须要具备可读与可执行	（rx）	的权限，然后：
绝对路径：使用	/home/dmtsai/shell.sh	来下达指令；
相对路径：假设工作目录在	/home/dmtsai/	，则使用	./shell.sh	来执行
变量“P A TH”功能：将	shell.sh	放在	P A TH	指定的目录内，例如：	~/bin/
以	bash	程序来执行：通过“	bash	shell.sh	”或“	sh	shell.sh	”来执行

var=$（（运算内容））

执行方式差异
利用直接执行的方式来执行	script
当使用前一小节提到的直接指令下达	（不论是绝对路径/相对路径还是	${P A TH}	内），或者是
利用	bash	（或	sh）	来下达脚本时，	该	script	都会使用一个新的	bash	环境来执行脚本内的
指令！也就是说，使用这种执行方式时，	其实	script	是在子程序的	bash	内执行的
利用	source	来执行脚本：在父程序中执行

利用	test	指令的测试功能
（608-633）


计算	Linux	日期的时间是以	1970	年	1月	1	日作为	1	而累加的日期

touch file
groups 有效与支持群组的观察
newgrp:	有效群组的切换
exit			#	注意！记得离开	newgrp	的环境喔！

（user）
如果想要完整的将某个帐号完整的移除，最好可以在下达	userdel	-r	username	之前，	先以“	find	/	-user	username	”查出整个系统内属于	username	的文件，然后再加以删除吧！
id finger默认不安装
chfn	有点像是：	change	finger	的意思
chsh  change	shell	的简写

(grp)
最好能够使用“	groupadd	-r	群组名”的方式来创建

(su)
su	就这样简单的介绍完毕，总结一下他的用法是这样的：
若要完整的切换到新使用者的环境，必须要使用“	su	-	username	”或“	su	-l	username	”，
才会连同	P A TH/USER/MAIL	等变量都转成新使用者的环境；
如果仅想要执行一次	root	的指令，可以利用“	su	-	-c	"指令串"	”的方式来处理；
使用	root	切换成为任何使用者时，并不需要输入新使用者的密码；

仅有规范到	/etc/sudoers	内的用户才能够执行	sudo	这个指令
(sudo)
visudo	与	/etc/sudoers

last	可以列出从系统创建之后到目前为止的所有登陆者信息
目前已登陆在系统上面的使用者呢？可以通过	w	或	who	来查询
如果您想要知道每个帐号的最近登陆的时间，则可以使用	lastlog	这个指令喔！	lastlog会去读取	/var/log/lastlog	文件

使用者对谈：	write,	mesg,	wall
write	使用者帐号	[使用者所在终端接口]
[crtl]-d	来结束输入
mesg	n/y 不接受信息
#	wall	"I	will"
mail	-s	"邮件标题"	username@localhost
结束时，最后一行输入小数点	.
（mail）

帐号相关的检查工具
pwck	这个指令在检查	/etc/passwd	这个帐号配置文件内的信息，与实际的主文件夹是否存在
等信息，	还可以比对	/etc/passwd	/etc/shadow	的信息是否一致，另外，如果	/etc/passwd	内
的数据字段错误时，会提示使用者修订。	一般来说，我只是利用这个玩意儿来检查我的输入
是否正确就是了。
群组查询 grpck
pwconv 这个指令主要的目的是在“将	/etc/passwd	内的帐号与密码，移动到	/etc/shadow	当中
chpasswd	是个挺有趣的指令，他可以“读入未加密前的密码，并且经过加密后，	将加密后的密码写入	/etc/shadow	当中
echo	"vbird3:abcdefg"	|	chpasswd

Tarball
Makefile	怎么写？	通常软件开发商都会写一支
侦测程序来侦测使用者的作业环境，	以及该作业环境是否有软件开发商所需要的其他功能，
该侦测程序侦测完毕后，就会主动的创建这个	Makefile	的规则文件啦！通常这支侦测程序的
文件名为	configure	或者是	config	。

所谓的	T arball	文件，其实就是将软件的所有源代码文件先以	tar	打包，然后再以压缩技术来
压缩，通常最常见的就是以	gzip	来压缩了。因为利用了	tar	与	gzip	的功能，所以	tarball	文件
一般的扩展名就会写成	.tar .gz	或者是简写为	.tgz	啰！不过，近来由于	bzip2	与	xz	的压缩率
较佳，所以	T arball	渐渐的以	bzip2	及	xz	的压缩技术来取代	gzip	啰！因此文件名也会变成
.tar .bz2,	.tar .xz	之类

T arball	是一个软件包，	你将他解压缩之后，里面的文件
通常就会有：
原始程序码文件；
侦测程序文件	（可能是	configure	或	config	等文件名）；
本软件的简易说明与安装说明	（INST ALL	或	README）。

使用	gcc	编译时所加入的那个	-lm	是有意义的，他可以拆开成两部份来看：
-l	：是“加入某个函数库（library）”的意思，
m	：则是	libm.so	这个函数库，其中，	lib	与扩展名（.a	或	.so）不需要写
所以	-lm	表示使用	libm.so	（或	libm.a）	这个函数库的意思～至于那个	-L	后面接的路径呢？
这表示：	“我要的函数库	libm.so	请到	/lib	或	/lib64	里面搜寻！”
(1021-1091)






## Google hack
"" 精确匹配
-  排除关键词
.. 数字范围
*  通配符
and/or
filetype:  查找文件
site:  站内搜索
info:  基本信息
link:  含链接站
define:  单词含义
related:  域名相关站点
intext:  包含关键词页面


## 微软日语输入法
清音（以平假名为例，片假名是一样的）
あ a い i う u え e お o
か ka き ki く ku け ke こ ko
さ sa し shi す su せ se そ so
た ta ち chi つ tsu て te と to
な na に ni ぬ nu ね ne の no
は ha ひ hi ふ fu へ he ほ ho
ま ma み mi む mu め me も mo
や ya ゐ wi ゆ yu ゑ we よ yo
ら ra り ri る ru れ re ろ ro
わ wa を wo ん nn
·浊音
が ga ぎ gi ぐ gu げ ge ご go
ざ za じ ji ず zu ぜ ze ぞ zo
だ da ぢ di づ du で de ど do
ば ba び bi ぶ bu べ be ぼ bo
ぱ pa ぴ pi ぷ pu ぺ pe ぽ po
·拗音
诸如きゃ、きゅ、きょ，可输入kya、kyu、kyo。
把第一个字的母音去掉即可。
·其他
诸如てゃ、てぃ（ティ）、てゅ，可输入tha、thi、thu。

2、促音（小つ）将后面的子音重写两个来表示。如：国家（こっか）kokka、雑志（ざっし）zasshi。但在つ的前面则加“t”来表示，
如：発着（はっちゃく）hatchaku。（但在输入时仍应输入hacchaku）

|Alt + ~|英文假名切换|Alt/Ctrl/Shift + Caps Lock|片假名/平假名/英文平假名|
|:-|:-|:-|:-|
|F6|平假名|F7/F8|全/半角片假名|
|F9/F10|全/半角英文数字|F5|偏旁发音输入|
|きごう + F5|所有记号|たんい|单位符号|
|すうがく|数学符号|ぎりしゃ|希腊字母符号|
|前 x/l|小假名|ゐ 输入 wi|ゑ 输入 we|
|||||
|||||



