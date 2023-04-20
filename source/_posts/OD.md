---
title: OD 基础总结
date: 2020-03-22 21:34:49
categories: Binary
---
## 0x00 Preface

之前学了一段时间的 C 语言，算是打下了一点语言基础，接下来开始同步学习逆向的知识了，不得不说比起 WEB 方向，二进制方向的入门挺枯燥的，所以为了提前获得点愉悦感 & 成就感，同时了解点汇编的相关知识，开始学习《使用 OD 从零开始 Cracking》，因为其中部分例子比较繁复，特此精简，为后续复习做些笔记，软件中英文对照学习效果更好。

- 环境：`VMware 15.5.6` `Windows 10 Professional`
- 软件：`吾爱破解专用版 OllyDbg 1.10`

## 0x01 OD 初识
### OD 四个主要窗口

- 反汇编和数据窗口中间有一个**解释窗口。**

![](/images/od_windows.png)

#### 1.反汇编窗口（disassembler）

吾爱破解版 OD 已经默认勾选了自动对主模块进行分析，OD 会分析程序显示它的附加信息
```none
Options -> Debugging options -> Analysis1 -> Auto Start analysis of main module
```

通常 OD 显示程序的某些部分是不正确的，错误的将可执行代码解释为数据，这种情况，在**反汇编窗口**中右键选择 `Analysis -> Remove analysis from module` 手动删除分析结果。

![](/images/delete_analysis.png)

吾爱版已经默认高亮显示 jumps 和 calls，若需修改右键选择 `Appearance -> Highlighting`

![](/images/od_highlight.png)

#### 2.寄存器窗口（registers）

![](/images/register.png)

上图是寄存器和标志位。**显示模式的四种类型：**默认是 FPU 寄存器，比原版多了 MMX 寄存器。

#### 3.堆栈窗口（stack & pile）

> 注：我常见的堆是 heap，栈是 stack，但是 pile pila 也可翻译为堆，其中 pila 是原文的翻译，而堆栈又常常直接被 stack 指代，本文以堆（heap）栈（stack）为行文标准。

显示 ESP 和 EBP 寄存器指向地址的信息。默认显示 ESP 指向的信息（最重要），右键切换。

![](/images/stackwindows.png)

#### 4.数据窗口（dump）

这个窗口有很多显示模式，右键选择，默认模式为 8-byte Hex / ASCII，是最常用的，这里选择 `Special -> PE Header`，之后会用到。

![](/images/dump.png)

#### 5.菜单/控制面板上的图标按钮代表的窗口

![](/images/button1.png)

![](/images/button2.png)

- L 按钮或 `View -> Log`，显示日志窗口，通过配置显示 OD 启动时保存在日志窗口的不同类型信息，也涉及条件断点的信息。最重要选项是保存到文件，即把信息保存为文本文件，右键 `Log to file`

- E 或 `View -> Executables` 显示程序运行使用的模块：exe，dll，ocx 等。

- M 或 `View -> Memory` 显示程序映射到内存的信息，右键可搜索不同种类的字符串，可在访问上设置中断。

- T 或 `View -> Threads` 显示线程窗口。

- W 或 `View -> Windows` 显示程序窗口，若程序未运行，窗口为空白。

- H 或 `View -> Handles`，显示句柄窗口。

- C 或 `View -> CPU`，返回到主 (CPU) 窗口。

- / （原版）或 P （吾爱版）或 `View -> Patches`，显示程序修改信息。

- K 或 `View -> Call stack` 显示调用堆栈的窗口信息，尝试反向跟踪函数的调用顺序。

- B 或 `View -> Breakpoints` 显示程序普通断点的列表窗口，这里不显示硬件断点和内存断点。

- R 或 `View -> Reference` 参考窗口，显示在 OD 中搜索结果。

- ... 或 `View -> Run trace` 显示 RUN TRACE（RUN 跟踪）命令的结果。这里也可以通过 `Log to file` 保存。

- S 或 `View -> Source` 显示源码。

> 注：吾爱版里，鼠标悬停在图标上可以在左下角看到功能提示。

#### 6.设置实时调试 JIT

选择菜单 `Options -> Just-in-time debugging`
开启点击 `Make OD just-in-time debugger` 后再点击 `Done`
取消点击 `Restore old just-in-time debugger` 后再点击 `Done`

#### 7.关联插件

默认自带 `plugins` 目录，选择 `Options -> Appearance`，然后在窗口中选择 `Directories`

![](/images/plugin_content.png)

