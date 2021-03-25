---
title: Crypto 古典密码学总结
date: 2020-01-21 16:37:49
categories: Crypto
---
## 前言
玩过 CTF 的小伙伴会遇到类似这样的问题：大表哥这是啥加密啊？其实 CTF 中的脑洞密码题，通常是非现代加密方式，一般都是各种古典密码的变形，出题者会对密文进行一些处理，但都会留下不少线索，当然也需要参赛者对于各种编码方式有所了解，这样更有利于快速入手解密，结合一定的脑洞，拿到 Flag 就 so easy 了。Crypto 题目考察各种加解密技术，包括古典加密技术、现代加密技术甚至出题者自创加密技术，以及一些常见编码解码，主要考查参赛选手密码学相关知识点，通常也会和其他题目相结合。

> 注：decode()是解码，encode()是编码
---
## 常见编码
### ASCII 编码
ASCII编码大致可以分作三部分组成：
第一部分是：ASCII非打印控制字符
第二部分是：ASCII打印字符，也就是CTF中常用到的转换
第三部分是：扩展ASCII打印字符

0～31及127(共33个)是控制字符或通信专用字符，其余的为可显示字符。
32～126(共95个)是字符(32是空格），其中48～57为0到9十个阿拉伯数字。
65～90为26个大写英文字母，97～122号为26个小写英文字母，其余为一些标点符号、运算符号等。

![](/images/ASCII.jpg)

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`102 108 97 103 123 84 104 105 115 105 115 97 101 120 97
109 112 108 101 33 125`
对应可以转换成二进制，八进制，十六进制等

- 在线解码
https://www.qqxiuzi.cn/bianma/ascii.htm

### Base64/32/16/36/58/62/91编码
base64的编码表是由（A-Z、a-z、0-9、+、/）64个可见字符构成，“=”符号用作后缀填充，末尾可能会出现1或2个“=”最多有2个。
![](/images/Base64.png)

base32的编码表是由（A-Z、2-7）32个可见字符构成，末尾可能会有‘=’，但最多有6个。

base16的编码表是由16个字符（0-9,A-F）构成。

base36密文是由36个字符（0-9,A-Z）组成，加密仅支持整数数字，解密仅支持字符串，不支持中文。

base58密文是用于Bitcoin中使用的一种独特的编码方式，主要用于产生Bitcoin的钱包地址，不使用数字”0”，字母大写”O”，字母大写”I”，和字母小写”i”，以及”+”和”/”符号。

base62密文是由62字符（0-9，a-z，A-Z）组成。

base91密文是由91个字符（0-9，a-z，A-Z,!#$%&()*+,./:;<=>?@[]^_`{|}~”）组成。

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`ZmxhZ3tUaGlzIGlzIGEgZXhhbXBsZSF9（base64）`
`MZWGCZ33KRUGS4ZANFZSAYJAMV4GC3LQNRSSC7I=（base32）`
`666C61677B546869732069732061206578616D706C65217D（base16）`
`727432 1375732 676 10 32488192274（base36）`
`ALZkyYM59XXnJxxFGfnbk4iqtDWaf9WXW（base58）`
`8nCDq36pFDV9sobcTXIgabAKmXmZWTdqH（base62）`
`@iH<,{>ux#6timlLGB[Iy)kCH$}utF（base91）`
>注：以上常见为base64/32/16，其他编码存在不支持符号{}，及大小写编码问题，根据题目自行text，encode结果仅供参考，还有base85/92等后期有时间做一个集成工具或脚本分享

- 在线解码&工具
https://www.qqxiuzi.cn/bianma/base64.htm（base64）
https://www.qqxiuzi.cn/bianma/base.php（base32）
https://www.qqxiuzi.cn/bianma/base.php?type=16（base16）
https://www.dcode.fr/base-36-cipher（base36）（国内没找到免费的，需科学上网）
http://www.metools.info/code/c74.html（base58）
https://base62.io/（支持中文）（base62）
http://decode-base62.nichabi.com（base62）
https://www.dcode.fr/base-91-encoding（base91）（国内没找到免费的，需科学上网）

### Quoted-printable编码
它是多用途互联网邮件扩展（MIME) 一种实现方式。目前http协议中，很多采用MIME框架。quoted-printable 就是说用一些可打印常用字符，表示一个字节（8位）中所有非打印字符方法。每个末编码的二进制字符被编码成三个字符，即一个等号和一个十六进制的数字，如‘=AB’。 

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`flag{This=20is=20a=20example!}`

