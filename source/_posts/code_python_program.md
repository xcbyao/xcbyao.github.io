---
title: python 学习笔记之项目篇
date: 2023-04-23 21:41:09
categories: Programming
---
# Pref

整理学习中遇到的项目。

# Web 应用程序

## 制定规范

编写一个「学习笔记」的 Web 应用程序，让用户能够记录感兴趣的主题，并在学习每个主题的过程中添加日志条目。
「学习笔记」主页描述网站，并邀请用户注册或登录。登录后，可创建新主题、添加新条目以及阅读既有的条目。

## 建立虚拟环境

使用 Django 需要建立一个虚拟工作环境。
虚拟环境是系统的一个位置，可在其中安装包，并与其他 Python 包隔离，便于之后部署到服务器。

新建一个目录 `learning_log` 目录终端下执行命令创建虚拟环境。

```shell
python -m venv ll_env
```

运行模块 venv 创建 ll_env 虚拟环境。

## 激活/停止虚拟环境

```shell
learning_log$ source ll_env/bin/activate # 运行 ll_env/bin 中的脚本 activate
ll_env\Scripts\activate # Windows，不用 source
ll_env\Scripts\Activate # PowerShell
(ll_env)learning_log$ # 环境处于活动状态时，环境名将包含在圆括号内
deactivate # 停止使用虚拟环境
```

在 ll_env 中安装的包仅在该环境处于活动状态时才可用。

## 安装 Django

```shell
pip install django
```

在虚拟环境（独立的环境）中工作，在各种系统中安装 Django 命令都相同：
不需要指定标志 --user，也不需要 python -m pip install package_name 这种。
Django 仅在虚拟环境 ll_env 处于活动状态时才可用。

## 在 Django 中创建项目

```shell
(ll_env)learning_log$ django-admin startproject learning_log . # 句点让新项目使用合适的目录结构，方便部署
(ll_env)learning_log$ ls # Win 用 dir /a
learning_log ll_env manage.py
(ll_env)learning_log$ ls learning_log
__init__.py settings.py urls.py wsgi.py # 后三个文件最重要
```

manage.py 接受命令并将其交给 Django 相关部分运行。
settings.py 指定 Django 如何与系统交互及管理项目。
urls.py 告诉 Django 应创建哪些页面来响应浏览器请求。
wsgi.py 帮助 Django 提供它创建的文件，这个文件名是 Web 服务器网关接口（Web server gateway interface）缩写。

## 创建数据库

```shell
(ll_env)learning_log$ python manage.py migrate
# pip install virtualenv 可能报错解决方案
# 在虚拟环境中，务必用 python 命令，而非 py3 等。
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  --snip--
  Applying sessions.0001_initial... OK
(ll_env)learning_log$ ls
db.sqlite3 learning_log ll_env manage.py
```

将修改数据库称为迁移（migrate）。首次执行 migrate 时，将让 Django 确保数据库与项目的当前状态匹配。

SQLite 是一种使用单个文件的数据库， 是编写简单应用程序的理想选择，因为它让你不用太关注数据库管理的问题。

### 查看项目

```shell
(ll_env)learning_log$ python manage.py runserver
Watching for file changes with StatReloader
Performing system checks...

System check identified no issues (0 silenced).
February 18, 2019 - 16:26:07
Django version 2.2.0, using settings 'learning_log.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CONTROL-C.
```

Django 启动了一个 development server 服务器，用来查看系统中的项目。
localhost 指只处理当前系统发出的请求，不允许其他人查看你正在开发的页面的服务器。
打开 http://localhost:8000/ 或 http://127.0.0.1:8000/ 查看。

## 创建应用程序

保持之前运行的 runserver，再打开一个终端：

```shell
learning_log$ source ll_env/bin/activate
(ll_env)learning_log$ python manage.py startapp learning_logs
(ll_env)learning_log$ ls
db.sqlite3 learning_log learning_logs ll_env manage.py
(ll_env)learning_log$ ls learning_logs/
__init__.py admin.py apps.py migrations models.py tests.py views.py
```

