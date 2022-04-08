---
title: 利用 iTunes 抓包下载 ios 旧版本 App（网上教程填坑完善合集）
date: 2022-03-09 13:40:43
categories: Software
---
## 0x00 折腾缘由
最近 GoodNotes5 自`5.9.0`更新后，突然从预付费买断转成了内购买断，故测试了一波（第一次脑残先获取了应用损失了一个号，**务必直接抓包旧版，不要获取新版**），同下文 Notability 一样可实现抓包安装旧版，获取内购，免费升级新版。

附一份内购新旧版本号，`5.8.13`最后预付费版本大小供参考。

![](/images/goodnotes_id.png)

![](/images/goodnotes_install.png)

---

众所周知，之前笔记软件 Notability 买断制改订阅制，因其对旧用户的善后政策不当，直接侵犯了广大旧用户的利益，故引起了一波讨伐，消费者均不买账纷纷投诉退款，开发官方迫于舆论压力，及时道歉挽回，新版本 11.0 以上新用户提供免费版（阉割版）和订阅制，旧版本买断制用户在更新版本后不受订阅制影响，原有买断功能仍可永久使用。

不同于另一款笔记软件 GoodNotes，其第五代新版本发布了全新的软件，独立于四代旧版本，而 Notability 是基于原发布软件的升级，仍和上一买断制版本有着非常紧密的联系，故给折腾党多了摆弄的心思。

因为新版已经是免费版，我们都可以直接下载，**即拥有了旧版的未来**，那再通过抓包下载（已无需买断的）旧版，我们有了它的未来，**自然可以拥有它的过去**，于是，曾经买断制的诸多功能，过渡到了新版本，无需订阅即可永久使用，不受限于阉割的免费版，岂不美滋滋！

不仅如此，学会了抓包旧版本的方法，我们也可以运用到其他**原来功能免费，后期改成功能内购**的 APP 上，毕竟新应用自然需要免费吸引用户，后期运营成本高了改付费也是人之常情，有条件价格合理的自然还是支持一下开发团队。

除此之外，很多 APP or 系统不是越新越好，不喜欢新版本的用户就有回到旧版本的需求，或是为了追求无广告与功能更简洁。

So，接下来开始我们的手艺~


## 0x01 趁手的工具人
在分享这门 iOS 应用降级的手艺前，我们得先物色好趁手的工具人，工欲善其事必先利其器嘛。

首先肯定是苹果的 iTunes，但此事不简单，如果你直接去下载了最新版，你会惊奇地发现只能下 Music，想下载应用？咱 iTunes 后代不支持！

