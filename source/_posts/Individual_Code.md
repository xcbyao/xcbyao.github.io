---
title: Code Segment
date: 2021-03-29 10:54:22
categories: Programming
---
### 000 判断一个整数是否是 2 的整数次幂
```C
#include <stdio.h>

/* 利用位与 & 运算，判断一个整数是否是 2 的整数次幂,
   根据位与的特点可知 m & (m - 1) 的结果为 0 */

int num;
int func(int num)
{
	if ((num > 0) && (num & (num - 1)) == 0)
	{
		printf("%d是2的整数次幂", num);
	}
	else
	{
		printf("%d不是2的整数次幂", num);
	}
	return ((num > 0) && (num & (num - 1)) == 0);
}

int main()
{
	printf("请输入要查询的数\n");
	scanf_s("%d", &num); //禁止显示状态 警告 C6031 返回值被忽略: "scanf"

	/*原因：在ANSI C中没有scanf_s(),只有scanf()，但是scanf()在读取时不检查边界，所以可能会造成内存泄露。
	于是Microsoft公司在VS中提供了scanf_s()，如果想继续使用scanf这个不安全的函数以下方法可以解决

	方法一：直接把 scanf() 改为 scanf_s() 即可
	方法二：在文件顶部添加代码：#pragma warning(disable:4996) ，可以正常运行，但VS仍然会提示 C6031 错误
	方法三：错误提示的原因在于VS中的SDL检查；关闭步骤：右键单击工程文件 > 属性 > c / c++ > 所有选项 > SDL检查选项改为 否 */

	func(num);
}
```

### 001 三角形（菱形）四种表示
```C
#include<stdio.h>

int main() {
	int a, b, c, num;

	printf("请输入（上三角形）打印行数：\n");
	scanf_s("%d", &num);

	for (a = 0; a < num; a++) {
		for (b = a; b < num ; b++) {
			printf(" "); //递减
		}
		for (c = 0 ; c < 2 * a + 1; c++) {
			printf("*");
		}
		printf("\n");
	}

	//printf("\n"); //第一种菱形方法，上半部分

	for (a = 0; a < num-1; a++) {
		printf(" "); //下半部分

		for (b = 0; b < a+1; b++) {
			printf(" "); //递增
		}
		for (c = 2 * a; c < 2 * (num - 1) - 1; c++) {
			printf("*");
		}
		printf("\n");
	}

	printf("\n"); //分割行

	for (a = 0; a < num; a++) {
		for (b = num; b > a; b--) {
			printf(" "); //递减
		}
		for (c = 2 * a + 1; c > 0 ; c--) {
			printf("*");
		}
		printf("\n");
	}

	printf("\n"); //第一种菱形方法变种，上半部分

	for (a = 0; a < num-1; a++) {
		//printf(" "); //下半部分

		for (b = a + 1; b > 0; b--) {
			printf(" "); //递增
		}
		for (c = 2 * (num - 1) - 1; c > 2 * a; c--) {
			printf("*");
		}
		printf("\n");
	}

	printf("\n"); //分割行

/*1.对于上半部分(包括中间一行)，当前行与当前列满足如下关系输出星号：
		j >= (column + 1) / 2 - (i - 1)     (column + 1) / 2 - (i - 1)为第 i 行最左边的星号
		j <= (column + 1) / 2 + (i - 1)    (column + 1) / 2 + (i - 1)为第 i 行最右边的星号

2.对于下半部分，当前行与当前列满足如下关系输出星号：
		j >= (column + 1) / 2 - (line - i)     (column + 1) / 2 - (line - i)为第 i 行最左边的星号
		j <= (column + 1) / 2 + (line - i)    (column + 1) / 2 + (line - i)为第 i 行最右边的星号

3.不满足上述条件，则输出空格。*/

	int line; //总行数
	int column; //总列数
	int i; //当前行
	int j; //当前列

	printf("请输入菱形打印行数：\n");
	scanf_s("%d", &line);

	while (line % 2 == 0) {
		printf("请输入奇数！\a\n");
		scanf_s("%d", &line);
	}
	column = line; //总行数与总列数相等

	for (i = 1; i <= column; i++) { //遍历所有行
		if (i <= (line + 1) / 2) { //上半部分（包括中间一行）
			for (j = 1; j <= column; j++) { //遍历（上半部分）所有列
				if ((column + 1) / 2 - (i - 1) <= j && j <= (column + 1) / 2 + (i - 1)) {
					printf("*");
				}
				else {
					printf(" ");
				}
			}
		}
		else { //下半部分
			for (j = 1; j <= column; j++) { //遍历（下半部分）所有列
				if ((column + 1) / 2 - (line - i) <= j && j <= (column + 1) / 2 + (line - i)) {
					printf("*");
				}
				else {
					printf(" ");
				}
			}
		}
		printf("\n");
	}
	return 0;
}
```