startapp appname 让 Django 搭建创建应用程序所需的基础设施。

最重要的文件：
models.py 定义要在应用程序中管理的数据。
admin.py 注册模型。
views.py

### 定义模型

```python
'''models.py'''
# 表示用户将存储的主题模型
from django.db import models

class Topic(models.Model):
    """用户学习的主题。"""
    text = models.CharField(max_length=200) # CharField 由字符组成的数据，即文本。
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        """返回模型的字符串表示。"""
        return self.text
```

> 模型各种字段了解 Django Model Field Reference

### 激活模型

打开 settings.py，其中有个片段告诉 Django 哪些应用程序被安装到了项目中并将协同工作。

```python
'''settings.py'''
--snip--
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
-snip--

# 修改如下
INSTALLED_APPS = [
    # my APP
    'learning_logs',

    # default APP
    'django.contrib.admin',
    --snip--
]
```

务必将自己创建的应用程序放在默认应用程序前面，这样能够覆盖默认应用程序的行为。

接着需要让 Django 修改数据库，使其能够存储与模型 Topic 相关的信息。

```shell
(ll_env)learning_log$ python manage.py makemigrations learning_logs
# 输出表明 Django 创建了 0001_initial.py 迁移文件，该文件将在数据库中为模型 Topic 创建一个表。
Migrations for 'learning_logs':
  learning_logs/migrations/0001_initial.py
    - Create model Topic

# 让 Django 修改数据库
(ll_env)learning_log$ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, learning_logs, sessions
Running migrations:
  Applying learning_logs.0001_initial... OK
```

每当需要修改「学习笔记」管理的数据时，都采取如下三个步骤：
1. 修改 models.py
2. 对 learning_logs 调用 makemigrations
3. 让 Django 迁移项目

### Django 管理网站 admin site

#### 创建超级用户

Django 允许创建具备所有权限的用户。

```shell
(ll_env)learning_log$ python manage.py createsuperuser
Username (leave blank to use 'eric'): ll_admin
Email address: # 可留空
Password: admin # 必选
Password (again):
Superuser created successfully.
```

> Django 存储从该密码派生出来的一个散列值字符串，而非原密码。

#### 向管理网站注册模型

```python
'''admin.py'''
from .models import Topic # 句点让 Django 在 admin.py 所在目录中查找 models.py

admin.site.register(Topic)
```

Django 自动在管理网站中添加了一些模型，如 User、Group。
访问 http://localhost:8000/admin/

#### 添加主题

单击 Topics，再单击 Add，出现一个用于添加新主题的表单。输入 Chess 再单击 Save 回到主题管理页面。再创建 Rock Climbing。

### 定义模型 Entry

每个条目都与特定主题相关联，即多对一关系。

```python
'''models.py'''
class Entry(models.Model):
    """学到的有关某个主题的具体知识。"""
    topic = models.ForeignKey(Topic, on_delete=models.CASCADE)
    # 属性 topic 是个 ForeignKey 实例。
    # 外键是将每个条目关联到特定主题。创建每个主题时，都分配了一个键（ID）。
    #  实参让 Django 在删除主题的同时删除所有与之相关联的条目，即级联删除 cascading delete。
    text = models.TextField()
    # 属性 text 是个 TextField 实例。这种字段的长度不受限制。
    date_added = models.DateTimeField(auto_now_add=True)
    # 按创建顺序呈现条目

    class Meta:
        verbose_name_plural = 'entries'
        # Meta 存储用于管理模型的额外信息。
        # 在需要时使用 Entries 来表示多个条目。
        # 如果没有这个类，Django 将用 Entrys 来表示多个条目。

    def __str__(self):
        """返回模型的字符串表示。"""
        return f"{self.text[:50]}..." # 只显示前 50 字符。
```

### 迁移模型 Entry

```shell
(ll_env)learning_log$ python manage.py makemigrations learning_logs
(ll_env)learning_log$ python manage.py migrate
```

### 向管理网站注册 Entry

```python
'''admin.py'''
from .models import Topic, Entry

admin.site.register(Topic)
admin.site.register(Entry)
```

