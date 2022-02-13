---
title: C++ 学习笔记之基础篇
date: 2022-01-04 14:59:15
categories: Programming
---
## 0x00 Preface
这个假期打算入门 C++，为后期刷 leetcode 做准备，此笔记主要整理不同于 C 的地方，补充明确之前没写到的细节，面向有 C 基础人群~

## 0x01 main
- 注：C++ 在创建变量时，必须给变量一个初始值，否则会报错

### 关键字
| asm        | do           | if               | return      | typedef  |
| ---------- | ------------ | ---------------- | ----------- | -------- |
| auto       | double       | inline           | short       | typeid   |
| bool       | dynamic_cast | int              | signed      | typename |
| break      | else         | long             | sizeof      | union    |
| case       | enum         | mutable          | static      | unsigned |
| catch      | explicit     | namespace        | static_cast | using    |
| char       | export       | new              | struct      | virtual  |
| class      | extern       | operator         | switch      | void     |
| const      | false        | private          | template    | volatile |
| const_cast | float        | protected        | this        | wchar_t  |
| continue   | for          | public           | throw       | while    |
| default    | friend       | register         | true        |          |
| delete     | goto         | reinterpret_cast | try         |          |

- 字符型变量并不是把字符本身放到内存中存储，而是将对应的ASCII编码放入到存储单元。

### 转义字符
| 转义字符 | 含义                                | ASCII 码值（十进制） |
| ------------ | --------------------------------------- | ----------- |
| \a           | 警报                                    | 007         |
| \b           | 退格(BS) ，将当前位置移到前一列         | 008         |
| \f           | 换页(FF)，将当前位置移到下页开头        | 012         |
| **\n**       | **换行(LF) ，将当前位置移到下一行开头** | **010**     |
| \r           | 回车(CR) ，将当前位置移到本行开头       | 013         |
| **\t**       | **水平制表(HT)  （跳到下一个TAB位置）** | **009**     |
| \v           | 垂直制表(VT)                            | 011         |
| **\\\\**     | **代表一个反斜线字符**                 | **092**     |
| \'           | 代表一个单引号字符                      | 039         |
| \"           | 代表一个双引号字符                      | 034         |
| \?           | 代表一个问号                            | 063         |
| \0           | 数字 0                                  | 000         |
| \ddd         | 8进制转义字符，d 范围 0~7                 | 3位8进制    |
| \xhh         | 16进制转义字符，h 范围 0~9，a~f，A~F      | 3位16进制   |

- 字符串型 `string 变量名 = "字符串值"`

> 注：需加入 `#include <string>`

输入：`cin >> 变量名`
输出：`cout << 变量名`

- 只有整型变量可以进行取模运算

- switch 语句中表达式类型只能是整型或者字符型

![](/images/cpp_for.png)

- 值传递时，形参是修饰不了实参的；地址/指针传递可改变

- 在头文件中写函数声明，在源文件中写函数定义

### 指针
- 空指针：指针变量指向内存中编号为 0 的空间（内存编号 0 ~255 为系统占用内存，不允许用户访问）

- 野指针：指针变量指向非法的内存空间

- const 修饰指针 --- 常量指针 //指针指向可以改，指针指向的值不可以更改
const 修饰常量 --- 指针常量 //指针指向不可以改，指针指向的值可以更改

> 看 const 右侧紧跟着的是指针还是常量, 是指针就是常量指针，是常量就是指针常量

### 内存分区模型
C++ 程序在执行时，内存分为：

- 程序运行前：
  - 代码区：存放函数体的二进制代码，由操作系统进行管理的，特点是共享和只读
  - 全局区：存放全局变量、静态变量、常量
	- 常量区：存放全局常量、字符串常量
- 程序运行后：
  - 栈区：由编译器自动分配释放，存放函数的参数值、局部变量、局部常量
  > 注：不要返回局部变量的地址
  - 堆区：由程序员分配和释放，若程序员不释放，程序结束时由操作系统回收

利用 new 在堆区开辟内存，new 创建的数据，会返回该数据类型的指针；利用 delete 释放

```C++
int* a = new int(10);
delete a;

int* arr = new int[10];
delete[] arr;
```

### 引用
`数据类型 &别名 = 原名`

- 引用必须初始化，且初始化后，不可以改变

- 函数传参时，可以利用引用让形参修饰实参，简化指针修改实参

```C++
//1. 值传递
void mySwap01(int a, int b) {
	int temp = a;
	a = b;
	b = temp;
}

//2. 地址传递
void mySwap02(int* a, int* b) {
	int temp = *a;
	*a = *b;
	*b = temp;
}

//3. 引用传递
void mySwap03(int& a, int& b) {
	int temp = a;
	a = b;
	b = temp;
}
```

- 如果函数做左值，那么必须返回引用

```C++
//返回静态变量引用
int& test() {
	static int a = 20;
	return a;
}

test() = 1000;
```

- 引用的本质在 C++ 内部实现是一个指针常量
`int& ref = a;` = `int* const ref = &a`

- 常量引用用来修饰形参，防止形参改变实参
`void showValue(const int& v)`

```C++
//int& ref = 10;  引用本身需要一个合法的内存空间，因此这行错误
//加入const就可以了，编译器优化代码，int temp = 10; const int& ref = temp;
const int& ref = 10;
```

### 函数提高
```C++
//如果某个位置参数有默认值，那么从这个位置往后，从左向右，必须都要有默认值
int func(int a, int b = 10, int c = 10) {
	return a + b + c;
}

//如果函数声明有默认值，函数实现的时候就不能有默认参数
int func2(int a = 10, int b = 10);
int func2(int a, int b) {
	return a + b;
}
```

```C++
//函数占位参数，调用函数时必须填补
void func(int a, int) {}
```

函数重载满足条件：

- 同一个作用域下
- 函数名称相同
- 函数参数类型不同 或 个数不同 或 顺序不同

> 函数的返回值不可以作为函数重载的条件
> 引用作为重载条件
> 函数重载碰到函数默认参数，产生歧义，需要避免

### 类和对象
C++ 面向对象的三大特性：封装、继承、多态

对象上有其属性和行为，具有相同性质的对象，可以抽象称为类

#### 封装
1. 类在设计时，属性和行为写在一起，表现事物
`class 类名{ 访问权限： 属性 / 行为 };`

2. 类在设计时，可以把属性和行为放在不同权限下加以控制

访问权限：

- public 公共权限
- protected 保护权限
- private 私有权限



#### 继承


#### 多态


```C++

```







## 0x0 References
> [C++ 匠心之作](https://github.com/AnkerLeng/Cpp-0-1-Resource)
> 《C++ Primer Plus》
> 《C++ Primer》

## 0x0 Postscript

