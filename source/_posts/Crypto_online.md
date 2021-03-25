---
title: Crypto 加解密网站总结
date: 2020-01-25 18:31:21
categories: Crypto
---
## 0x00 前言
CTF 中 Crypto 题往往涉及到很多方面，无论是 web，还是 reverse，都能看到密码学的影子，所以掌握必要的密码学知识尤为重要，上文我整理分享了一些常见的加密方式，但略去了很多变种的加密方式，此间便做一个补充，也是方便在线解题，尽可能省去临时查找在线解密网站的时间。

## 0x01 正文

### 综合性网站
网站中包含大多编码的解码。
https://tool.lu/
http://www.mxcz.net/tools/base64.aspx
https://www.qqxiuzi.cn/daohang.htm
http://web2hack.org/xssee/
https://www.sojson.com/
http://web.chacuo.net/
http://tool.chinaz.com/tools/unixtime.aspx
https://tool.chinaz.com/tools/textencrypt.aspx
https://tool.chinaz.com/js.aspx
http://tools.jb51.net/password/zhmorse
https://www.jb51.net/tools/morse.htm
https://quipqiup.com（词频分析）

### 文字倒序排列
http://www.qqxiuzi.cn/zh/daoxu/

### cmd5解密
http://www.cmd5.com/
http://pmd5.com/
http://tool.chinaz.com/Tools/MD5.aspx
http://md5jiami.51240.com/
http://www.mxcz.net/tools/MD5.aspx

### （1）base64解密
http://www.mxcz.net/tools/base64.aspx
http://tool.chinaz.com/Tools/Base64.aspx
http://www1.tc711.com/tool/BASE64.htm
http://base64.supfree.net/
http://web.chacuo.net/charsetbase64
http://ctf.ssleye.com/base64.html
https://www.qqxiuzi.cn/bianma/base64.htm

### （2）base32解密
http://tomeko.net/online_tools/base32.php?lang=en
http://ctf.ssleye.com/base64.html
https://www.qqxiuzi.cn/bianma/base.php

### （3）base16解密
https://www.qqxiuzi.cn/bianma/base.php?type=16

### （4）base36解密
http://ctf.ssleye.com/base36w.html
https://www.dcode.fr/base-36-cipher（需科学上网）

### （5）base58解密
http://ctf.ssleye.com/base58w.html
http://www.metools.info/code/c74.html

### （6）base62解密
https://base62.io/（支持中文） 
http://decode-base62.nichabi.com 
http://ctf.ssleye.com/base62.html（仅支持数字）

### （7）base91解密
http://ctf.ssleye.com/base91.html
https://www.dcode.fr/base-91-encoding（base91）（国内没找到免费的，需科学上网）

### （1）ROT5
http://www.qqxiuzi.cn/bianma/ROT5-13-18-47.php

### （2）ROT13
http://www.mxcz.net/tools/rot13.aspx
http://www.qqxiuzi.cn/bianma/ROT5-13-18-47.php

### （3）ROT18
http://www.qqxiuzi.cn/bianma/ROT5-13-18-47.php

### （4）ROT47位移编码
http://www.qqxiuzi.cn/bianma/ROT5-13-18-47.php

### 颜文字（aadecode）
打开谷歌浏览器-->F12-->点击Console-->粘贴复制回车就会出现答案
https://cat-in-136.github.io/2010/12/aadecode-decode-encoded-as-aaencode.html
http://utf-8.jp/public/aaencode.html

### 邮件编码（UUencode：M=75E;F-O9&7HOYGDN*KED）
http://web.chacuo.net/charsetuuencode
http://www.mxcz.net/tools/UUEncode.aspx

### 查尔斯加密（playfair解密）
http://rumkin.com/tools/cipher/playfair.php

### 在线编码解码
http://bianma.911cha.com/
http://stool.chinaz.com/hex

### 进制间转换
http://tool.oschina.net/hexconvert/
http://stool.chinaz.com/hex
https://tool.lu/hexconvert/

### 16进制与文本转换
http://www.mxcz.net/tools/Hex.aspx
http://www.5ixuexiwang.com/str/from-hex.php
http://www.5ixuexiwang.com/str/hex.php