- 在线解码&工具
http://www.mxcz.net/tools/
https://www.w3cschool.cn/tools/index?name=decode_encode_tool

### XXencode编码
只有数字，大小写字母（ +、-、0~9 、A~Z 、a~z） 一共64个字符，与base64打印字符相比，就是多一个“-” 字符，少一个”/” 字符。

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`MNalVNrhIO4Zn64Zn642UNLVVPL-gNG3x`

- 在线解码&工具
http://web.chacuo.net/charsetxxencode
https://www.qqxiuzi.cn/bianma/uuencode.php

### UUencode编码
begin 644一般为UUencode的标识
它的编码表有很多是特殊字符： !”#￥%&‘（）*+=’ 等。

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`89FQA9WM4:&ES(&ES(&$@97AA;7!L92%]`

- 在线解码&工具
http://web.chacuo.net/charsetxxencode
https://www.qqxiuzi.cn/bianma/Unicode.htm

### URL编码
一个字符ascii码的十六进制，然后在前面加上%
url编码又叫百分号编码，是统一资源定位(URL)编码方式。

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`flag%7bThis+is+a+example!%7d`

- 在线解码&工具
http://web.chacuo.net/charseturlencode
http://tool.chinaz.com/tools/urlencode.aspx

### Unicode编码
Unicode编码有以下四种编码方式：

1. &#x [Hex]：&#x0054;&#x0068;&#x0065
2. &# [Decimal]：&#00084;&#00104;&#00101
3. \U [Hex]：\U0054\U0068\U0065
4. \U+ [Hex]：\U+0054\U+0068\U+0065

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`&#x0066;&#x006C;&#x0061;&#x0067;&#x007B;&#x0054;&#x0068;&#x0069;&#x0073;&#x0020;&#x0069;&#x0073;&#x0020;&#x0061;&#x0020;&#x0065;&#x0078;&#x0061;&#x006D;&#x0070;&#x006C;&#x0065;&#x0021;&#x007D;（&#x [Hex]）`
`&#00102;&#00108;&#00097;&#00103;&#00123;&#00084;&#00104;&#00105;&#00115;&#00032;&#00105;&#00115;&#00032;&#00097;&#00032;&#00101;&#00120;&#00097;&#00109;&#00112;&#00108;&#00101;&#00033;&#00125;（&# [Decimal]）`
`\U0066\U006C\U0061\U0067\U007B\U0054\U0068\U0069\U0073\U0020\U0069\U0073\U0020\U0061\U0020\U0065\U0078\U0061\U006D\U0070\U006C\U0065\U0021\U007D（\U [Hex]）`
`\U+0066\U+006C\U+0061\U+0067\U+007B\U+0054\U+0068\U+0069\U+0073\U+0020\U+0069\U+0073\U+0020\U+0061\U+0020\U+0065\U+0078\U+0061\U+006D\U+0070\U+006C\U+0065\U+0021\U+007D（\U+ [Hex]）`

- 在线解码&工具
http://tool.chinaz.com/tools/unicode.aspx
http://www.mxcz.net/tools/Unicode.aspx
https://www.online-toolz.com/tools/text-unicode-entities-convertor.php（可能需要科学上网）

### Escape/Unescape编码
Escape/Unescape加密解码/编码解码,又叫%u编码，采用UTF-16BE模式，就是字符对应UTF-16 16进制表示方式前面加%u。

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`flag%7BThis%20is%20a%20example%21%7D`

- 在线解码&工具
https://tool.chinaz.com/tools/escape.aspx
https://escape.supfree.net/

### HTML实体编码
![](/images/HTML.png)

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`flag{This is a example!}`

- 在线解码&工具
http://www.toolzl.com/tools/htmlende.html

