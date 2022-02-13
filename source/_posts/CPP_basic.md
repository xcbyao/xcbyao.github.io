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
> 引用可以作为重载条件
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

- struct 默认权限为公共
- class 默认权限为私有

#### 对象的初始化和清理
编译器提供的构造函数和析构函数是空实现。

- 构造函数：创建对象时为对象的成员属性赋值，构造函数由编译器自动调用
- 析构函数：对象销毁前系统自动调用，执行一些清理工作

构造函数语法：`类名(){}`

析构函数语法：`~类名(){}`

1. 构造 / 析构函数，没有返回值也不写 void
2. 函数名称与类名相同
3. 构造 / 析构函数可以 / 不可以有参数，因此可以 / 不可以发生重载
4. 程序在 调用对象时 / 对象销毁前 会自动调用构造 / 析构，无须手动调用，而且只会调用一次

​按参数分为：有参 / 无参构造（默认构造函数）
​按类型分为：普通 / 拷贝构造

调用方式：括号法 `Person p1(10);`、​显示法 `Person p2 = Person(10); `、​隐式转换法 `Person p3 = 10;`

> 注：调用无参构造函数不能加括号，如果加了编译器认为这是一个函数声明
`Person(10)` 单独写就是匿名对象，当前行结束之后，马上析构
`Person p4(p3);` 不能利用 拷贝构造函数 初始化匿名对象，编译器认为是对象声明

```C++
//拷贝构造函数
Person(const Person& p) {
	age = p.age;
}
```

拷贝构造函数调用时机通常有三种情况：

1. 使用一个已经创建完毕的对象来初始化一个新对象
```C++
void test01() {
	Person man(100); //p对象已经创建完毕
	Person newman(man); //调用拷贝构造函数
	Person newman2 = man; //拷贝构造
}
```

2. 值传递的方式给函数参数传值
```C++
//相当于 Person p1 = p;
void doWork(Person p1) {}
void test02() {
	Person p; //无参构造函数
	doWork(p);
}
```

3. 以值方式返回局部对象
```C++
Person doWork2() {
	Person p1;
	cout << (int *)&p1 << endl;
	return p1;
}

void test03() {
	Person p = doWork2();
	cout << (int *)&p << endl;
}
```

默认情况下，C++ 编译器至少给一个类添加 3 个函数

1. 默认构造函数(无参，函数体为空)

2. 默认析构函数(无参，函数体为空)

3. 默认拷贝构造函数，对属性进行值拷贝

构造函数调用规则如下：

- 如果用户定义有参构造函数，C++ 不再提供默认无参构造，但是会提供默认拷贝构造
- 如果用户定义拷贝构造函数，C++ 不再提供其他构造函数

深浅拷贝是面试经典问题，也是常见的一个坑

- 浅拷贝：简单的赋值拷贝操作
- 深拷贝：在堆区重新申请空间，进行拷贝操作

```C++
Person(const Person& p) {
	m_height = new int(*p.m_height);
}
```

> 如果不利用深拷贝在堆区创建新内存，会导致浅拷贝带来的重复释放堆区问题
如果属性有在堆区开辟的，一定要自己提供拷贝构造函数，防止浅拷贝带来的问题

C++ 提供了初始化列表语法，用来初始化属性

`构造函数()：属性1(值1),属性2（值2）... {}`

```C++
//传统方式初始化
Person(int a, int b, int c) {
	m_A = a;
	m_B = b;
	m_C = c;
}

//初始化列表方式初始化
Person(int a, int b, int c) :m_A(a), m_B(b), m_C(c) {}
```

- 类对象作为类成员
类中的成员可以是另一个类的对象，我们称该成员为 对象成员
先调用对象成员的构造，再调用本类构造，析构顺序与构造相反

- 静态成员变量
所有对象共享同一份数据
在编译阶段分配内存
类内声明，类外初始化

  - 静态成员变量两种访问方式
```C++
//1、通过对象
Person p1;
p1.m_A = 100;
cout << "p1.m_A = " << p1.m_A << endl; //链式编程

//2、通过类名
cout << "m_A = " << Person::m_A << endl;
```

- 静态成员函数
所有对象共享同一个函数
静态成员函数只能访问静态成员变量

  - 静态成员变量两种访问方式
```C++
//1、通过对象
Person p1;
p1.func();

//2、通过类名
Person::func();
```

- 类内的成员变量和成员函数分开存储，只有非静态成员变量才属于类的对象上，静态成员变量/函数不占对象空间，函数也不占对象空间，所有函数共享一个函数实例

this 指针指向被调用的成员函数所属的对象，是隐含每一个非静态成员函数内的一种指针，不需要定义，直接使用即可

用途：

- 当形参和成员变量同名时，可用 this 指针来区分
```C++
Person(int age) {
	this->age = age;
}
```

- 在类的非静态成员函数中返回对象本身，可使用 `return *this`

- 空指针，可以调用成员函数，但如果成员函数中用到了 this 指针，就不可以了
```C++
void test() {
	Person * p = NULL;
	p->ShowClassName(); 
}
```

#### const 修饰成员函数
常函数：

