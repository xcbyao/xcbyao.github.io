---
title: 写作规范 & 代码风格
date: 2023-04-20 14:03:25
categories: Self-improvement
---
# Pref

模板化文章结构，重塑写作规范，整理代码风格。

# 写作规范

## 命名

文件名、文件夹名：小写字母，下划线代替空格

## 空格

英文、数字、超链接
数字与单元之间
°／% 与数字之间不加
英文前后接全角符号或单位符号时不加

## 标点

引号使用直角引号「『』」
不重复使用同一标点
省略号……
不建议使用~
中文句中出现英文，全用中文标点
引用部分不变动

## 专有名词

名称过长可自定缩写，但需注明「全称，下同」
品牌和应用名称不需要加「」
称呼 app 时，用「应用/应用程序/app」，而非「软件/程序」

## 格式

学会放弃 Word 文档的写作习惯，不过度使用加粗、斜体、删除线、引用
不要用「斜体」作为强调

## 注明引用来源

如有必要做概念解析，首选维基百科
图片来源非 CC0，参考使用「图片来自 XX」
注明作者及原文链接，注意使用第一来源

设置电脑自定义短语「yh」第四五位固定为「」『』

# 代码规范

## 变量命名

小驼峰：`myAge`，第一个单词首字母小写，后面大写（Java、Go、C++）

大驼峰：`MyAge`，首字母都大写（Java、Go、C++：类名、函数、属性名）

下划线：`my_age`（python，Linux 下 C/C++）

## 水平留白

操作符 `i = i + 1;`

分隔符（, ;） `int i, j;`

控制语句（while，if，for）后有一个空格，大括号和函数同行，并有一个空格 `while () {`

## 缩进

将制表符转换成四个空格，不要混合使用（python）

## 行长

建议每行不超过 80 字符，可设置垂直参考线（python）

## 函数编写

小写字母和下划线；（python）
函数定义后紧跟文档字符串格式的注释，描述函数功能；
形参指定默认值，调用关键字实参，等号两边不要有空格。
```python
# 形参过长分行标准
def function_name(
    """函数功能，此处建议用双引号，其他多行注释用单引号"""
        parameter_0, parameter_1, parameter_2,
        parameter_3, parameter_4='eli'):
    function body
```

## 类编写

实例名和模块名：小写、下划线（python）
类中，可使用一个空行来分隔方法；
模块中，可使用两个空行来分隔类。
先导入标准库，再导入自编模块，之间一个空行。


## todo











---

# Obsidian

![](/images/obsidian.jpg)

> Calender
> Outliner
> Dataview
> kanban
> Advanced Tables
> Auto Link Title
> 粘贴互联网链接的时候自动提取页面的标题
> Link Favicons
> 外部链接显示网站的 Favicons，一个很小的增强但也不错。
> Mousewheel Image Zoom
> 滚轮缩放图片，可以直接把图片大小写进 Markdown，排版的时候很方便。
> Customizable Sidebar
> 可以自己在侧边的 Ribbon 中增加按钮，链接功能。我添加了「在默认应用中打开」功能，还是挺方便的。
> Find and replace in selection
> 如字面意思，只在选中的区域进行查找和替换。
> Remember Cursor Position
> 记住上次打开文件时光标的位置。当然了笔记是不推荐太长的，不过如果你比较习惯这样子可以试试。
> Shortcuts Extender
> 这个我就没放在快捷操作里面了，Ctrl+1 变成标题一，Ctrl+2 变成 Heading2，跟 Confluence 的使用习惯是一样的，我觉得比 Markdown 语法还方便一点。
> File tree alternative plugin
> 方便浏览器的层层打开模式，适用于需要反复编辑同一文件夹里面内容的时候。
> Fullscreen mode plugin
> 能进到全屏的沉浸模式，Esc 直接退出，适合大量码字的时候。
> Show current file path
> 在状态栏显示当前文件的路径。这个有用的点在于，新建笔记的时候经常文件夹就错了……有这个比较容易发现。
> Hider
> 隐藏 UI 上面一些不需要的东西，比如我平时关闭窗口基本使用快捷键，所以直接隐藏了标题栏。
> Minimal Theme Settings & Style Settings
> 这是两个插件。我是使用 Minimal theme 这个主题的所以非常有用，大版本更新后重新调整了结构现在已经非常好用了。两个插件功能有重合的部分不过我选择两个都装。
> Hotkey helper
> 在社区插件的列表里面显示快捷键设置的按钮，还有一些提示冲突之类的功能。
> Hotkeys for templates
> 可以指定快捷键直接调用某一个模板，这个还是挺常用的。
> Hotkeys++
> 一些本来不能设置快捷键的功能也变得能设置了。

> Obsidian 的性能还是和 VS Code 差很多的。我现在最需要的 Obsidian 功能是键入两个中括号后，他可以直接生成一个 Markdown Style 的内部链接。不知道有没有 VSCode 插件有这个功能。- 2022.03.27 后续：没找到类似的插件，所以修改了原版 Foam 的插件，发布了 [Foam Lite](https://marketplace.visualstudio.com/items?itemName=theowenyoung.foam-lite-vscode)，功能很少，但完美满足了我的需求。

# Refer

[中文文案排版指北](https://github.com/sparanoid/chinese-copywriting-guidelines)
[少数派写作排版指南](https://sspai.com/post/37815)
[成为少数派签约作者这一年，我这样写出了 10W+ 阅读量的文章](https://zhuanlan.zhihu.com/p/34268524)
[如何输入直角引号「」和『』](https://www.zhihu.com/question/19755746/answer/20974607)
[时代弃婴——大三下大四上学期总结](https://xcbyao.com/2023/02/07/Semester_6_7_summary)
[代码风格](https://www.programmercarl.com)
《clean code-代码整洁之道》
《python编程从入门到实践第2版》
[python格式化代码【自动排版】 yapf、black风格选择](https://blog.csdn.net/sinat_28442665/article/details/118901285)