### Tap Code敲击码
敲击码是基于5×5方格波利比奥斯方阵来实现的，不同点是用K字母被整合到C中。

敲击码表：
```
  1  2  3  4  5
1 A  B C/K D  E
2 F  G  H  I  J 
3 L  M  N  O  P
4 Q  R  S  T  U
5 V  W  X  Y  Z
```
![](/images/knock-code.png)

### Morse Code摩尔斯电码
摩尔斯电码主要由以下5种代码组成：
1. 点（.）
2. 划（-）
3. 每个字符间短的停顿（通常用空格表示停顿）
4. 每个词之间中等的停顿（通常用 / 划分）
5. 以及句子之间长的停顿

摩尔斯电码字母、数字及符号对应表：
![](/images/Morse.png)

- 编码转换示例
源文本：`flag{This is a example!}`
编码后：`..-. .-.. .- --. - .... .. ... -....- .. ... -....- .- -....- . -..- .- -- .--. .-.. . `；
`..-./.-../.-/--./----.--/-/..../../.../../.../.-/./-..-/.-/--/.--./.-.././-.-.--/-----.-`（不同网站对符号加解码不同）

- 在线解码&工具
http://www.zhongguosou.com/zonghe/moErSiCodeConverter.aspx
http://tools.jb51.net/password/zhmorse
http://rumkin.com/tools/cipher/morse.php
http://www.zou114.com/mesm/
http://www.jb51.net/tools/morse.htm

>注：以上部分在线解码&工具较为通用，如有失效的，请反馈给我，并尝试其他网站
---
## 换位加密
### Rail-fence Cipher 栅栏密码
栅栏密码就是把要加密的明文分成N个一组，然后把每组的第1个字符组合，每组第2个字符组合……每组的第N(最后一个分组可能不足N个)个字符组合，最后把他们全部连接起来就是密文，下文以**3栏**栅栏加密为例。

- 编码转换示例
明文：`flag{This is a example!}`
去空格：`flag{Thisisaexample!}`
分组：`fla g{T his isa exa mpl e!}`
第一组：`fghieme`
第二组：`l{isxp!`
第三组：`aTsaal}`
密文：`fghiemel{isxp!aTsaal}`

- 在线解码&工具
http://www.practicalcryptography.com/ciphers/classical-era/rail-fence/

### Curve Cipher 曲路密码
曲路密码是一种换位密码，需要事先双方约定密钥(也就是曲路路径)。

填入3行7列表(事先约定填充的行列数)
```
f l a g { T h
i s i s a e x
a m p l e ! }
```
加密的回路线(事先约定填充的行列数)
![](/images/curve.png)

- 编码转换示例
明文：`flag{This is a example!}`
密文：`}xhTe!e a{gslpi alsmaif`

### Columnar Transposition Cipher 列位移加密
列移位密码通过一个简单的规则将明文打乱混合成密文。

填入3行7列表(事先约定填充的行列数，如果明文不能填充完表格可以约定使用某个字母进行填充)
```
f l a g { T h
i s i s a e x
a m p l e ! }
```
密钥： how are u

按how are u在字母表中的出现的先后顺序进行编号，我们就有a为1,e为2，h为3，o为4，r为5，u为6，w为7，所以先写出a列，其次e列，以此类推写出的结果便是密文。
```
h o w a r e u
3 4 7 1 5 2 6
f l a g { T h
i s i s a e x
a m p l e ! }
```
- 编码转换示例
明文：`flag{This is a example!}`
密文：`gsl Te! fia lsm {ae hx} aip`

- 在线解码&工具
http://www.practicalcryptography.com/ciphers/classical-era/columnar-transposition/
---
## 替换加密
### Atbash Cipher 埃特巴什码
埃特巴什码是一种以字母倒序排列作为特殊密钥的替换加密，也就是下面的对应关系：
>ABCDEFGHIJKLMNOPQRSTUVWXYZ
ZYXWVUTSRQPONMLKJIHGFEDCBA

- 编码转换示例
明文：`flag{This is a example!}`
密文：`uozt{gsrh rh z vcznkov!}`