- 成员函数后加 const 后我们称为这个函数为常函数
- 常函数内不可以修改成员属性
- 成员属性声明时加关键字 mutable 后，在常函数中依然可以修改
```C++
//this 指针的本质是一个指针常量，指针的指向不可修改
//如果想让指针指向的值也不可以修改，需要声明常函数
void ShowPerson() const {
	//const Type* const pointer;
	//this = NULL; //不能修改指针的指向 Person* const this;

	//const 修饰成员函数，表示指针指向的内存空间的数据不能修改，除了 mutable 修饰的变量
	this->m_B = 100;
}

mutable int m_B;
```

常对象：

- 声明对象前加 const 称该对象为常对象
- 常对象只能调用常函数
```C++
const Person person;
cout << person.m_A << endl;
//person.mA = 100; //常对象不能修改成员变量的值，但是可以访问
person.m_B = 100; //但是常对象可以修改 mutable 修饰成员变量
```

#### 友元
让一个函数或类访问另一个类中私有成员，关键字 `friend`

友元的三种实现：

- 全局函数做友元
```C++
class Building {
	//告诉编译器 goodGay 全局函数 是 Building 类的好朋友，可以访问类中的私有内容
	friend void goodGay(Building * building);
}
```

- 类做友元
```C++
class Building {
	//告诉编译器 goodGay 类是 Building 类的好朋友，可以访问到 Building 类中私有内容
	friend class goodGay;
}
```

- 成员函数做友元
```C++
class Building {
	//告诉编译器 goodGay 类中的 visit 成员函数是 Building 好朋友，可以访问私有内容
	friend void goodGay::visit();
}
```

#### 运算符重载
对已有的运算符重新进行定义，赋予其另一种功能，以适应不同的数据类型

- 加号运算符重载
作用：实现两个自定义数据类型相加的运算

```C++
//全局函数实现 + 号运算符重载
Person operator+(const Person& p1, const Person& p2) {
	Person temp(0, 0);
	temp.m_A = p1.m_A + p2.m_A;
	temp.m_B = p1.m_B + p2.m_B;
	return temp;
}

//运算符重载 可以发生函数重载 
Person operator+(const Person& p2, int val) {
	Person temp;
	temp.m_A = p2.m_A + val;
	temp.m_B = p2.m_B + val;
	return temp;
}

Person p3 = p2 + 10; //相当于 operator+(p2,10)
```

> 总结：对于内置的数据类型的表达式的的运算符是不可能改变的，不要滥用运算符重载

- 左移运算符重载
作用：重载左移运算符配合友元可以输出自定义数据类型

```C++
//全局函数实现左移重载
//ostream对象只能有一个
ostream& operator<<(ostream& out, Person& p) {
	out << "a:" << p.m_A << " b:" << p.m_B;
	return out;
}
```

- 递增运算符重载
作用：通过重载递增运算符，实现自己的整型数据

```C++
MyInteger() {
	m_Num = 0;
}

//前置++
MyInteger& operator++() {
	//先++
	m_Num++;
	//再返回
	return *this; //前置递增返回引用
}

//后置++
MyInteger operator++(int) {
	//先返回
	MyInteger temp = *this; //记录当前本身的值，然后让本身的值加 1，但是返回的是以前的值，达到先返回后 ++
	m_Num++;
	return temp; //后置递增返回值
}
```

- 赋值运算符重载
C++ 编译器至少给一个类添加 4 个函数

1. 默认构造函数(无参，函数体为空)
2. 默认析构函数(无参，函数体为空)
3. 默认拷贝构造函数，对属性进行值拷贝
4. 赋值运算符 `operator=`，对属性进行值拷贝

如果类中有属性指向堆区，做赋值操作时也会出现深浅拷贝问题

```C++
//重载赋值运算符
Person& operator=(Person &p) {
	if (m_Age != NULL) {
		delete m_Age;
		m_Age = NULL;
	}
	//编译器提供的代码是浅拷贝
	//m_Age = p.m_Age;

	//提供深拷贝 解决浅拷贝的问题
	m_Age = new int(*p.m_Age);

	//返回自身
	return *this;
}
```

- 关系运算符重载
作用：可以让两个自定义类型对象进行对比操作

```C++
bool operator==(Person & p) {
	if (this->m_Name == p.m_Name && this->m_Age == p.m_Age) {
		return true;
	}
	else {
		return false;
	}
}

bool operator!=(Person & p) {
	if (this->m_Name == p.m_Name && this->m_Age == p.m_Age) {
		return false;
	}
	else {
		return true;
	}
}
```

- 函数调用 () 运算符重载
  - 由于重载后使用的方式非常像函数的调用，因此称为仿函数
  - 仿函数没有固定写法，非常灵活

```C++
class MyAdd {
public:
	int operator()(int v1, int v2) {
		return v1 + v2;
	}
};

void test02() {
	MyAdd add;
	int ret = add(10, 10);
	cout << "ret = " << ret << endl;

	//匿名对象调用  
	cout << "MyAdd()(100,100) = " << MyAdd()(100, 100) << endl;
}
```

#### 继承


```C++

```
```C++

```

#### 多态



```C++

```

```C++

```






## 0x0 References
> [C++ 匠心之作](https://github.com/AnkerLeng/Cpp-0-1-Resource)
> 《C++ Primer Plus》
> 《C++ Primer》

## 0x0 Postscript