### 002 求算术平方根
```C
#include<stdio.h>
#include<stdlib.h>

//正数 x 的平方根可以通过计算一系列近似值来获得，每个近似值都比前一个更加接近准确值。第一个近似值是1，接下来的近似值则通过下面的公式来获得。
//A（i+1）=（Ai + x/Ai）/2

double DoSqrt(double z) {
    double a = 1;
    double b = 0;
    double c = 0;

    do {
        if (b * b < z) {
            b += a;
        }
        else {
            c = b;
            b -= a;
            a /= 10;
        }
    } while (a > 0.000001);

    return (b + c) / 2;
}

int main() {
    double x, y;

    printf("请输入一个数字:");
    scanf_s("%lf", &x);

    if (x < 0) {
        printf("输入错误。");
    }
    else {
        y = DoSqrt(x);
        printf("%g 的平方根为: %g\n", x, y);
    }

    int z = 1;

    do {
        main();
        z++;
    } while (z > 10);

    printf("\n");

    return 0;
}
```

### 003 九九乘法表（六种）
```C
#include<stdio.h>

int main() {
	int i, j, result,n;
	
	//左下
	for (i = 1; i < 10; i++) {
		for (j = 1; j <= i; j++) {
			result = i * j;
			printf("%d*%d=%-3d", j, i, result); //-3d表示左对齐，占3位
		}
		printf("\n");
	}

	printf("\n");

	//左上（与上个三角形垂直对称）
	for (i = 9; i > 0; i--) {
		for (j = 1; j <= i; j++) {
			printf("%d*%d=%-3d", j, i, result = i * j); //简化
		}
		printf("\n");
	}

	printf("\n");

	//左上（数字顺序改变）
	for (i = 1; i < 10; i++) {
		/*for (n = 1; n < i; n++) { 加上同下面的右上，循坏条件为最后一种
			printf("        ");
		}*/
		for (j = i; j < 10; j++) {
			printf("%d*%d=%2d\t", i, j, i * j); //转义序列 \t 制表符，占2位
		}
		printf("\n");
	}

	printf("\n");

	//右上
	for (i = 1; i < 10; i++) {
		for (j = 1; j < 10; j++) {
			if (j < i) {
				printf("        "); //去掉八个空格，则是上一种左上（数字顺序改变）
			}
			else {
				printf("%d*%d=%2d\t", i, j, i * j);
			}
		}
		printf("\n");
	}

	printf("\n");

	//右下
	for (i = 1; i < 10; i++) {
		for (n = 1; n < 10 - i; n++) {
			printf("        "); //去掉此 for 循环(或者去掉八个空格)，则为第一种左下三角形
		}
		for (j = 1; j <= i; j++) {
			printf("%d*%d=%2d\t", j, i, i * j);
		}
		printf("\n");
	}

	printf("\n");

	//9x9格式
	for (i = 1; i < 10; i++) {
		for (j = 1; j < 10; j++) {
			printf("%d*%d=%2d\t", i, j, i * j);
		}
		printf("\n");
	}

	return 0;
}
```

### 004 日期计算器
```C
#include<stdio.h>
#include<stdlib.h>

/*普通年（不能被100整除的年份）能被4整除的为闰年。（如2004年就是闰年, 1999年不是闰年）；
世纪年（能被100整除的年份）能被400整除的是闰年。(如2000年是闰年，1900年不是闰年)；*/

int main() {
	int date = 0, year, month, day;

	printf("请依次输入年月日，格式为1900/09/09:");

	scanf_s("%d%d%d", &year, &month, &day);

	if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
		printf("%d年是闰年\n", year);
	}
	else {
		printf("%d年是平年\n", year);
	}

	switch(month) {
		case 12:date += 30;
		case 11:date += 31;
		case 10:date += 30;
		case 9:date += 31;
		case 8:date += 31;
		case 7:date += 30;
		case 6:date += 31;
		case 5:date += 30;
		case 4:date += 31;
		case 3:
			if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
				date += 29;
			}
			else {
				date += 28;
			}
		case 2:date += 31;
		case 1:date += day;

		printf("%d年%d月%d日是该年第%d天\n", year, month, day, date);
		break;

		default:printf("error!\n\a");
		break;
	}

	switch (month) {
		case 1:case 3:case 5:case 7:case 8:case 10:case 12:date = 31; break;
		case 4:case 6:case 9:case 11:date = 30; break;
		case 2: 
			if (year % 4 == 0 && year % 100 != 0 || year % 400 == 0) {
				date = 29;
			}
			else {
				date = 28;
			}break;

		default:printf("月份输入有误!"); 
			exit(1);
			break;
	}
	printf("%d年%d月有%d天\n", year, month, date);

	system("pause");

	return 0;
}
```