- 在线解码&工具
http://www.practicalcryptography.com/ciphers/classical-era/atbash-cipher/

### Caesar Cipher 凯撒密码
凯撒密码(恺撒加密、恺撒变换、变换加密、位移加密)是一种替换加密，明文中的所有字母都在字母表上向后（或向前）按照一个固定数目进行偏移后被替换成密文。
![](/images/Caesar.jpg)

- 编码转换示例
明文：`flag{This is a example!}`
偏移量：`3`
密文：`iodj{wklv lv d hadpsoh!}`

- 在线解码&工具
http://www.zjslove.com/3.decode/kaisa/index.html
https://www.qqxiuzi.cn/bianma/kaisamima.php
https://planetcalc.com/1434/

### ROT 5/13/18/47
>ROT5/13/18/47是一种简单的码元位置顺序替换暗码。此类编码具有可逆性，可以自我解密，主要用于应对快速浏览，或者是机器的读取。
ROT5 是 rotate by 5 places 的简写，意思是旋转5个位置，其它皆同。下面分别说说它们的编码方式：

>ROT5：只对数字进行编码，用当前数字往前数的第5个数字替换当前数字，例如当前为0，编码后变成5，当前为1，编码后变成6，以此类推顺序循环。

>ROT13：只对字母进行编码，用当前字母往前数的第13个字母替换当前字母，例如当前为A，编码后变成N，当前为B，编码后变成O，以此类推顺序循环。

>ROT18：这是一个异类，本来没有，它是将ROT5和ROT13组合在一起，为了好称呼，将其命名为ROT18。

>ROT47：对数字、字母、常用符号进行编码，按照它们的ASCII值进行位置替换，用当前字符ASCII值往前数的第47位对应字符替换当前字符，例如当前为小写字母z，编码后变成大写字母K，当前为数字0，编码后变成符号_。用于ROT47编码的字符其ASCII值范围是33－126，具体参考ASCII编码，下面以ROT13为例。

- 编码转换示例
明文：`flag{This is a example!}`
密文：`synt{Guvf vf n rknzcyr!}（ROT13）`

- 在线解码&工具
http://www.qqxiuzi.cn/bianma/ROT5-13-18-47.php

### Hill Cipher 希尔密码
希尔密码是基于线性代数多重代换密码。每个字母转换成26进制数字：A=0, B=1, C=2...Z=25一串字母当成n维向量，跟一个n×n的矩阵相乘，再将得出的结果MOD26。详细原理见：http://blog.neargle.com/SecNewsBak/drops/CTF%E4%B8%AD%E9%82%A3%E4%BA%9B%E8%84%91%E6%B4%9E%E5%A4%A7%E5%BC%80%E7%9A%84%E7%BC%96%E7%A0%81%E5%92%8C%E5%8A%A0%E5%AF%86%20.html

- 编码转换示例
明文：`flag`
key：`5 17 4 15`
密文：`edym`

- 在线解码&工具
http://www.practicalcryptography.com/ciphers/hill-cipher/

### Pigpen Cipher 猪圈密码
猪圈密码(九宫格密码、朱高密码、共济会密码或共济会员密码)，是一种以格子为基础的简单替代式密码。
![](/images/pigpen.jpg)
![](/images/pigpen.png)

- 编码转换示例
明文：`flag{This is a example!}`
密文：![](/images/pigpen-crypto.png)

- 在线解码&工具
http://www.simonsingh.net/The_Black_Chamber/pigpen.html

### Polybius Square Cipher 波利比奥斯方阵密码
波利比奥斯方阵密码（波利比奥斯棋盘）是棋盘密码的一种，是利用波利比奥斯方阵进行加密的密码方式，简单的来说就是把字母排列好，用坐标(行列)的形式表现出来。**字母是密文，明文便是字母的坐标，反之亦同。**
![](/images/Polybios.png)

- 编码转换示例
明文：`flag`
密文：`12131122`

### 夏多密码（曲折加密）
夏多密码是作者麦克斯韦·格兰特在中篇小说《死亡之链》塑造夏多这一英雄人物中所自创的密码，如下图所示：
![](/images/xiaduo.png)