点击 `Pluginpath -> Browse` 选择你创建的文件夹，修改完成有弹窗提示则需要重启 OD，但在此之前需要拷贝刚下载的插件（解压后文件，通常只需复制 DLL 文件即可）。

卸载插件只需删除 `plugins` 文件夹内相关的 DLL 文件然后重启 OD。

#### 8.数值系统

正数从 00000000 到 7FFFFFFF，负数从 80000000 到 FFFFFFFF
7FFFFFFF 为十进制的 2147483647（最大正数）
80000000 为十进制的 -2147483648（最小负数）

- 如下图右键选择 `Modify`（或选中回车），可修改寄存器的值，这里可以完成不同的转换功能。第一栏填入需转换的十六进制值，第二栏会出现对应的十进制值。

![](/images/modify.png)

- 在 OD 中使用空格，可以使用 20（Hex）或 32（Dec）

![](/images/ODhex.png)

## 0x02 寄存器

- 数值以十六进制显示，ESP 指向栈顶，EIP 指向当前要执行的指令，?AX（问号用于查询寄存器的值）

- 16 位寄存器分低八位和高八位

![](/images/32_register.png)

- 改变寄存器的值
上面数值系统提到过，这里说一下特殊情况。EIP 在反汇编窗口选择`New origin here`

![](/images/EIP.png)

### 标志寄存器

![](/images/flag_register.png)

- C （进位标志）
无符号运算的结果，在超过最大数值时被设置，可能是寄存器的值。

- P （奇偶标志）
指令的结果用二进制表示时，该二进制数中 1 的总个数为偶数时被设置。

- A （辅助进位标志）
完成操作后，用其它的某种形式对其进行记录。

- Z （零标志）
最有用的一个标志，当运算产生的结果为 0 时被设置。

- S （符号标志）
运算结果为负时被设置。

- T 标志

- D 标志
置 0 时，数据窗口中串操作向下执行；置 1 时，向上执行。

- O （溢出标志）
当操作改变了符号位或结果超出了可能存取的最大值，返回错误值时被设置。

## 0x03 常用指令及寻址

### 1. 汇编指令

- NOP（无操作)
没有特殊用途。用一个短指令来替换一个长指令的话，处理器没有错误，则多余的空间会被 NOP 填充。适当数目的 NOP 指令可以将其他指令完全替换掉。

  - 在数据窗口中，右键 `Go to - Expression`（Ctrl + G）输入需要转到的地址。
  - 红色突出显示刚修改过的字节。
  - 撤销修改的指令，数据窗口或反汇编窗口，选中区域后右键 `UNDO         SELECTION`（Alt + backpace）

- PUSH（压/入栈）
将 操作数 / 寄存器 / 特定内存地址的值 压入堆栈中。新压入的数据总是在堆栈顶部，不会改变下面的数据。
`PUSH 401008` 堆栈中将被放置 401008
`PUSH [401008]` 内存单元中存储值，在数据窗口中查看。

  - 堆栈中存放数据窗口中颠倒过来的值，读/写内容在内存中倒序放置是处理器特点之一。
  - `PUSH DWORD PTR DS:[401008]` OD 默认操作 4 个字节的内存，即 `DWORD`，2 字节 `WORD`，1 字节 `BYTE`。
  - ESP 中存放当前堆栈顶部的内存地址。

![](/images/push_401008.png)

- POP（弹/出栈）
弹出堆栈，取出堆栈顶部第一个字母或值，存放到指定的目标地址内存单元中。

- PUSHAD
把所有通用寄存器值按一定顺序压入堆栈中，相当于 `PUSH EAX, PUSH ECX, PUSH EDX, PUSH EBX, PUSH ESP, PUSH EBP, PUSH ESI, PUSH EDI`

- POPAD
从堆栈中取值放到相应的寄存器中，相当于 `POP EDI, POP ESI, POP EBP, POP ESP, POP EBX, POP EDX, POP ECX, POP EAX`

  - PUSHAD 和 POPAD 经常使用，如需保存所有寄存器的内容，然后修改寄存器的值，或进行堆栈的相关操作，然后使用 POPAD 恢复原来的状态。

- PUSHA 等价于 `PUSH AX, CX, DX, BX, SP, BP, SI, DI`

- POPA 等价于 `POP DI, SI, BP, SP, BX, DX, CX, AX`

- MOV（传送指令）
将第二个操作数赋值给第一个操作数。其中如 `MOV DWORD PTR DS:[400500],EAX` 写入内存地址可能会导致内存访问异常，则为没有写入权限。