### 005 求100以内的素数
```C
#include <stdio.h>
#include <math.h>
	
int main(){
	int i;  //判断素数
	int j;  //循环次数
	int m;  //所求范围数
	int b = 0;  //合数个数

	printf("请输入判断数：");
	scanf_s("%d", &i);

	//思路一：判断一个整数 i 是否是素数，只需把 i 被 2 ~ i - 1 之间的每一个整数去除，如果都不能被整除，那么 i 就是一个素数。

	for (j = 2; j < i; j++) {
		if (i % j == 0) {
			b++;
		}
	}

	if (b == 0) {
		printf("%d是素数", i);
	}
	else {
		printf("%d不是素数", i);
	}

	printf("\n");

	/*思路二：判断方法还可以简化。i 不必被 2 ~ i - 1 之间的每一个整数去除，只需被 2 ~ √i 之间的每一个整数去除就可以了。
	如果 i 不能被 2 ~ √i 之间任一整数整除，i 必定是素数。*/
	
	/*原因：因为如果 i 能被 2 ~ i - 1 之间任一整数整除，其两个因子必定有一个小于或等于 √i，另一个大于或等于 √i。
	例如 16 能被 2、4、8 整除，16 = 2 * 8，2 小于 4，8 大于 4，16 = 4 * 4，4 = √16，因此只需判定在 2 ~ 4 之间有无因子即可。*/

	printf("请输入素数范围（不包括输入值）：");
	scanf_s("%d", &m);

	for (i = 2; i < m; i++) {
		for (j = 2; j <= (i / j); j++)
			if (!(i % j)) break;
		if (j > (i / j))
			printf("%d,", i);
	}

	printf("\n");

	for (i = 2; i < m; i++) {
		for (j = 2; j < sqrt(i); j++) {  //sqrt() 函数求平方根，其参数为 double 类型
			if (i % j == 0) {  // 如果完成所有循环，那么 i 为素数
				break;
			}
		}

		// 注意最后一次循环，会执行i++

		if (j > sqrt(i)) {
    		printf("%d,", i);
		}
	}

	return 0;
}
```

### 006 斐波那契数列
```C
#include <stdio.h>

//0 1 1 2 3 5 8……
int fibonaqi(int i) {
	if (i == 0) {
		return 0;
	}
	if (i == 1) {
		return 1;
	}
	return fibonaqi(i - 2) + fibonaqi(i - 1);
}
int main() {
	int i, n;
	printf("输出数量：");
	scanf_s("%d", &n);

	for (i = 0; i < n; i++) {
		printf("%d ", fibonaqi(i));
	}

	printf("\n--------------------------\n");
	
	//输出指定数量的斐波那契数列

	int t1 = 0, t2 = 1, temp, n2;
	printf("输出数量：");
	scanf_s("%d", &n2);

	for (i = 0; i < n2; i++) {
		printf("%d ", t1);
		temp = t1 + t2;
		t1 = t2;
		t2 = temp;
	}

	printf("\n--------------------------\n");

	//输出指定数字前的斐波那契数列

	int s1 = 0, s2 = 1, temp2 = 1, n3;
	printf("输入大于 1 的正数：");
	scanf_s("%d", &n3);
	printf("%d %d ", s1, s2);

	while (temp2 < n3) {
		printf("%d ", temp2);
		s1 = s2;
		s2 = temp2;
		temp2 = s1 + s2;
	}

	printf("\n");
	return 0;
}
```