>注：在以上所示的字母表密钥的底部，列有四个附加符号1，2，3，4.他们可以放在密文中的任何地方。每个附加符号指示，如何转动写有密文的纸张，再进行后续的加密或解密操作，直到出现另一个附加符号。可以把每个附加符号中的那根线看作是指示针，它指示了纸张的上端朝上，朝右，朝下，朝左。比如说：如果出现符号3，那么纸张就应该转动180度，使其上端朝下； 符号2表示纸张上端朝右，依次类推。

### Vigenere Cipher 维吉尼亚密码
维吉尼亚密码是在单一恺撒密码的基础上扩展出多表代换密码，根据密钥(当密钥长度小于明文长度时一般为循环使用，密钥越长相对破解难度越大)来决定用哪一行的密表来进行替换，以此来对抗字频统计。
![](/images/Virginia.png)

- 编码转换示例
明文：`flag{This is a example!}`
密钥：`password`
密文：`ulsy{Pvzv xs s wtodsae!}`

- 在线解码&工具
https://www.qqxiuzi.cn/bianma/weijiniyamima.php
http://planetcalc.com/2468/（已知密匙）
http://rumkin.com/tools/cipher/gronsfeld.php（未知密匙）
http://www.zjslove.com/3.decode/weijiniya/index.html

### Baconian Cipher 培根密码
培根密码是一种替换密码，每个明文字母被一个由5字符组成的序列替换。以下是全部的对应关系(另一种对于关系是每个字母都有唯一对应序列，I和J与U/V各自都有不同对应序列)：
![](/images/Bacon.png)

- 编码转换示例
明文：`flag{This is a example}`
密文：`AABABABABAAAAAAAABBA BAABAAABBBABAAABAAAB ABAAABAAAB AAAAA AABAABABABAAAAAABABBABBBAABABAAABAA`

- 在线解码&工具
http://rumkin.com/tools/cipher/baconian.php

### 其他小技巧：
- 如果密文是十进制，字符范围为“0-9”，可以猜测是 ASCII 编码；
- 如果密文由“a-z”“A-Z”和“=”构成，特别是末尾有“=”，那么可以判断为 Base64 编码；
- 如果密文含有“%”，形式为 “%xx” 和 “%uxxxx”，字符范围又是十六进制“0-F”，判断是 escape() 编码，用 unescape() 解码；
- 若密文由“[]，()，{}，+,！”字符组成的编码通常就通过 Jother 解密。
---
## References
[CTF中那些脑洞大开的编码和加密](http://blog.neargle.com/SecNewsBak/drops/CTF%E4%B8%AD%E9%82%A3%E4%BA%9B%E8%84%91%E6%B4%9E%E5%A4%A7%E5%BC%80%E7%9A%84%E7%BC%96%E7%A0%81%E5%92%8C%E5%8A%A0%E5%AF%86%20.html)
[从零开始学习CTF](https://zhuanlan.zhihu.com/p/30319968)
[ASCII码，HTML转义字符表，以及快捷键](https://blog.csdn.net/Chad97/article/details/82415509)
[CTF常见编码和加密特征](https://blog.csdn.net/nocbtm/article/details/90242650)
[CTF：集合吧，字符编码](https://www.jianshu.com/p/201aa3458a97)
[CTF必备技能之编码大全](https://cloud.tencent.com/developer/article/1419464)
[CTF中常见密码题解密网站总结](http://www.mamicode.com/info-detail-2252602.html)

## 后记
上述没有提到的加解密情况还有很多，不过多为变种，基本原理相同，主要还是思路要灵活，下文会再整理一下在线加解密网站，方便查询。

收集整理这些东西，一是方便我自己学习，尤其是在做 CTF 的 Crypto 题时，熟悉绝大多数的加密方式，可以更快判断出加密方式，从而进行接下来的分析；二是自然也希望可以帮到其他有需要的朋友，希望能结识更多志同道合的小伙伴，一起学习，共同进步，欢迎你们一起来讨论技术。

当然我其实也是一个刚刚入门的小菜鸡，如果文中有错误的地方，请各位大神不吝赐教，也欢迎大家来捧场！