- MOVSX（带符号扩展的传送指令）
第一个操作数的位数比第二个多，第二个操作数的符号位（正 0 负 F）填充第一个剩余部分。

- MOVZX（带 0 扩展的传送指令）
剩余部分不根据第二个操作数的正负进行填充，而总是被填充为 0。

- LEA（取地址指令）
类似于 MOV，第一个操作数是一个通用寄存器，第二个操作数是一个内存单元。当计算要依赖于之前结果时，这个指令非常有用。

  - 下面情况有括号，但只需计算 ECX+38 的值，然后将结果赋值给 EAX。
  - 因为完成的是赋值操作，所以会认为操作数是内存单元中的值，但实际上操作数是内存单元的地址，解释窗口 `Stack address=00401038` 已表明。

![](/images/lea_eax.png)

- XCHG (交换 寄存器 / 内存单元 和 寄存器) 
该指令交换两个操作数的值。存在对内存地址没有写入权限的情况。

### 2. 数学指令

- INC DEC（增减 1 指令）

- ADD ADC（带进位的加法）

- SUB SBB（带进位的减法）

- MUL（无符号数的乘法）
只有一个操作数，另一个操作数是 EAX，结果存放到 EDX:EAX 中。

  - 先存放到 EAX，若空间不够则继续存放在 EDX，否则，EDX 置零，即乘积高 32 位存放在 EDX，低 32 位存放在 EAX
  - 下图理解偏误写成了 EAX:EDX，有幸请教了看雪讲师苏大哥，错误原因如下图，为谨记就不改图了！特此注意！！
![](/images/su.png)

![](/images/EAX-EDX.png)

- IMUL（有符号数的乘法）
它允许使用多达三个操作数。第一个操作数保存后两个操作数相乘的结果，或者第一个操作数保存两个操作数相乘的结果。

  - 数字开头不能为字符，故可以在开头补 0 解决。多个操作数存放在一个寄存器的时候，容纳不下结果只能保存能够容纳的部分，从最高位依次丢弃。
最好的方式是一个操作数，结果存放到 EDX:EAX 中，即拥有两倍大小。（图中 EAX:EDX 写法错误）

- DIV IDIV（无/有符号除法）

- XADD（交换并相加）即 XCHG 和 ADD 两个指令的组合。

- NEG（符号取反）

- AND OR XOR NOT（按位与/或/异或/取反）

### 3. 比较和条件跳转指令

- CMP 比较两个操作数，相等时零标志位置 1

- TEST（逻辑比较）两个数值进行与操作，改变 P, Z, S 标志位，确定操作数是否等于 0

- JMP（无条件跳转）

- JE，JZ（结果为零跳转）JNE，JNZ

- JS（结果为负跳转）JNS

- JP，JPE（结果中偶数个 1 跳转）JNP，JNPE

- JO（结果溢出跳转）JNO
---
- JA，JNBE（大于跳转）无符号数

- JB，JNAE（小于跳转）无符号数

- JAE，JNB（大于等于跳转）无符号数

- JBE，JNA（小于等于跳转）无符号数

> 当进位/借位标志位 C 与零标志位 Z 都为 0 时发生跳转。
---
- JG，JNLE（大于跳转）有符号数

- JL，JNGE（小于跳转）有符号数

- JGE，JNL（大于等于跳转）有符号数

- JLE，JNG（小于等于跳转）有符号数

> 根据符号标志位 S 决定是否跳转。
---

### 4. CALL RETN

- F7 跟进 CALL
- 回车 查看 CALL 子程序
- `-` 返回 CALL 处
- 堆栈处回车 返回到地址
- F8 执行下一条语句
- 如果返回地址没有标红，每次修改完代码之后需重新分析代码。

![](/images/re_analysis.png)

![](/images/re_analysis2.png)

### 5. 循环、字符串指令及寻址
```asm
XOR ECX,ECX
ADD ECX,15 / MOV ECX,15
Label:
DEC ECX
;循环体
TEST ECX,ECX / CMP ECX,0
JNE Label
```

![](/images/loopd.png)

- LOOP
将计数器 ECX 的值减 1，判断 ECX 的值是否为 0，若为 0 就跳转到指定地址。

![](/images/loopd2.png)

- LOOPZ，LOOPE 循环到零标志位置 1，LOOPNZ，LOOPNE 循环到零标志位清 0
  - 只有计数器的值和零标志位同时满足条件时才循环。

- MOVS
从一个地址向另一个地址复制数据。源地址保存在 ESI，目的地址保存在 EDI。

  - MOVS 拷贝 4 个字节内容为 MOVSD，拷贝两个字节为 MOVSW，拷贝一个字节为 MOVSB。