### 007 五种求数
```C
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

//递归求最大公约数
int hcf(int a, int b) {
	if (b != 0)
		return hcf(b, a % b);
	else
		return a;
}

int main() {
	int i, j, n, s;
	printf("enter 完数范围：");
	scanf_s("%d", &n);

	for (i = 2; i < n; i++) {
		s = 0;
		for (j = 1; j < i; j++) {
			if (!(i % j)) {
				s+=j;
			}
		}
		if (s == i) {
			printf("%d ", i);
		}
		
	}
	printf("\n------------------------------");
	system("pause");

	int a, b, c, count = 0;
	printf("100以内的勾股数\n");
	printf("  a  b  c  a  b  c\n");

	for (a = 1; a < 101; a++) {
		for (b = a+1; b < 101; b++) {
			c = (int)sqrt(a * a + b * b);
			if (c * c == a * a + b * b && a + b > c && a + c > b && b + c > a && c < 101) {
				printf("%3d%3d%3d", a, b, c);
				count++;
				if (count % 2 == 0) {
					printf("\n");
				}
			}
		}
	}
	printf("\n------------------------------");
	system("pause");

	int q, w, temp, e;
	printf("两个正整数的最大公约数（GCD）：");
	scanf_s("%d%d", &q, &w);

	if (q > w) {
		temp = q;
		q = w;
		w = temp;
	}

	for (e = q; e > 0; e--) {
		if (q % e == 0 && w % e == 0) {
			printf("%d", e); break;
		}
	}
	printf("\n------------------------------");
	system("pause");

	int a1, b1;
	scanf_s("%d%d", &a1, &b1);
	printf("两个正整数的最大公约数（GCD）：%d", hcf(a1, b1)); //辗转相除法

	printf("\n------------------------------");
	system("pause");

	int a3, b3;
	scanf_s("%d%d", &a3, &b3);
	a3 = (a3 > 0) ? a3 : -a3; // 如果输入的是负数，将其转换为正数
	b3 = (b3 > 0) ? b3 : -b3;

	while (a3 != b3) {
		if (a3 > b3) {
			a3 -= b3;
		}
		else {
			b3 -= a3;
		}
	}
	printf("两个正整数的最大公约数（GCD）：%d", a3);

	printf("\n------------------------------");
	system("pause");

	int q1, w1, temp1, e1, s1;
	printf("两个正整数的最小公倍数（LCM）：");
	scanf_s("%d%d", &q1, &w1);

	if (q1 < w1) {
		temp1 = w1;
		w1 = q1;
		q1 = temp1;
	}

	for (s1 = 1;; s1++) {
		e1 = q1;
		e1 *= s1;
		if (e1 % q1 == 0 && e1 % w1 == 0) {
			printf("%d", e1); break;
		}
	}

	printf("\n------------------------------");
	system("pause");

	int h, t, o, num;
	printf("water flower：");

	for (num = 1; num < 1000; num++) {
		h = num / 100;
		t = num / 10 % 10;
		o = num % 10;

		if (num == h * h * h + t * t * t + o * o * o) {
			printf("%d ", num);
		}
	}

	return 0;
}
```

### 008 阶乘
```C
#include <stdio.h>

long double factorials(int n) {
	if (n > 0) {
		return n * factorials(n - 1);
	}
	else 
		return 1;
}

int main() {
	int i, n; //MAX n = 170
	long double factorial = 1;

	printf("enter n:");
	scanf_s("%d", &n);

	if (n < 0) {
		printf("error!\a\n");
	}
	else {
		for (i = 1; i <= n; i++) {
			factorial *= i;
		}
		printf("%d != %g\n", n, factorial);
		printf("%d != %e\n", n, factorial);
		printf("%d != %.lf\n", n, factorial);
	}

	printf("--------------------------------------\n");

	int n1;
	printf("enter n1:");
	scanf_s("%d", &n1);

	printf("%d != %g\n", n1, factorials(n1));
	printf("%d != %e\n", n1, factorials(n1));
	printf("%d != %.lf\n", n1, factorials(n1));
	

	return 0;
}
```