### Unicode编码转换（4种）
&#x [Hex]： &#x0054;&#x0068;&#x0065;
&# [Decimal]： &#00084;&#00104;&#00101;
\U [Hex]： \U0054\U0068\U0065
\U+ [Hex]： \U+0054\U+0068\U+0065
http://tool.oschina.net/encode?type=3 （\u5927）
http://tool.chinaz.com/tools/unicode.aspx （\u5927）
http://tool.oschina.net/encode （&#23433）
http://www.mxcz.net/tools/Unicode.aspx

### Brainfuck（++++++++++++[>++++>）
https://www.splitbrain.org/services/ook （Ook!与Brainfuck）
https://www.nayuki.io/page/brainfuck-interpreter-javascript
http://esoteric.sange.fi/brainfuck/impl/interp/i.html

### URL（%23）
http://www.mxcz.net/tools/Url.aspx
http://tool.chinaz.com/tools/urlencode.aspx
http://web.chacuo.net/charseturlencode
http://tool.oschina.net/encode?type=4
http://ctf.ssleye.com/url.html

### 二维码生成/解码器
http://tool.chinaz.com/qrcode/
http://jiema.wwei.cn/

### 摩斯密码
http://www.zou114.com/mesm/
http://rumkin.com/tools/cipher/morse.php
http://tools.jb51.net/password/zhmorse
http://www.zhongguosou.com/zonghe/moErSiCodeConverter.aspx http://www.jb51.net/tools/morse.htm （编码的时候不转换空格）
http://ctf.ssleye.com/morse.html （编码的时候不转换空格） 
http://rumkin.com/tools/cipher/morse.php （空格用斜杠表示）

### quipqiup
https://www.xarg.org/tools/caesar-cipher/
https://quipqiup.com/

### 与佛论禅
http://www.keyfc.net/bbs/tools/tudoucode.aspx

### 新约佛论禅/熊曰
http://hi.pcmoe.net/buddha.html

### xxencode(Ri64NjS0-eRKpkQm-jRaJm6)
http://web.chacuo.net/charsetxxencode

### jsfuck（ [ ] [ ( ! [ ] + [ ]) [ + [ ] ）
> 注：用[ ]( ) ! +加密

打开 Chrome -->F12-->点击Console-->粘贴复制回车就会出现答案
http://discogscounter.getfreehosting.co.uk/js-noalnum.php?ckattempt=1&i=1（放在下面的大框里，点击eval(--v)）
http://discogscounter.getfreehosting.co.uk/js-noalnum.php 
 http://www.jsfuck.com/

### UTF-8编码(&#x5B89)
http://tool.chinaz.com/Tools/UTF-8.aspx
http://tool.oschina.net/encode?type=2
http://www.3464.com/Tools/HtmlToOther/

### DES(要密匙)
http://encode.chahuo.com/
http://tool.oschina.net/encrypt/

### 凯撒密码
http://www.zjslove.com/3.decode/kaisa/index.html
http://planetcalc.com/1434/

### Rabbit（兔子）解密
>注：此编码与和base64很相似

http://tool.chinaz.com/Tools/TextEncrypt.aspx
http://tool.oschina.net/encrypt/

### AES
部分例子：U2FsdGVkX1+qtU8KEGmMJwGgKcPUK3XBTdM+KhNRLHSCQL2nSXaW8++yBUkSylRp
http://tool.oschina.net/encrypt/
http://aes.online-domain-tools.com/

### JS解密/混淆
https://www.sojson.com/js.html
http://www.haokuwang.com/jsendecode.htm
http://www.dheart.net/decode/index.php
https://tool.chinaz.com/tools/scriptencode.aspx
https://tool.chinaz.com/js.aspx
https://www.jb51.net/tools/js_format.htm

### ASP解密
部分例子：#@~^ EQAAAA==VXlj4UmkaYAUmKN3bAYAAA==^ #~@
http://adophper.com/encode.html

### Snake解密（要密匙）
http://serpent.online-domain-tools.com/

### GRB与十六进制的转换
http://www.sioe.cn/yingyong/yanse-rgb-16/
http://www.atool.org/colorpicker.php

### html隐写在线解密
> 注：密匙和网址

http://fog.misty.com/perry/ccs/snow/snow/snow.html
https://tool.chinaz.com/tools/htmlcodecov.aspx

### shellcode编码（\x54\x68\x65\x7f）
http://www.jb51.net/article/10399.htm