所以我们得找它祖宗！还好，虽然新生代已经另立门户（`Mac Mojave`），但老一辈都得道成仙了，来 [这里](https://www.theiphonewiki.com/wiki/ITunes) ，别说祖宗十八代，几十代都在呢！其中几代变革都写得清清楚楚… 啥？不知道该找谁？找仍在坚守 AppStore 的那几代人~

别急，我们先继续说剩下的两位，一位是盛名在外（常用抓包和调试工具）牢饭吃到饱的 Fiddler（找 Charles 也行），后期 iTunse 配合 Fiddler 对软件进行版本号抓取。

另一位就是漂亮的艾丽丝（~~爱思助手~~），它负责收尾工作，把 isp 回炉重造（装到设备上）。

介绍完了，我知道你们懒得找，所以我把它们请来了（点击图片下载）——

[![](/images/itunes_icon.png)](https://support.apple.com/zh-cn/HT208079)

[![](/images/App.ico)](https://www.telerik.com/download/fiddler)

[![](/images/pro_pc.png)](https://www.i4.cn/pro_pc.html)


## 0x02 三位大佬闹脾气
因为 iTunes 12.6.5 以上的版本均取消了 AppStore，我们无法直接通过 iTunes 下载 iOS 应用，就找到了老前辈。但老前辈穿越到未来是有问题滴！

请来后（安装好），旧版本 iTunes 无法运行，提示 `itunes library.itl` 不能用。常识问题，同一个时空不能出现两个一样的人，会不稳定的~ 直接寻找磁盘上的当代该文件，删除它（塞到异时空也可以），总之前辈要当唯一或得另立山头。

所以此前安装过最新的 iTunes 的小伙伴，记得要卸载干净！（否则会出现无法联网、连接设备错误等多种问题）
卸载顺序：
```none
iTunes
Apple Software Update
Bonjour
Apple Mobile Device Support
Apple Application Support（32-bit）
Apple Application Support（64-bit）
```

还有脾气？旧版本 iTunes 可能无法登陆手机号的账号，老一辈脾气怪，萝卜青菜各有所爱，那就得特意注册一个 Apple ID（邮箱账号）。擦汗~ 

---

我们接着伺候 Fiddler，安装完后找到路径 `Tools -> TelerikFiddler Options -> HTTPS` 如图勾选点击，安装证书，一路 yes 即可。

![](/images/fiddler.png)

不排除这位偷懒，直接给你证书导出到桌面就不管你了，此时我们只能自己双击打开安装证书。

还有情况！证书不管安装就算了，自己桌面也没有证书，或者安装完证书显示“该证书已过期，或者尚未生效”，玩呢？确定你找的是我介绍的祖宗？其他祖宗我不熟抱歉~

---

本来爱思自己就提供共享旧版下载的，而她也提供了绑定 Apple ID 下载苹果正版，一个顶三，但是咱也不知道她闹什么脾气抽哪门子的风，登陆账号始终报错异常，又不想用共享正版，只能自己折腾下载了。

![](/images/id_error.png)


## 0x03 总算开工了
### No.1
打开 iTunes，登录账号，同时搜索出你要降级的应用，**（这个时候不要点击下载！）**

![](/images/iTunes.png)

不同区会自动转换，点击确认即可。

![](/images/ZH.png)

嗯？老人家脾气又上来了？

![](/images/error_itunes.png)

把 Fiddler 关掉，ID 登录成功以后再打开，还不行万能关机重启大法，更换网络，其他没招了。

### No.2
[查询](https://tools.lancely.tech/apple/app-version/us/360593530) 所需要降级的应用版本号对应的**一串数字版本 ID**。

![](/images/id2.png)

若软件冷门，该网站查询不到，则用 Fiddler 打印版本 ID（详见 No.5）

### No.3
进入 Fiddler，点击键盘快捷键『F11』，左下角会出现一个红色的『T』，Fiddler 便开始抓包拦截。

![](/images/F11.png)

### No.4
返回 iTunes 的应用详情页面，点击『下载』或者『获取』按钮。

> 注：『更新』按钮有可能获取内购失败
以 Notability 为例测试，新版（免费版 11.0 之后）用过一段时间，更新获取 10.6 永久内购版，降级成功，但出现内购失败。具体原因未知。

![](/images/invalid.jpg)

![](/images/invalid1.jpg)

### No.5
返回 Fiddler，左侧界面会出现红色开头的 `pXX-buy.itunes.apple.com` 拦截链接。

要下载版本 ID 需要 `shift+F11` 解除全局断点，出现两项如上格式链接，选择 body 大的一项即 Host 为 `pXX-buy.itunes.apple.com` 格式 、URL 为 `/WebObjects/MZBuy.woa` 的请求，切换右侧至 Inspectors ，点击中间的黄色块 `Response body is encoded...Click here to decoded.`

![](/images/zhuabao.jpg)

然后网址点右键导出 App 的版本信息，`Save -> Response -> Response Body` （需要注意的是，如果没有点击黄色方块，将会保存一个乱码文件）保存为 `xx.xml`，打开后类似下图

![](/images/id.png)

搜索找到 `softwareVersionExternalIdentifiers`，其后一系列数字为该 APP 版本 ID。从上往下为该 App 自第一个版本起每个版本在 AppStore 中的版本 ID。

我们这里举例的 `Notability 10.6` 版本 ID 是 `844215920`

找到版本 ID，上面的可能已经开始下载最新版，删掉应用，重新下载，再次打开全局 F11，点击第一条指定格式拦截链接之后，再点击右侧界面的『Inspectors』—『TextView』，最后再点击下方的『Run to completion』

![](/images/fiddler0.png)

这时左侧就会出现 `pXX-buy.itunes.apple.com` 链接，再点击一下该链接，右侧出现该应用的最新版本 ID，我们只需将最新的版本 ID 更改为需要降级的版本 ID 即可。

![](/images/fiddler1.png)

修改完成后，再次点击右下方的『Run to completion』，接着直接关闭 Fiddler 即可。

> 不关闭也不影响，但如果下载速度一直比较慢或者不动，可以关闭 Fiddler 然后刷新一下就正常下载了。

> 或者不用全局 F11，（F11 电脑是截图快捷键冲突的小伙伴）
可以用 Fiddler 关键字断点，在 Fiddler 界面下方黑条窗口输入：
`bpu MZBuy.woa`（取消断点为输入 bpu），然后回车。

![](/images/cmd.png)

### No.6
返回 iTunes，这时可能会提示“下载错误”等提示，直接忽视，在搜索栏右侧点击下载页面重新下载即可。

![](/images/iTunes_success.png)

下载完成后，安装包会保存在默认路径中，打开『编辑』-『偏好设置』-『高级』，即可看到应用下载的路径。

![](/images/media.png)

找到安装包后，直接使用爱思助手，导入 ipa 安装包即可自动安装。

![](/images/1.png)

![](/images/2.png)

爱思助手下载的共享正版

![](/images/old_i4_nb.png)


## 0x04 成果检验
内购获取成功和非订阅新用户截图对比如下：

开始订阅定价

![](/images/old.jpg)

现在订阅定价

![](/images/old2.jpg)

成功截图

![](/images/success.jpg)


> 这个方法只能抓取 AppStore 可以下载的应用，已经下架应用就没办法了。
养成备份 ipa 安装包的好习惯还是很有必要的。


## 0x05 清奇脑回路 Q&A
Q: 淘宝低价买的、爱思助手装的，与这个自己抓包下载的区别？
> A: 淘宝买的一般也是从 AppStore 下的新版非旧版，爱思助手可以装历史版本，但和淘宝一样属于**共享正版**，即用别人 ID 下载的正版；而自己抓包下载，用的自己 ID，是真正属于自己的**苹果正版**，后期想更新或内购或卸载重装等操作都无影响。

Q: 别人下好的 ipa 我可以直接拿来用吗？
> A: 不行，安卓的 apk 和 iOS 的 ipa 文件是不一样的，iOS 的 ipa 文件内部是包含了账号信息的，安装时需要验证购买这个 APP 时所用 Apple 账号的密码，除非是你朋友发给你，再告诉你 Ta 的 Apple ID 账号密码，否则你是无法进行安装的。所以啊，自己动手，丰衣足食嘛！
（网上似乎有免验证的 ipa，但似乎需要重新签名，本小妖不懂哎~ 有大佬路过还请指点迷津）

Q: ipa 文件装完还有用吗？会过期吗？
> A: 这个安装包留着可以一直用到系统不支持为止。一般情况，只要我们把 ipa 文件下载下来，以后都能直接安装，换手机也不影响，就是所谓的『一次下载，终身受益』

Q: 怎么解决旧版 APP 的更新提示？
> A: 避免自己手贱不小心在 AppStore 中点到更新，我们可以在 ipa 文件进行安装之前，对 ipa 文件进行一点处理，来去除 AppStore 的更新检测，但这个也只能去除 AppStore 的更新检测，那些会联网检查版本的 App 不行，其他都能完美屏蔽更新提示。
方法就是右键 ipa 文件，用解压软件打开，没有解压选项的把后缀改为 rar/zip，然后删除里面的 `iTunesmeradata.plist` 这个文件后改回去即可。

Q: 可有其他安装方法：
> A: 旧版 iTunes 已经放权了，不能安装 ipa，所以得去装新版，这里推荐第三方工具安装旧版 App（爱思助手，pp助手好像得越狱）
亦可传到设备备份，用 JSBOX 安装


## 0x06 备用下载方式
> 小妖已经将工具打包好，文章链接失效无法访问的小伙伴可以在公众号聊天框回复 `ipa`，获取下载链接。
最后如果大家有用的话，不妨分享转发收藏一波，以防不时之需。


## 0x07 巨人的肩膀
[使用iTunes软件抓包下载旧版本ios的app教程](https://www.77nn.net/1273.html)
[硬核！完美降级iOS应用，降级任意版本](https://zhuanlan.zhihu.com/p/101541667)
[下载旧版app（Fiddler版）](https://brywmzl.github.io/Apple/Download-history-app/)
[苹果抓包怎么都不出 /webobjects/mzbuy.woa 的](https://zhidao.baidu.com/question/715169212992251805.html)
[悄悄发布的 iTunes 12.6.3，让你在电脑上管理 iOS 11 设备的 App](https://sspai.com/post/41220)
[iTunes 12.6 dmg on Mac Mojave](https://forums.macrumors.com/threads/apples-special-version-of-itunes-that-still-has-an-app-store-currently-incompatible-with-macos-mojave.2143244/page-4#post-26592234)
[iTunes 里搜不到应用了？还有这些方法可以在 PC 上访问 App Store](https://sspai.com/post/43062)
[ios手机如何安装回旧版的App](https://mp.weixin.qq.com/s/BB2GOBoguAVoGgoqMXQGvw)
[Charles](https://www.charlesproxy.com/download/)
[不越狱下载旧版app教程](https://mp.weixin.qq.com/s/Bm3qVPNfY_ghhZeE7axeyA)
[白嫖丨Notability 终身会员版，一键安装](https://mp.weixin.qq.com/s/bIixY6EQhGc6xyP8WobZeA)
[5分钟教你一键式安装iOS旧版APP（2020年有效）](https://zhuanlan.zhihu.com/p/42947889)
[如何下载旧版本的IPA文件？如何下载IOS旧版本的APP？](https://www.machunjie.com/macos/1103.html)
[Mac iTunes12.6.3](https://secure-appldnld.apple.com/itunes12/091-33628-20170922-EF8F0FE4-9FEF-11E7-B113-91CF9A97A551/iTunes12.6.3.dmg)
[Win iTunes64_12.6.3](https://secure-appldnld.apple.com/itunes12/091-33626-20170922-F51D3530-A003-11E7-8324-03D19A97A551/iTunes64Setup.exe)
[Win iTunes32_12.6.3](https://secure-appldnld.apple.com/itunes12/091-33627-20170922-EF8CB708-9FEF-11E7-8504-92CF9A97A551/iTunesSetup.exe)
[iTunes 降级教程：用旧版 iTunes 进行 App 备份](https://sspai.com/post/41195)
[IPSW iTunes 历史版本](https://ipsw.me/iTunes)
[iTunes The iPhone Wiki 最全历史版本下载](https://www.theiphonewiki.com/wiki/ITunes)
[iMazing](https://imazing.com/zh)
[Sunny 苹果工具 APP 历史版本查询](https://tools.lancely.tech/)
[Download Fiddler Classic](https://www.telerik.com/download/fiddler)
[Downloads iTunes（版本无 AppStore）](https://support.apple.com/downloads/itunes)
[使用 iTunes 在业务环境中部署应用 12.6.5](https://support.apple.com/zh-cn/HT208079)
[爱思助手](https://www.i4.cn/pro_pc.html)
