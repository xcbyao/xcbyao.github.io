---
title: LeetCode Record
date: 2023-05-19 17:32:51
categories: Programming
---
# Pref

LeetCode 刷题记录。 Hard

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

# Power of Two - Easy

给你一个整数 n，请你判断该整数是否是 2 的幂次方。如果是，返回 true；否则返回 false。

输入：n = 1
输出：true
解释：2^0 = 1

```python
# 判断是否为最大 2 的幂的约数
class Solution:
    BIG = 2**30

    def isPowerOfTwo(self, n: int) -> bool:
        return n > 0 and Solution.BIG % n == 0
```

[方法一：二进制表示](https://leetcode.cn/problems/power-of-two/solution/2de-mi-by-leetcode-solution-rny3)

# Power of Three - Easy

```python
# 试除法
class Solution:
    def isPowerOfThree(self, n: int) -> bool:
        while n and n % 3 == 0:
            n //= 3
        return n == 1

# 判断是否为最大 3 的幂的约数
# 这里限定范围最大 3 的幂为 3^19 = 1162261467
class Solution:
    def isPowerOfThree(self, n: int) -> bool:
        return n > 0 and 1162261467 % n == 0
```

# Ugly Number - Easy

丑数：只包含质因数 2、3 和 5 的正整数。

1 没有质因数，因此它的全部质因数是 {2, 3, 5} 的空集。习惯上将其视作第一个丑数。

给你一个整数 n，请你判断 n 是否为丑数。如果是，返回 true；否则返回 false。

输入：n = 6
输出：true
解释：6 = 2 × 3

```python
# 数学
class Solution:
    def isUgly(self, n: int) -> bool:
        if n <= 0:
            return False

        factors = [2, 3, 5]
        for factor in factors:
            while n % factor == 0:
                n //= factor

        return n == 1
```

# Shuffle the Array - Easy

重新排序数组：

给你一个数组 nums，数组中有 2n 个元素，按 [x1,x2,...,xn,y1,y2,...,yn] 的格式排列。

请你将数组按 [x1,y1,x2,y2,...,xn,yn] 格式重新排列返回。

```python
# 一次遍历
class Solution:
    def shuffle(self, nums: List[int], n: int) -> List[int]:
        ans = [0] * (2 * n)
        for i in range(n):
            ans[2 * i] = nums[i]
            ans[2 * i + 1] = nums[n + i]
        return ans

# 切片赋值
class Solution:
    def shuffle(self, nums: List[int], n: int) -> List[int]:
        nums[::2], nums[1::2] = nums[:n], nums[n:]
        return nums

# 模拟
class Solution:
    def shuffle(self, nums: List[int], n: int) -> List[int]:
        ans = []
        for i in range(n):
            ans.append(nums[i])
            ans.append(nums[n + i])
        return ans
```

# Transpose Matrix - Easy

二维整数数组 matrix，返回 matrix 的转置矩阵。

输入：`matrix = [[1,2,3],[4,5,6],[7,8,9]]`
输出：`[[1,4,7],[2,5,8],[3,6,9]]`

```python
# 模拟
class Solution:
    def transpose(self, matrix: List[List[int]]) -> List[List[int]]:
        m, n = len(matrix), len(matrix[0])
        transposed = [[0] * m for _ in range(n)]
        for i in range(m):
            for j in range(n):
                transposed[j][i] = matrix[i][j]
        return transposed

# 模拟 python3_oneline
class Solution:
    def transpose(self, matrix: List[List[int]]) -> List[List[int]]:
        return list(list(row) for row in zip(*matrix))
        # return [list(row) for row in zip(*matrix)] # 强制转换返回列表值

# 迭代器
class Solution:
    def transpose(self, matrix: List[List[int]]):
        return zip(*matrix)

# numpy 库
class Solution:
    def transpose(self, matrix: List[List[int]]) -> List[List[int]]:
        import numpy as np
        return np.array(matrix).T.tolist()
```

# Maximum Score After Splitting a String - Easy

分割字符串的最大得分：

由若干 0 和 1 组成的字符串 s，计算并返回将该字符串分割成两个非空子字符串（即左和右子字符串）所能获得的最大得分。

「分割字符串的得分」为左子字符串中 0 的数量加上右子字符串中 1 的数量。

输入：s = "011101"
输出：5
解释：
将字符串 s 划分为两个非空子字符串的可行方案有：
左子字符串 = "0" 且 右子字符串 = "11101"，得分 = 1 + 4 = 5
左子字符串 = "01" 且 右子字符串 = "1101"，得分 = 1 + 3 = 4
左子字符串 = "011" 且 右子字符串 = "101"，得分 = 1 + 2 = 3
左子字符串 = "0111" 且 右子字符串 = "01"，得分 = 1 + 1 = 2
左子字符串 = "01110" 且 右子字符串 = "1"，得分 = 2 + 1 = 3

```python
# 枚举每个分割点
class Solution:
    def maxScore(self, s: str) -> int:
        return max(s[:i].count('0') + s[i:].count('1') for i in range(1, len(s)))

# 两次遍历
class Solution:
    def maxScore(self, s: str) -> int:
        ans = score = (s[0] == '0') + s[1:].count('1')
        for c in s[1:-1]:
            score += 1 if c == '0' else -1
            ans = max(ans, score)
        return ans
```

# Count the Number of Vowel Strings in Range - Easy

统计范围内的元音字符串数：

给你一个下标从 0 开始的字符串数组 words 和两个整数：left 和 right。

如果字符串以元音字母开头并以元音字母结尾，那么该字符串就是一个元音字符串，其中元音字母是 'a'、'e'、'i'、'o'、'u'。

返回 words[i] 是元音字符串的数目，其中 i 在闭区间 [left, right] 内。

输入：words = ["are","amy","u"], left = 0, right = 2
输出：2
解释：
- "are" 是一个元音字符串，因为它以 'a' 开头并以 'e' 结尾。
- "amy" 不是元音字符串，因为它没有以元音字母结尾。
- "u" 是一个元音字符串，因为它以 'u' 开头并以 'u' 结尾。
在上述范围中的元音字符串数目为 2 。

```python
class Solution:
    def vowelStrings(self, words: List[str], left: int, right: int) -> int:
        return sum(s[0] in "aeiou" and s[-1] in "aeiou" for s in words[left:right+1])
```

# Peak Index in a Mountain Array - Medium

山脉数组的峰顶索引：

符合下列属性的数组 arr 称为 山脉数组：
arr.length >= 3
存在 i（0 < i < arr.length - 1）使得：
arr[0] < arr[1] < ... arr[i-1] < arr[i]
arr[i] > arr[i+1] > ... > arr[arr.length - 1]

给你由整数组成的山脉数组 arr，返回满足 arr[0] < arr[1] < ... arr[i - 1] < arr[i] > arr[i + 1] > ... > arr[arr.length - 1] 的下标 i。

设计并实现时间复杂度为 O(logn) 的解决方案。

输入：arr = [0,2,1,0]
输出：1

```python
# 枚举，时间复杂度 O(n)
class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        ans = -1

        for i in range(1, len(arr)-1):
            if arr[i] > arr[i+1]:
                ans = i
                break
        return ans

# 二分查找
class Solution:
    def peakIndexInMountainArray(self, arr: List[int]) -> int:
        left, right, ans = 1, len(arr) - 2, 0

        while left <= right:
            mid = (left + right) // 2
            if arr[mid] > arr[mid + 1]:
                ans = mid
                right = mid - 1
            else:
                left = mid + 1
        return ans
```






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

## Recyclable and Low Fat Products - Easy

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
SELECT product_id FROM products WHERE low_fats = 'Y' AND recyclable = 'Y'
;
```

## Big Countries - Easy

```none
Table: World
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key column
```

面积至少为 300 万平方公里，或人口至少为 2500 万。
编写一个 SQL 查询以报告大国的国家名称、人口和面积。

按任意顺序返回结果表。

```none
Input:
World table:
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
Output:
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+
```

```sql
-- MySQL
-- 使用 OR
SELECT name, population, area
FROM world
WHERE population >= 25000000 OR area >= 3000000
;

-- 使用 or 可能会使索引失效，在数据量较大的时候查找效率较低，通常建议使用 union。
-- 使用 UNION，比上一种速度更块，但差别不大
SELECT name, population, area
FROM world
WHERE population >= 25000000

UNION

SELECT name, population, area
FROM world
WHERE area >= 3000000
;
```

## Article Views I - Easy

文章浏览 I：

```none
Table: Views
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
此表无主键，因此可能会存在重复行。
此表的每一行都表示某人在某天浏览了某位作者的某篇文章。
同一人的 author_id 和 viewer_id 是相同的。
```

找出所有浏览过自己文章的作者，结果按照 id 升序排列。

```none
Input:
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output:
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
```

```sql
-- MySQL
SELECT DISTINCT author_id AS id
FROM  Views
WHERE author_id = viewer_id
ORDER BY author_id
;
```

## Invalid Tweets - Easy

```none
Table: Tweets
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| tweet_id       | int     |
| content        | varchar |
+----------------+---------+
tweet_id is the primary key.
```

查询所有无效推文的编号（ID）。当推文内容中的字符数严格大于 15 时，该推文是无效的。

以任意顺序返回结果表。

```none
Input:
Tweets table:
+----------+----------------------------------+
| tweet_id | content                          |
+----------+----------------------------------+
| 1        | Vote for Biden                   |
| 2        | Let us make America great again! |
+----------+----------------------------------+
Output:
+----------+
| tweet_id |
+----------+
| 2        |
+----------+
Explanation:
Tweet 1 has length = 14. It is a valid tweet.
Tweet 2 has length = 32. It is an invalid tweet.
```

```sql
-- MySQL
SELECT tweet_id
FROM tweets
WHERE CHAR_LENGTH(content) > 15
;
```

## Replace Employee ID With The Unique Identifier - Easy

使用唯一标识码替换员工 ID：

```none
Table: Employees
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+
id is the primary key.

Table: EmployeeUNI
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+
```

展示每位用户的唯一标识码（unique ID ）；如果某位员工没有唯一标识码，使用 null 填充即可。

你可以以任意顺序返回结果表。

```none
Input:
Employees table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |
+----+----------+
EmployeeUNI table:
+----+-----------+
| id | unique_id |
+----+-----------+
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |
+----+-----------+
Output:
+-----------+----------+
| unique_id | name     |
+-----------+----------+
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
+-----------+----------+
```

```sql
-- MySQL
SELECT unique_id, name
FROM employees
LEFT JOIN employeeUNI
ON employees.id = employeeUNI.id
;
```

## Product Sales Analysis I - Easy

产品销售分析 I:

```none
Table: Sales
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key of this table.
product_id is a foreign key to Product table.

Table: Product
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key of this table.
```

获取 Sales 表中所有产品对应的产品名称 product_name 以及该产品的所有售卖年份 year 和价格 price。

查询结果中的顺序无特定要求。

```none
Input:
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output:
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+
```

```sql
-- MySQL
SELECT p.product_name, s.year, s.price
FROM sales s
LEFT JOIN product p
ON s.product_id = p.product_id
;
```

## Customer Who Visited but Did Not Make Any Transactions - Easy

进店却未进行过交易的顾客：

```none
Table: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the primary key for this table.

Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is the primary key for this table.
```

有一些顾客可能光顾了购物中心但没有进行交易。请你编写一个 SQL 查询，来查找这些顾客的 ID，以及他们只光顾不交易的次数。

返回以 任何顺序 排序的结果表。

```none
Input:
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output:
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
解释:
ID = 23 的顾客曾经逛过一次购物中心，并在 ID = 12 的访问期间进行了一笔交易。
ID = 9 的顾客曾经逛过一次购物中心，并在 ID = 13 的访问期间进行了一笔交易。
ID = 30 的顾客曾经去过购物中心，并且没有进行任何交易。
ID = 54 的顾客三度造访了购物中心。在 2 次访问中，他们没有进行任何交易，在 1 次访问中，他们进行了 3 次交易。
ID = 96 的顾客曾经去过购物中心，并且没有进行任何交易。
如我们所见，ID 为 30 和 96 的顾客一次没有进行任何交易就去了购物中心。顾客 54 也两次访问了购物中心并且没有进行任何交易。
```

```sql
-- MySQL
SELECT customer_id, count(customer_id) count_no_trans
FROM visits v
LEFT JOIN transactions t
ON v.visit_id = t.visit_id
WHERE amount IS NULL
GROUP BY customer_id
;
```

## Rising Temperature - Easy

```none
Table: Weather
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the primary key for this table.
```

查找与之前（昨天的）日期相比温度更高的所有日期的 id。

返回结果不排序。

```none
Input:
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output:
+----+
| id |
+----+
| 2  |
| 4  |
+----+
解释：
2015-01-02 的温度比前一天高（10 -> 25）
2015-01-04 的温度比前一天高（20 -> 30）
```

```sql
-- MySQL
SELECT a.id
FROM weather a
CROSS JOIN weather b
ON datediff(a.recorddate, b.recorddate) = 1
WHERE a.temperature > b.temperature

SELECT a.id
FROM weather a
CROSS JOIN weather b
ON timestampdiff(day, a.recorddate, b.recorddate) = -1
WHERE a.temperature > b.temperature
;
```

## Average Time of Process per Machine - Easy

每台机器的进程平均运行时间：

```none
Table: Activity
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
(machine_id, process_id, activity_type) 是当前表的主键。
```

现在有一个工厂网站由几台机器运行，每台机器上运行着相同数量的进程。计算每台机器各自完成一个进程任务的平均耗时。

完成一个进程任务的时间指进程的 'end' 时间戳减去 'start' 时间戳。平均耗时通过计算每台机器上所有进程任务的总耗费时间除以机器上的总进程数量获得。

结果表必须包含 machine_id（机器ID）和对应的 average time（平均耗时） 别名 processing_time，且四舍五入保留 3 位小数。

以 任意顺序 返回表。

```none
Input:
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+
Output:
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+
解释：
一共有3台机器,每台机器运行着两个进程.
机器 0 的平均耗时: ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
```

```sql
-- MySQL
SELECT
    machine_id,
    ROUND(AVG(IF(activity_type = 'start', -timestamp, timestamp)) * 2, 3) processing_time
FROM activity
GROUP BY machine_id
```

## Employee Bonus - Easy

选出所有 bonus < 1000 员工的 name 及其 bonus。

```none
Input:
Employee table:
+-------+--------+------------+--------+
| empId | name   | supervisor | salary |
+-------+--------+------------+--------+
| 3     | Brad   | null       | 4000   |
| 1     | John   | 3          | 1000   |
| 2     | Dan    | 3          | 2000   |
| 4     | Thomas | 3          | 4000   |
+-------+--------+------------+--------+
Bonus table:
+-------+-------+
| empId | bonus |
+-------+-------+
| 2     | 500   |
| 4     | 2000  |
+-------+-------+
Output:
+------+-------+
| name | bonus |
+------+-------+
| Brad | null  |
| John | null  |
| Dan  | 500   |
+------+-------+
```

```sql
-- MySQL
SELECT name, bonus
FROM employee
LEFT JOIN bonus
ON employee.empId = bonus.empId
WHERE bonus IS NULL OR bonus < 1000
;
```

## Students and Examinations - Easy

```none
Table: Students
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key.

Table: Subjects
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key.

Table: Examinations
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
无主键，可能会有重复行。
```

查询出每个学生参加每一门科目测试的次数，结果按 student_id 和 subject_name 排序。

```none
Input:
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+
Output:
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
```

```sql
-- MySQL
SELECT a.student_id, a.student_name, b.subject_name, COUNT(e.subject_name) AS attended_exams
FROM Students a
CROSS JOIN Subjects b
LEFT JOIN Examinations e
ON a.student_id = e.student_id
AND b.subject_name = e.subject_name
GROUP BY a.student_id, b.subject_name
ORDER BY a.student_id, b.subject_name
```

## Managers with at Least 5 Direct Reports - Medium

至少有 5 名直接下属的经理：

```none
Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key column.
```

查询至少有 5 名直接下属的经理。

以 任意顺序 返回结果表。

```none
Input:
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | None      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output:
+------+
| name |
+------+
| John |
+------+
```

```sql
-- MySQL
SELECT name
FROM employee AS t1 JOIN(
    SELECT managerID
    FROM employee
    GROUP BY managerID
    HAVING COUNT(managerID) >= 5) AS t2
    ON t1.id = t2.managerID
;
```

## Confirmation Rate - Medium

确认率：

```none
Table: Signups
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the primary key.

Table: Confirmations
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key.
user_id is a foreign key.
```

用户的确认率是 'confirmed' 消息的数量除以请求的确认消息的总数。没有请求任何确认消息的用户的确认率为 0 。确认率四舍五入到小数点后两位。

查找每个用户的确认率。

以任意顺序返回结果表。

```none
Input:
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+
Output:
+---------+-------------------+
| user_id | confirmation_rate |
+---------+-------------------+
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |
+---------+-------------------+
解释:
用户 6 没有请求任何确认消息。确认率为 0。
用户 3 进行了 2 次请求，都超时了。确认率为 0。
用户 7 提出了 3 个请求，所有请求都得到了确认。确认率为 1。
用户 2 做了 2 个请求，其中一个被确认，另一个超时。确认率为 1 / 2 = 0.5。
```

```sql
-- MySQL
SELECT s.user_id, IFNULL(ROUND(SUM(action = 'confirmed') / COUNT(c.action), 2), 0.00) AS confirmation_rate
FROM signups AS s
LEFT JOIN confirmations AS c
ON s.user_id = c.user_id
GROUP BY s.user_id
;
```

## Not Boring Movies - Easy

```none
Input:
Cinema table:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
Output:
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
```

找出所有影片描述为非 boring 的且 id 为奇数的影片，结果请按等级 rating 排列。

```sql
-- MySQL
SELECT *
FROM cinema
WHERE MOD(id, 2) = 1
    AND description != 'boring'
ORDER BY rating DESC
;

-- SQL
SELECT *
FROM cinema
WHERE id % 2 <> 0
    AND description <> 'boring'
ORDER BY rating DESC
;
```

## Average Selling Price - Easy

平均售价：

```none
Table: Prices
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key.

Table: UnitsSold
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
```

查找每种产品的平均售价。average_price 应该四舍五入到小数点后两位。

```none
Input:
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output:
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+

平均售价 = 产品总价 / 销售的产品数量。
产品 1 的平均售价 = ((100 * 5)+(15 * 20) )/ 115 = 6.96
产品 2 的平均售价 = ((200 * 15)+(30 * 30) )/ 230 = 16.96
```

```sql
-- MySQL
SELECT
    product_id,
    Round(SUM(sales) / SUM(units), 2) AS average_price
FROM (
    SELECT
        Prices.product_id AS product_id,
        Prices.price * UnitsSold.units AS sales,
        UnitsSold.units AS units
    FROM Prices
    JOIN UnitsSold ON Prices.product_id = UnitsSold.product_id
    WHERE UnitsSold.purchase_date BETWEEN Prices.start_date AND Prices.end_date
) T
GROUP BY product_id
```

## Project Employees I - Easy

```none
Table: Project
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| project_id  | int     |
| employee_id | int     |
+-------------+---------+
(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.

Table: Employee
+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |
+------------------+---------+
employee_id is the primary key.
```

查询每一个项目中员工的 平均 工作年限，精确到小数点后两位。

```none
Input:
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+
Output:
+-------------+---------------+
| project_id  | average_years |
+-------------+---------------+
| 1           | 2.00          |
| 2           | 2.50          |
+-------------+---------------+
第一个项目中，员工的平均工作年限是 (3 + 2 + 1) / 3 = 2.00；第二个项目中，员工的平均工作年限是 (3 + 2) / 2 = 2.50
```

```sql
-- MySQL
SELECT
    p.project_id,
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM project p, employee e
WHERE p.employee_id = e.employee_id
GROUP BY p.project_id
;
```

## Percentage of Users Attended a Contest - Easy

各赛事的用户注册率：

```none
Table: Users

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| user_id     | int     |
| user_name   | varchar |
+-------------+---------+
user_id is the primary key.

Table: Register

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| contest_id  | int     |
| user_id     | int     |
+-------------+---------+
(contest_id, user_id) is the primary key.
```

查询各赛事的用户注册百分率，保留两位小数。

返回的结果表按 percentage 的 降序 排序，若相同则按 contest_id 的 升序 排序。

```none
Input:
Users table:
+---------+-----------+
| user_id | user_name |
+---------+-----------+
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |
+---------+-----------+
Register table:
+------------+---------+
| contest_id | user_id |
+------------+---------+
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |
+------------+---------+
Output:
+------------+------------+
| contest_id | percentage |
+------------+------------+
| 208        | 100.0      |
| 209        | 100.0      |
| 210        | 100.0      |
| 215        | 66.67      |
| 207        | 33.33      |
+------------+------------+

解释：
所有用户都注册了 208、209 和 210 赛事，因此这些赛事的注册率为 100% ，我们按 contest_id 的降序排序加入结果表中。
Alice 和 Alex 注册了 215 赛事，注册率为 ((2/3) * 100) = 66.67%
Bob 注册了 207 赛事，注册率为 ((1/3) * 100) = 33.33%
```

```sql
-- MySQL
SELECT
    contest_id,
    ROUND(COUNT(user_id) * 100 / (SELECT count(*) FROM users), 2) percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage desc, contest_id

-- SQL
SELECT
    contest_id,
    CONVERT(DECIMAL(18, 2), COUNT(user_id * 1.00) * 100 / (SELECT COUNT(*) * 1.00 FROM users)) percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage desc, contest_id
```

## Queries Quality and Percentage - Easy

查询结果的质量和占比：

```none
Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+

此表没有主键，并可能有重复的行。
此表包含了一些从数据库中收集的查询信息。
“位置”（position）列的值为 1 到 500 。
“评分”（rating）列的值为 1 到 5 。评分小于 3 的查询被定义为质量很差的查询。
```

将查询结果的质量 quality 定义为：

各查询结果的评分与其位置之间比率的平均值。

将劣质查询百分比 poor_query_percentage 为：

评分小于 3 的查询结果占全部查询结果的百分比。

编写一组 SQL 来查找每次查询的名称(query_name)、质量(quality) 和 劣质查询百分比(poor_query_percentage)。

质量(quality) 和劣质查询百分比(poor_query_percentage) 都应四舍五入到小数点后两位。

```none
Input:
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output:
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Dog 查询结果的质量为 ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog 查询结果的劣质查询百分比为 (1 / 3) * 100 = 33.33

Cat 查询结果的质量为 ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat 查询结果的劣质查询百分比为 (1 / 3) * 100 = 33.33
```

```sql
-- MySQL
SELECT
    query_name,
    ROUND(AVG(rating/position), 2) quality,
    ROUND(SUM(IF(rating < 3, 1, 0)) * 100 / COUNT(*), 2) poor_query_percentage
FROM Queries
GROUP BY query_name
```

## Monthly Transactions I - Medium

每月交易 I：

```none
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key
The state column is an enum of type ["approved", "declined"].
```

查找每个月和每个国家/地区的事务数及其总金额、已批准的事务数及其总金额。

以 任意顺序 返回结果表。

```none
Input:
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output:
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
```

```sql
-- MySQL
SELECT
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(*) AS trans_count,
    COUNT(IF(state = 'approved', 1, NULL)) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
FROM transactions
GROUP BY month, country
```

## Immediate Food Delivery II - Medium

即时食物配送 II：

```none
Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the primary key
```

如果顾客期望的配送日期和下单日期相同，则该订单称为 「即时订单」，否则称为「计划订单」。

「首次订单」是顾客最早创建的订单。我们保证一个顾客只会有一个「首次订单」。

写一条 SQL 查询语句获取即时订单在所有用户的首次订单中的比例。保留两位小数。

```none
Input:
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output:
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+

1 号顾客的 1 号订单是首次订单，并且是计划订单。
2 号顾客的 2 号订单是首次订单，并且是即时订单。
3 号顾客的 5 号订单是首次订单，并且是计划订单。
4 号顾客的 7 号订单是首次订单，并且是即时订单。
因此，一半顾客的首次订单是即时的。
```

```sql
-- MySQL
SELECT
    ROUND(SUM(order_date = customer_pref_delivery_date) * 100 / COUNT(*), 2)
    AS immediate_percentage
FROM delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, min(order_date)
    FROM delivery
    GROUP BY customer_id
)
```

##


















# Refer

[「新」动计划 · 编程入门](https://leetcode.cn/studyplan/primers-list)
[高频 SQL 50 题（基础版）](https://leetcode.cn/studyplan/sql-free-50)
[LeetCode 热题 100](https://leetcode.cn/studyplan/top-100-liked)
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