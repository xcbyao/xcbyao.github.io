---
title: debug resolution
date: 2023-04-24 10:21:53
categories: Programming
---
# Pref

整理一些报错及处理方案。

# python

## NameError

- Date: 23/04/23
- Error:
`NameError: name 'mesage' is not defined`
- Cause: 命名错误
- Solve: 可能上下文拼写问题
```python
message = "Hello Python Crash Course reader!"
print(message)
```
- Refer:
《python编程从入门到实践第二版》P61

## SyntaxError

- Date: 23/04/24
- Error:
`SyntaxError: invalid syntax`
- Cause: 符号错误，一般单双引号引起
- Solve: 双引号内嵌单引号
```python
message = "One of Python's strengths is its diverse community."
print(message)
```
- Refer:
《python编程从入门到实践第二版》P71

## IndexError

- Date: 23/04/24
- Error:
`IndexError: list index out of range`
- Cause: 列表索引错误
- Solve: 检查索引
```python
motorcycles = ['honda', 'yamaha', 'suzuki']
print(motorcycles[2])
```
- Refer:
《python编程从入门到实践第二版》P102

## IndentationError

- Date: 23/04/24
- Error:
`IndentationError: expected an indented block`
- Cause: 缩进错误
- Solve: 修改缩进
```python
for magician in magicians:
    print(magician)
```
- Refer:
《python编程从入门到实践第二版》P111

## TypeError - 修改元组元素

- Date: 23/04/24
- Error:
`TypeError: 'tuple' object does not support item assignment`
- Cause: 修改元组元素
- Solve: 元组元素不可变
```python
dimensions = (200, 50)
# dimensions[0] = 250 错误
```
- Refer:
《python编程从入门到实践第二版》P130

## KeyError - 字典键值读取

- Date: 23/04/21
- Error:
`KeyError: 'points'`
- Cause: print() 输出的字典键值不存在
- Solve: 用 get() 访问值，不存在时返回一个默认值
```python
alien = {'color': 'green', 'speed': 'slow'}
# print(alien['points']) 报错
point_value = alien.get('points', 'No point value assigned.') # get() 第二个参数留空，默认返回 None
print(point_value)
```
- Refer:
《python编程从入门到实践第二版》P176

## TypeError - 输入数值读取

- Date: 23/04/22
- Error:
`TypeError: unorderable types: str() >= int()`
- Cause: input() 返回字符串，用作数值时报错
- Solve: 采用 int()
```python
age = input("How old are you? ")
# age >= 18 报错
age = int(age)
age >= 18
```
- Refer:
《python编程从入门到实践第二版》P200

## TypeError - 实参错误

- Date: 23/04/22
- Error:
`TypeError： user_age() missing 2 required positional arguments: 'name' and 'age'`
- Cause: 没有指定实参
- Solve: 指定实参
```python
def user_age(name, age):
    print(f"{name}: {age}")
# user_age() 报错
```
- Refer:
《python编程从入门到实践第二版》P229

## ZeroDivisionError

- Date: 23/04/23
- Error:
`ZeroDivisionError: division by zero`
- Cause: 除以 0
- Solve: 设置异常
```python
try:
    print(5/0)
except ZeroDivisionError:
    print("You can't divide by zero!")
```
- Refer:
《python编程从入门到实践第二版》P308

## FileNotFoundError

- Date: 23/04/23
- Error:
`FileNotFoundError: [Errno 2] No such file or directory: 'alice.txt'`
- Cause: 文件不存在，或文件名错误
- Solve: 设置异常
```python
filename = 'alice.txt'
try:
    with open(filename, encoding='utf-8') as f:
        contents = f.read()
except FileNotFoundError:
    print(f"Sorry, the file {filename} does not exist.")
```
- Refer:
《python编程从入门到实践第二版》P312







## todo

## 字符串连接问题

- Date: 23/03/23
- Error:
`TypeError: can only concatenate str (not "bytes") to str`
- Cause: python2/3 版本差异
- Solve: 前缀 b 指明格式
```python
out = response.replace(';', ';\n')  out = response.replace(b';', b';\n')
context.log_level = 'debug'
payload = b'a'*8 + p32(0x00000786)
```
- Refer:
[Python 字符串前面加u,r,b,f的含义](https://blog.csdn.net/sinat_38682860/article/details/108848994)

# C/C++

## 流对象和布尔类型的比较

- Date: 23/04/14
- Error:
二进制 `==` 没有找到接受 `std::basic_istream<char,std::char_traits<char>>` 类型的左操作数的运算符(或没有可接受的转换)
- Cause: `while ((cin >> weight) == 0)` VS2019 编译器对于流对象和布尔类型的比较操作进行了限制。
- Solve: 显式转换布尔类型
```C++
bool cin_weight = static_cast<bool>(cin >> weight); //第一种
/*
(cin >> weight) 的返回值是流对象 cin，而不是读取的值。这里实际上是将流对象隐式转换为布尔类型，若不需要处理读取操作失败的情况，可直接使用 while (cin >> weight) 来循环读取输入。

第二种，输入字母符号，和 weight 类型不同，读取失败，0==0 为真，执行循环；反之不执行。
*/
while (bool(cin >> weight) == 0) {
	fflush(stdin);
	Sleep(1000);
	cout << "请输入整数或浮点数！为避免死循环，程序已自动退出" << endl;
	system("pause");
	flag = false;
	exit(1);
}
```
- Refer:
小型超市商品管理系统 GPT-3.5