### 009 三角形图案
```C
#include <stdio.h>
#define N 10 

int main() {
	int i, j, k, n;
	printf("请输入数字金字塔基座宽度(正奇数):");
	scanf_s("%d", &n);

	for (i = 1; i < (n + 1) / 2; i++) {
		for (j = 1; j < (n + 1) / 2 - i; j++) {
			printf("  ");
		}
		for (k = i; k < 2 * i; k++) {
			printf("%d ", k);
		}
		for (k -= 2; k >= i; k--) { //这里 k=2*i
			printf("%d ", k);
		}
		printf("\n");
	}

	//杨辉三角
	int rows, coef = 1, space, i1, j1;

	printf("行数: ");
	scanf_s("%d", &rows);

	for (i1 = 0; i1 < rows; i1++)
	{
		for (space = 1; space <= rows - i1; space++)
			printf("  ");

		for (j1 = 0; j1 <= i1; j1++)
		{
			if (j1 == 0 || i1 == 0)
				coef = 1;
			else
				coef = coef * (i1 - j1 + 1) / j1;

			printf("%4d", coef);
		}
		printf("\n");
	}
	printf("\n");

	//弗洛伊德三角形
	int i2, j2, l;
	for (i2 = 1, j2 = 1; i2 <= N; i2++)
	{
		for (l = 1; l <= i2; l++, j2++)
			printf("%5d", j2);
		printf("\n");
	}

	return 0;
}
```

### 010 矩阵转换
```C
#include <stdio.h>

int main() {
	int a[10][10], transpose[10][10], r, c, i, j;
	printf("输入矩阵的行和列：\n");
	scanf_s("%d %d", &r, &c);

	printf("\n输入矩阵元素：\n");
	for (i = 0; i < r; i++) {
		for (j = 0; j < c; j++) {
			printf("输入元素 a%d%d：", i + 1, j + 1);
			scanf_s("%d", &a[i][j]);
		}
	}

	printf("\n输入矩阵：\n");
	for (i = 0; i < r; i++) {
		for (j = 0; j < c; j++) {
			printf("%d  ", a[i][j]);
			if (j == c - 1)
				printf("\n");
		}
	}

	for (i = 0; i < r; i++) {
		for (j = 0; j < c; j++) {
			transpose[j][i] = a[i][j];
		}
	}

	printf("\n转换后矩阵：\n");
	for (i = 0; i < c; i++) {
		for (j = 0; j < r; j++) {
			printf("%d  ", transpose[i][j]);
			if (j == r - 1)
				printf("\n");
		}
	}

	return 0;
}
```

### 011 表白爱心
```C
#include <stdio.h>
#include <windows.h>

int main() {
	float x, y, a;
	for (y = 1.5; y > -1.5; y -= 0.1) {
		for (x = -1.5; x < 1.5; x += 0.05) {
			a = x * x + y * y - 1;
			putchar(a * a * a - x * x * y * y * y <= 0.0 ? '*' : ' ');
		}

		system("color 0c");
		putchar('\n');
	}
	return 0;
}
```

### 012 逆序
```C++
#include <iostream>
#include <string>
#include <algorithm>

int main() {
	std::string str;
	std::cin >> str;
	reverse(str.begin(), str.end());
	std::cout << str << std::endl; return 0;
}
```

### 013 String to ASCII
```C
#include <stdio.h>
#include <string.h>

int main() {
	char s[10000];
	do {
		printf("Enter string:\n");
		scanf("%s", s);
		for (int i = 0; s[i]; i++)
			printf("%d ", s[i]);
		printf("\nLength:%d\n\n", strlen(s));
	} while (s);
}
```

### 014 Big-Dec to Hex
```C++
#include <iostream>
using namespace std;

int main() {
    while (1) {
        cout << "输入十进制数" << endl; ///****************1.输入
        string str;
        cin >> str;
        int len = str.size();

        for (int i = 0; i < len; i++) { ///****************2.异常处理
            if (str[i] < 48 || str[i] > 57) { // 0 的 ascll 码是 48，9 为 57
                cout << "输入了非法字符" << endl;
                return 0;
            }
        }

        string result = ""; ///****************3.正式处理
        string hex = "0123456789abcdef";
        int i = 0;
        char cnt2 = '0';

        while (1) {
            while (i < len && str[i] == '0')
                i++;

            if (i >= len)
                break;

            int cnt = 0;
            for (; i < len; i++) {
                int sum = cnt * 10 + (str[i] - '0');
                str[i] = char(sum / 16 + '0');  //因为sum不会超过159，sum/16不会超过10，不会超过8位二进制表示，
                cnt = sum % 16;                  //因此不会因为int转成char被截断而有误差。
                cnt2 = hex[sum % 16];
            }

            i = 0;
            result = cnt2 + result;
        }

        if (result == "") { //输入为0的时候，结果就是0
            cout << 0 << endl;
            return 0;
        }

        cout << result << endl;

    }
    return 0;
}
```

### 015 
```C

```

```C

```

```C

```

```C

```

```C

```