Entries -> Add -> Chess/Rock Climbing

```none
# 第一条国际象棋条目

The opening is the first part of the game, roughly the first ten moves or so. In the opening, it's a good idea to do three things—bring out your bishops and knights, try to control the center of the board, and castle your king.
（国际象棋的第一个阶段是开局，大致是前10步左右。在开局阶段，最好做三件事情：将象和马调出来，努力控制棋盘的中间区域，以及用车将王护住。）

Of course, these are just guidelines. It will be important to learn when to follow these guidelines and when to disregard these suggestions.
（当然，这些只是指导原则。学习什么情况下遵守这些原则、什么情况下不用遵守很重要。）

# 第二条国际象棋条目

In the opening phase of the game, it's important to bring out your bishops and knights. These pieces are powerful and maneuverable enough to play a significant role in the beginning moves of a game.
（在国际象棋的开局阶段，将象和马调出来很重要。这些棋子威力大，机动性强，在开局阶段扮演着重要角色。）

# 第一条攀岩条目

One of the most important concepts in climbing is to keep your weight on your feet as much as possible. There's a myth that climbers can hang all day on their arms. In reality, good climbers have practiced specific ways of keeping their weight over their feet whenever possible.
（最重要的攀岩概念之一是尽可能让双脚承受体重。有人误认为攀岩者能依靠手臂的力量坚持一整天。实际上，优秀的攀岩者都经过专门训练，能够尽可能让双脚承受体重。）
```

保存后返回到主条目管理页面，发现使用 text[:50] 作为条目的字符串表示仅显示开头部分。

### Django shell

输入一些数据后，就可通过交互式终端会话以编程方式查看这些数据了。这种交互式环境称为 Django shell，是测试项目和排除故障的理想之地。

```shell
(ll_env)learning_log$ python manage.py shell
>>> from learning_logs.models import Topic
>>> Topic.objects.all() # 获取模型 Topic 所有实例，返回一个称为查询集（queryset）的列表。
<QuerySet [<Topic: Chess>, <Topic: Rock Climbing>]>

# 如何查看分配给每个主题对象的 ID
>>> topics = Topic.objects.all()
>>> for topic in topics:
... print(topic.id, topic)
1 Chess
2 Rock Climbing

# 知道 ID，就可使用方法 Topic.objects.get() 获取该对象并查看其属性。
>>> t = Topic.objects.get(id=1)
>>> t.text
'Chess'
>>> t.date_added
datetime.datetime(2019, 2, 19, 1, 55, 31, 98500, tzinfo=<UTC>)

# 查看与主题相关联的条目。
>>> t.entry_set.all()
<QuerySet [<Entry: The opening is the first part of the game, roughly...>, <Entry: In the opening phase of the game, it's important t...>]>
```

要通过外键关系获取数据，可使用相关模型的小写名称、下划线和单词 set。
Topping 通过一个外键关联到 Pizza。如果有一个名为 my_pizza 的 Pizza 对象，就可使用 my_pizza.topping_set.all() 来获取这张比萨的所有配料。




19.1——开始往下

> Web 应用程序的核心是让用户在任何地方都能注册账户并使用。




20章的往后

## 设置应用程序样式

为设置样式， 我们将使用Bootstrap库， 这是一组工具， 用
于为Web应用程序设置样式， 使其在任何现代设备上都看
起来很专业， 无论是大型的平板显示器还是智能手机。 为
此， 我们将使用应用程序django-bootstrap4， 这也让你能
够练习使用其他Django开发人员开发的应用程序。
我们将把项目“学习笔记”部署到Heroku， 这个网站让你能
够将项目推送到其服务器， 让任何有互联网连接的人都可
以使用它。 我们还将使用版本控制系统Git来跟踪对这个
项目所做的修改。

使用Bootstrap意味着无论用户使用哪种设备来访问你
的项目， 你选择的样式都将实现几乎相同的效果。





# Refer

《Python编程快速上手——让繁琐工作自动化第一版》
《python编程从入门到实践第二版》

# PS

