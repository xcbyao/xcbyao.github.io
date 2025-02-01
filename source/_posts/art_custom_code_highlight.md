---
title: 自定义 Hexo 代码高亮
date: 2020-02-02 14:36:40
categories: Programming
---
对于 hexo 默认的代码高亮插件 `highlight.js` 的配色方案我不太喜欢，然后 gg 了一下，总算找到了一种不错的方案，其中用到了 `prism.js` 这个代码高亮的插件，特此记录一下具体配置方案。
## 禁用 highlight.js
修改 `_config.yml` 配置文件

```yml
highlight:
  enable: false
  line_number: true
  auto_detect: false
```

## 下载 prism.js 配置文件
[个人配置](https://prismjs.com/download.html#themes=prism-okaidia&languages=markup+css+clike+javascript+bash+c+cpp+docker+git+go+java+makefile+markdown+powershell+python+sql+vim+yaml&plugins=line-highlight+line-numbers+autolinker) 选择 `theme`，这里我用 `Okaidia`，然后是 `language` 和 `plugin`；最后下载 js 和 css 文件，默认就是 `prism.js` 和 `prism.css`，如果不是建议重命名，然后将其直接放置在如下路径，或者也可以在其中一个目录下新建 `prism` 文件，将 js 和 css 文件放入。

```none
blog\themes\cactus\source\js
blog\themes\cactus\source\css
```

## 配置 prism.js
1. 在 `blog\themes\cactus\layout\_partial\head.ejs` 尾部添加以下代码：
```html
<link rel="stylesheet" href="/css/prism.css">
```

2. 在 `blog\themes\cactus\layout\_partial\footer.ejs` 尾部添加以下代码：
```html
<script src="/js/prism.js" async></script>
```
如果你选择了 `Copy to Clipboard Button` 插件，则可能还需下载 [clipboard.min.js](https://cdn.bootcss.com/clipboard.js/1.7.1/clipboard.min.js)，因为这个插件需要使用 `clipboard.min.js` 里面的函数，不过 hexo 很多主题都自带了，放在 `blog\themes\cactus\source\lib\clipboard` 里，此间可以将 `clipboard.min.js` 放到之前新建的 `prism` 文件下，或者直接在 `footer.swig` 文件末尾添加修改路径。
```html
<script src="/lib/clipboad/clipboard.min.js"></script>
```

3. 修改 `blog\node_modules\marked\lib\marked.js`，搜索 `<pre><code class="` 关键字（应该只有一处），将这行语句改为如下代码，其中如果你下载的 `prism.js` 未选择 `Line Numbers` 插件，则去掉 `line-numbers`，注意后面还有个空格，也要去掉。
```html
return '<pre><code class="line-numbers language-'
```
上面的方法是 prism.js 官网里提到的，第三步相当 hack，有位老哥研究了源码发现没必要改 `marked`，又提出了一个更简单的方法：因为 hexo 在封装 `marked` 的时候一步步把配置往外暴露了出来，最关键的是在 `hexo-renderer-marked` 里面，把配置暴露给了 hexo 配置：
```yml
hexo.config.marked = assign({
   gfm: true,
   pedantic: false,
   sanitize: false,
   tables: true,
   breaks: true,
   smartLists: true,
   smartypants: true,
   modifyAnchors: '',
   autolink: true
}, hexo.config.marked);
```
所以最终的解决就是在站点 `_config.yml` 添加如下配置就好：
```yml
marked:
    langPrefix: language-
```

## 测试 prism.js
在站点根目录，run `hexo g`，然后本地查看效果。比较麻烦的一点是，改用 `prism.js` 后，代码块必须指定一个语言，如果当前代码块没有合适的 language，可以将其语言指定为 none。这一点，个人认为在 markdown 语法中是个不错的习惯。

> Reference: https://zfl9.github.io/hexo-code.html