注意 ESI，EDI 拷贝的方向，拷贝的方向取决于方向标志位 D。

![](/images/Immediate.png)

- REP
此前缀表示当前指令需要执行的次数 ECX，每次循环计数器 ECX 值递减 1。
  - REP MOVS 不一定拷贝 4 个字节，它拷贝的大小为每次拷贝的大小 \* ECX，源指针 ESI 和目的指针 EDI 每次递增 4 或递减 4（递增或递减取决于方向标志位 D）

![](/images/rep_movs.png)

- LODS
从源地址 ESI 拷贝数据到 EAX。REP 可配合使用。衍生 LODSW 和 LODSB。

- STOS
将 EAX 值拷贝到 EDI 指向的内存单元。

- CMPS
比较 ESI 和 EDI 指向内存单元的内容。差值为 0，零标志位置 1。

  - 配合 REPE/REPZ 使用，直到计数器 ECX 值为 0 或零标志位清 0 停止比较。

- 直接寻址
操作数中包含一个具体的地址。地址的值是纯数字。
```yml
MOV DWORD PTR [00513450], ECX

MOV AX, WORD PTR [00510A25]

CALL 452200

JMP 421000
```

- 间接寻址
```yml
MOV DWORD PTR[EAX], ECX

CALL EAX

JMP [EBX + 4]
```

- 想在指令执行之前看到真实地址，需要在该指令上下断点，然后运行到断点，查看寄存器的值或解释窗口中的信息。
使用间接寻址的指令，只能在执行这条指令的时候获取地址当前的值。

- 调用任何子程序,堆栈顶部存放的都是返回地址。

![](/images/search.png)

## 0x04 断点
### 普通断点
当我们设置断点后，OD 会将对应指令处第一个字节指令替换成 CC。
F2，BP 命令栏设置断点
BPX 可以给引用或者调用了指定 API 函数的指令都下断点。

### 内存断点
内存访问断点有时候也称之为 BPM，但是不要与 SoftIce 中的 BPM 弄混淆了。
这种类型的断点修改内存页的访问属性。
内存访问断点有两个缺点:1.它们不会出现\[B]断点列表中和其他的地址。所以,你必须记得设置在什么地址处。2.不能同时设置多个内存断点。如果你设置了一个那么你之前设置的就会被自动删除。

### 硬件断点
最多可以设置 4 个硬件断点。
硬件执行断点与普通断点作用一样,但硬件执行断点并不会将指令首字节修改为 CC,所以更难检测。命令行 HE 设置。
硬件访问/写入断点是断在触发硬件断点的下一条指令处。

### 条件断点
条件断点实际上就是普通断点。

### 条件记录断点
日志精确记录。

### 消息断点
消息断点在内核调试器 SoftICE 中也称为 BMSG。
普通断点在程序启动之前就可以设置,但是对于消息断点来说,只有在窗口创建之后才能够设置消息断点以及拦截消息。

## 0x05 Others
### 异常
- 内存访问异常
Characteristics(特征)为CODE,EXECUTE,READ(代码段,可执行,可读)。

- 除0异常

- 无效指令，尝试执行特权指令异常:
当 CPU 试图执行越权指令的话就会产生该异常。最典型是 INT 3

- SEH链或结构化异常处理，它是用来确保该程序可以从错误中恢复。

### 壳
壳的解密例程(外壳程序)首先会定位加密/压缩过的原程序的各个区段,将其解密/解压,然后跳转至 OEP (程序未加壳时的入口点)处开始执行。

- 通常脱壳的基本步骤如下:

1:寻找 OEP

2:转储(传说中的 dump)

3:修复 IAT(修复导入表) IT = 导入表 IAT = 输入函数地址表

4:检查目标程序是否存在 AntiDump 等阻止程序被转储的保护措施,并尝试修复这些问题。

- Import REConstructor 重建 IAT 需要三项指标:

1)IAT的起始地址，减去映像基址 400000 就得到了(RVA:相对虚拟地址)。

2)IAT的大小

3)OEP = 虚拟地址 - 映像基址 = OEP 的 RVA

## 0x06 Postscript
本来写完了，结果简书的自动保存日常抽风，写了八个小时全没了，所以第二次写的时候语言再次精炼了一遍！文章中我尽可能一句话阐明指令定义，缩短文章篇幅，以便于复习查询。下一篇继续整理相关断点和硬编码序列号寻踪的知识点。

## 0x07 References
*《使用OD从零开始Cracking》*