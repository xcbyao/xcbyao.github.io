---
title: 解决某些软件无法在虚拟机中运行的方法
date: 2022-01-02 13:01:53
categories: BUG
---
> Reference：https://www.cnblogs.com/RM-Anton/p/9113826.html
https://www.daimajiaoliu.com/daima/60c5a5fa94e6c08
https://www.52pojie.cn/thread-701845-1-1.html

在虚拟机内下载并安装某软件，直接打开会被提示 “Sorry, this application cannot run under a Virtual Machine”，

意思就是“对不起，这个应用不能在虚拟机上运行”。

这时候我们需要先关闭虚拟机（不关闭之后的修改无效），

找到在新建虚拟机时系统的安装目录（不是软件虚拟机的安装目录），

找到目录下的类似于 “Windows 10 x64.vmx” 的文件。

找到后以记事本的方式打开该文件，

在文本的末尾增加如下内容并保存：

```none
monitor_control.restrict_backdoor = "TRUE"
```

重新打开虚拟机，运行软件，现在就能够正常打开软件了。

备注：如果还是不行，可以再打开文件 “Windows 10 x64.vmx”，最后再增加一行：

```none
disable_acceleration = "TRUE"
```

---

原因：是因为此程序会自动执行虚拟机检测，从而禁止在虚拟机运行。
解决办法：打开 VMware 虚拟机的配置文件，一个后缀为 vmx 的文本文件。在里面加入以下内容
```none
isolation.tools.getPtrLocation.disable = "TRUE"
isolation.tools.setPtrLocation.disable = "TRUE"
isolation.tools.setVersion.disable = "TRUE"
isolation.tools.getVersion.disable = "TRUE"
monitor_control.disable_directexec = "TRUE"
monitor_control.disable_chksimd = "TRUE"
monitor_control.disable_ntreloc = "TRUE"
monitor_control.disable_selfmod = "TRUE"
monitor_control.disable_reloc = "TRUE"
monitor_control.disable_btinout = "TRUE"
monitor_control.disable_btmemspace = "TRUE"
monitor_control.disable_btpriv = "TRUE"
monitor_control.disable_btseg = "TRUE"
```
