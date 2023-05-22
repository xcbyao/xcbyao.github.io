---
title: LeetCode Record
date: 2023-05-19 17:32:51
categories: Programming
---
# Pref

LeetCode 刷题记录。 Medium Hard

# Convert the Temperature - Easy

Kelvin = Celsius + 273.15
Fahrenheit = Celsius * 1.80 + 32.00

```python
class Solution:
    def convertTemperature(self, celsius: float) -> List[float]:
        return [celsius + 273.15, celsius * 1.80 + 32.00]
```

# Smallest Even Multiple - Easy

最小偶倍数：

Given a positive integer n, return the smallest positive integer that is a multiple of both 2 and n.

```python
class Solution:
    def smallestEvenMultiple(self, n: int) -> int:
        return n if n % 2 == 0 else n * 2
        # return n << (n & 1)
        '''
        位运算避免分支判断。常用 n & 1 判断奇数，二进制奇数最低位一定为 1，
        因此，若按位与结果为 1，则最后一位为 1，n 为奇数；若为 0，则为偶数。
        '''
        # return (n % 2) == 0 ? n : n * 2
```

# XOR Operation in an Array - Easy

给你两个整数，n 和 start。

定义 nums[i] = start + 2*i（下标从 0 开始）且 n == nums.length。

请返回 nums 中所有元素按位异或后得到的结果。

输入：n = 5, start = 0
输出：8
解释：数组 nums 为 [0, 2, 4, 6, 8]，其中 (0 ^ 2 ^ 4 ^ 6 ^ 8) = 8 。

```python
# 模拟
class Solution:
    def xorOperation(self, n: int, start: int) -> int:
        ans = 0
        for i in range(n):
            ans ^= (start + i * 2)
        return ans
```