### Quoted-printable编码
我们收邮件，查看信件原始信息，经常会看到这种类型的编码！（=E6=95=8F=E6=8D=B7=E7=9A）
function quoted_printable_encode($string) { 
    return preg_replace(‘/[^\r\n]{73}[^=\r\n]{2}/‘, "$0=\r\n", str_replace("%","=",
rawurlencode($string))); 
} 
http://www.mxcz.net/tools/QuotedPrintable.aspx

### Escape/Unescape编码（%u0054%u0068%u0065）
https://escape.supfree.net/
https://tool.chinaz.com/tools/escape.aspx
http://web.chacuo.net/charsetescape

### 敲击码(Tap code)
```
　1 2  3  4 5 
1 A B C/K D E 
2 F G  H  I J 
3 L M  N  O P 
4 Q R  S  T U 
5 V W  X  Y Z
```
http://ctf.ssleye.com/tapcode.html

### 栅栏密码
http://www.practicalcryptography.com/ciphers/classical-era/rail-fence/

### 曲路密码
需要事先双方约定密钥(也就是曲路路径)
![](/images/curve2.png)

### 列移位密码
密钥： how are u
密文： qoury inpho Tkool hbxva uwmtd cfseg erjez
![](/images/move.png)
http://www.practicalcryptography.com/ciphers/classical-era/columnar-transposition/

### 埃特巴什码
ABCDEFGHIJKLMNOPQRSTUVWXYZ ZYXWVUTSRQPONMLKJIHGFEDCBA
http://www.practicalcryptography.com/ciphers/classical-era/atbash-cipher/

### 希尔密码（利用矩阵）
http://www.practicalcryptography.com/ciphers/hill-cipher/

### 夏多密码(曲折加密)
![](/images/xiaduo.png)

### 编制密码表
> 注：如果出现"Z"，则需要去除，因为在英文里"Z"的使用频率最低，相应的如果是德文，则需将"I"与"J"当作一个字母来看待，而法语则去掉"W"或"K"。
整理密钥字母 C U L T U R E ，去掉后面重复的字母得到： C U L T R E
![](/images/made.png)
http://www.practicalcryptography.com/ciphers/classical-era/playfair/

### 维吉尼亚密码
http://planetcalc.com/2468/（已知密匙）
http://rumkin.com/tools/cipher/gronsfeld.php（未知密匙）
http://www.zjslove.com/3.decode/weijiniya/index.html
https://www.qqxiuzi.cn/bianma/weijiniyamima.php

### 自动密钥密码
http://www.practicalcryptography.com/ciphers/classical-era/autokey/

### 博福特密码
http://www.practicalcryptography.com/ciphers/classical-era/beaufort/

### 滚动密钥密码
http://www.practicalcryptography.com/ciphers/classical-era/running-key/

### Porta密码
http://www.practicalcryptography.com/ciphers/classical-era/porta/