[方法二：数学](https://leetcode.cn/problems/xor-operation-in-an-array/solution/shu-zu-yi-huo-cao-zuo-by-leetcode-solution)

# Number of Good Pairs - Easy

好数对的数目：

给你一个整数数组 nums。

如果一组数字 (i,j) 满足 nums[i] == nums[j] 且 i < j ，就可以认为这是一组好数对。

返回好数对的数目。

输入：nums = [1,2,3,1,1,3]
输出：4
解释：有 4 组好数对，分别是 (0,3), (0,4), (3,4), (2,5) ，下标从 0 开始

```python
# 暴力统计
class Solution:
    def numIdenticalPairs(self, nums: List[int]) -> int:
        ans = 0
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                if nums[i] == nums[j]:
                    ans += 1
        return ans
```

[方法二：组合计数](https://leetcode.cn/problems/number-of-good-pairs/solution/hao-shu-dui-de-shu-mu-by-leetcode-solution)

# Count Good Triplets - Easy

一个整数数组 arr，以及 a、b 、c 三个整数。

如果三元组 (arr[i], arr[j], arr[k]) 满足下列全部条件，则认为它是一个好三元组。

0 <= i < j < k < arr.length
|arr[i] - arr[j]| <= a
|arr[j] - arr[k]| <= b
|arr[i] - arr[k]| <= c
其中 |x| 表示 x 的绝对值。

返回好三元组的数量。

输入：arr = [3,0,1,1,9,7], a = 7, b = 2, c = 3
输出：4
解释：一共 4 个好三元组：[(3,0,1), (3,0,1), (3,1,1), (0,1,1)]

```python
# 枚举
class Solution:
    def countGoodTriplets(self, arr: List[int], a: int, b: int, c: int) -> int:
        n = len(arr)
        cnt = 0
        for i in range(n):
            for j in range(i + 1, n):
                for k in range(j + 1, n):
                    if abs(arr[i] - arr[j]) <= a and abs(arr[j] - arr[k]) <= b and abs(arr[i] - arr[k]) <= c:
                        cnt += 1
        return cnt

# 暴力法三重循环可以提前判断终止最内层的计算
class Solution:
    def countGoodTriplets(self, arr: List[int], a: int, b: int, c: int) -> int:
        size = len(arr)
        cnt = 0
        for i in range(size-2):
            for j in range(i+1,size-1):
                if abs(arr[i] - arr[j]) <= a:
                    for k in range(j+1, size):
                        if abs(arr[j] - arr[k]) <= b and abs(arr[i] - arr[k]) <= c:
                            cnt += 1
        return cnt
```

[方法二：枚举优化](https://leetcode.cn/problems/count-good-triplets/solution/tong-ji-hao-san-yuan-zu-by-leetcode-solution)

# Add Digits - Easy

各位相加：

给定一个非负整数 num，反复将各个位上的数字相加，直到结果为一位数。返回这个结果。

输入: num = 38
输出: 2
解释: 各位相加的过程为：
38 --> 3 + 8 --> 11
11 --> 1 + 1 --> 2

```python
# 模拟
class Solution:
    def addDigits(self, num: int) -> int:
        while num >= 10:
            sum = 0
            while num:
                sum += num % 10
                num //= 10
            num = sum
        return num

# 数学
class Solution:
    def addDigits(self, num: int) -> int:
        return (num - 1) % 9 + 1 if num else 0
```

[方法二：数学](https://leetcode.cn/problems/add-digits/solution/ge-wei-xiang-jia-by-leetcode-solution-u4kj)

# Subtract the Product and Sum of Digits of an Integer - Easy

整数的各位积和之差：

整数 n，计算并返回该整数「各位数字之积」与「各位数字之和」的差。

输入：n = 234
输出：15
解释：
各位数之积 = 2 * 3 * 4 = 24
各位数之和 = 2 + 3 + 4 = 9
结果 = 24 - 9 = 15

```python
# 模拟
class Solution:
    def subtractProductAndSum(self, n: int) -> int:
        add, mul = 0, 1
        while n > 0:
            add += n % 10
            mul *= n % 10
            n //= 10
        return mul - add

# 暴力
class Solution:
    def subtractProductAndSum(self, n: int) -> int:
        add, mul = 0, 1
        for num in str(n):
            num = int(num)
            add += num
            mul *= num
        return mul - add
```

#

# Database

## Find Customer Referee - Easy

寻找用户推荐人：

```none
Table: Customer
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
```

写一个查询语句，返回一个客户列表，列表中客户的推荐人的编号都不是 2。

```none
Output:
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
```

MySQL 使用三值逻辑 —— TRUE, FALSE 和 UNKNOWN。任何与 NULL 值进行的比较都会与第三种值 UNKNOWN 做比较。

```sql
SELECT name FROM customer WHERE referee_id <> 2 OR referee_id IS NULL;

-- MySQL
SELECT name FROM customer WHERE referee_id != 2 OR referee_id IS NULL;

-- 用安全等于取反
SELECT name FROM customer WHERE NOT referee_id <=> 2;
/*
因此，最后一句意思是选择所有 referee_id 不等于 2 的行，包括 NULL  行。
<=> 是 MySQL 特有的运算符，用于比较两个值是否相等，包括 NULL 值。使用方式：

如果两个值都不是 NULL，"<=>" 的作用与 "=" 相同，即比较两个值是否相等。
如果其中一个值为 NULL，那么 "<=>" 的结果为 FALSE（不相等），而"=" 的结果为 UNKNOWN（未知）。
如果两个值都为 NULL，那么 "<=>" 的结果为 TRUE（相等），而"=" 的结果为 UNKNOWN（未知）。
*/
```

# Recyclable and Low Fat Products

可回收且低脂的产品：

```none
Table: Products
+-------------+----------+------------+
| product_id  | low_fats | recyclable |
+-------------+----------+------------+
| 0           | Y        | N          |
| 1           | Y        | Y          |
| 2           | N        | Y          |
| 3           | Y        | Y          |
| 4           | N        | N          |
+-------------+----------+------------+

product_id 是这个表的主键。
low_fats 是枚举类型，取值为以下两种 ('Y', 'N')，其中 'Y' 表示该产品是低脂产品，'N' 则不是。
recyclable 同上。
```

查找既是低脂又是可回收的产品编号。返回结果无顺序要求。

```none
Output:
+-------------+
| product_id  |
+-------------+
| 1           |
| 3           |
+-------------+
```

```sql
-- MySQL
SELECT product_id FROM products WHERE low_fats = 'Y' AND recyclable = 'Y';
```

#




# Refer

[「新」动计划 · 编程入门](https://leetcode.cn/studyplan/primers-list)
[算法通关手册](https://algo.itcharge.cn)
[代码随想录](https://www.programmercarl.com)
[1.初级算法](https://leetcode.cn/leetbook/detail/top-interview-questions-easy/)
[2.数组类算法](https://leetcode.cn/leetbook/detail/all-about-array/)
[3.数组和字符串](https://leetcode.cn/leetbook/detail/array-and-string/)
[4.链表图文学](https://leetcode.cn/leetbook/detail/linked-list/)
[5.队列 & 栈图文学](https://leetcode.cn/leetbook/detail/queue-stack/)
[6.二分查找](https://leetcode.cn/leetbook/detail/binary-search/)
[7.二叉树](https://leetcode.cn/leetbook/detail/data-structure-binary-tree/)
[8.二叉搜索树](https://leetcode.cn/leetbook/detail/introduction-to-data-structure-binary-search-tree/)
[9.N 叉树](https://leetcode.cn/leetbook/detail/n-ary-tree/)
[10.前缀树](https://leetcode.cn/leetbook/detail/trie/)
[11.中级算法](https://leetcode.cn/leetbook/detail/top-interview-questions-medium/)
[12.高级算法](https://leetcode.cn/leetbook/detail/top-interview-questions-hard/)
[13.动态规划路径问题](https://leetcode.cn/leetbook/detail/path-problems-in-dynamic-programming/)
[14.算法面试题汇总](https://leetcode.cn/leetbook/detail/top-interview-questions/)
[2020 名企高频面试题](https://leetcode.cn/leetbook/detail/2020-top-interview-questions/)
[图解算法数据结构](https://leetcode.cn/leetbook/detail/illustration-of-algorithm/)
[设计数据结构](https://leetcode.cn/leetbook/detail/designing-data-structures/)
[数据结构教程(第 6 版) - 在线编程实训](https://leetcode.cn/leetbook/detail/shu-ju-jie-gou-jiao-cheng-di-6-ban-zai-xian-bian-c/)
[CodeTop 企业题库](https://codetop.cc)

# PS

期待有一天 LeetCode 基本刷遍……