### 仿射密码
以E(x) = (5x + 8) mod 26加密，通过计算可得D(x)=21(x ### 8) mod 26，这样便可以得到明文。
http://www.practicalcryptography.com/ciphers/classical-era/affine/

### 培根密码
http://rumkin.com/tools/cipher/baconian.php

### ADFGX和ADFGVX密码（德军密码）
http://www.practicalcryptography.com/ciphers/adfgx-cipher/

### 双密码 Bifid Cipher
明文: THE QUICK BROWN FOX=>5121542133 5435452521 3523311521 34 =>密文: WETED TKZNE KYOME X
http://www.practicalcryptography.com/ciphers/classical-era/bifid/

### 四方密码
http://www.practicalcryptography.com/ciphers/classical-era/four-square/

### 跨棋盘密码
http://www.practicalcryptography.com/ciphers/classical-era/straddle-checkerboard/

### 恩尼格玛密码（德国二战 机械密码）
http://enigmaco.de/enigma/enigma.html

### CR4解密
http://tool.oschina.net/encrypt
http://tool.chinaz.com/Tools/TextEncrypt.aspx

### VBScript
部分例子：#@~^ TgAAAA==‘[6* liLa6++p‘aXvfiLaa6i[[avWi[[a* p[[6 * !I‘[6cp‘aXvXILa6fp[:6+Wp[:XvWi[[6+XivRIAAA== ^#~@
http://www.dheart.net/decode/index.php

### 执行php文件
https://www.shucunwang.com/RunCode/php/

### 图片/BASE64转换
http://tool.oschina.net/encrypt?type=4
https://www.sojson.com/image2base64.html

### SHA/散列/哈希
https://tool.chinaz.com/tools/hash.aspx
http://tools.jb51.net/password/sha_encode
https://www.sojson.com/hash.html

### 格雷编码
![](/images/gelei.png)
http://ctf.ssleye.com/tapcode.html

### 字母编码
![](/images/zm.png)
http://ctf.ssleye.com/a1z26.html

### ASCII编码
http://ctf.ssleye.com/jinzhi.html 
http://ctf.ssleye.com/cencode.html 
http://www.ab126.com/goju/1711.html

### GBK/GBK2312编码
http://www.mytju.com/classcode/tools/encode_gb2312.asp 
https://www.qqxiuzi.cn/bianma/zifuji.php

### jjencode
http://utf-8.jp/public/jjencode.html 
http://www.atoolbox.net/Tool.php?Id=704

### aaencode
http://utf-8.jp/public/aaencode.html 
https://www.qtool.net/decode
>注：jjencode/aaencode的解密直接在浏览器的控制台里输入密文即可执行解密

### ppencode
http://namazu.org/~takesako/ppencode/demo.html

### rrencode
http://www.lab2.kuis.kyoto-u.ac.jp/~yyoshida/rrencode.html

### jother
jother直接在浏览器(IE可以)的控制台里输入密文即可执行解密
http://tmxk.org/jother/

### 猪圈密码
![](/images/pigpen.png)
http://www.simonsingh.net/The_Black_Chamber/pigpen.html

### 加密为汉字
http://www.qqxiuzi.cn/bianma/wenbenjiami.php
https://tool.chinaz.com/tools/textencrypt.aspx

### 键盘密码 Keyboard Cipher
> 坐标法： 
 Y轴 
 1 QWE RTY UIOP 
 2 ASD FGH JKL 
 3 ZXC VBN M 
 12345678910 X轴 
 eq：密文：2251914161对应明文：story 

> 顺序法： 
 Q W E R T Y U I O P 
 1 2 3 4 5 6 7 8 9 10 
 A S D F G H J K L 
 11 12 13 14 15 16 17 18 19 
 Z X C V B N M 
 20 21 22 23 24 25 26 
 eq：密文：125947对应明文：story

### 手机九宫格键盘密码
密文用数字0-9表示a-z的字符集，字母不区分大小写 
```
密文：21222331323341424351525361626371727381828391929394 
明文：abcdefghijklmnopqrtuvwxyz 
```
米斯特安全团队解密工具（公众号回复 米斯特，需要 java 环境）

### 条形码/二维码
https://online-barcode-reader.inliteresearch.com/

### 当铺密码
密文由[0-9]数字组成（以当前汉字有多少笔画出头，就是转化成对应的数字） 
 http://www.zjslove.com/3.decode/dangpu/index.html

### 核心价值观编码
密文特征为社会主义核心价值观的关键字 
http://ctf.ssleye.com/cvencode.html

### 代码混淆加密
（1）asp混淆加密
https://www.zhaoyuanma.com/aspfix.html
（2）[php language="混淆加密"][/php][/php]
https://www.zhaoyuanma.com/phpjmvip.html
（3）[css language="/js混淆加密"][/css][/css]
http://tool.css-js.com/
（4）VBScript.Encode混淆加密
http://www.zhaoyuanma.com/aspfix.html

## 0x02 References
[CTF中常见密码题解密网站总结](http://www.mamicode.com/info-detail-2252602.html)
[CTF中那些脑洞大开的编码和加密](http://blog.neargle.com/SecNewsBak/drops/CTF%E4%B8%AD%E9%82%A3%E4%BA%9B%E8%84%91%E6%B4%9E%E5%A4%A7%E5%BC%80%E7%9A%84%E7%BC%96%E7%A0%81%E5%92%8C%E5%8A%A0%E5%AF%86%20.html)
[CTF必备技能之编码大全](https://cloud.tencent.com/developer/article/1419464)

## 0x03 写在最后
基本上一些较为常见的加密方式，国内网站优先推荐，但是一些变种的加密方式如 base36 等国内目前没有找到免费的，而作为一个 CTFer ，心气还是有点高的（~~其实是没钱~~），so 多推荐国外的，谈到此间不得不提一句，国内找不到的资料，国外用 English 搜索，往往很轻松就能找到答案了，of course ，此间不能 GG 的朋友，Bing 国际版也是个不错的选择。