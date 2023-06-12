---
title: SQL 数据库系列笔记
date: 2023-04-29 21:56:54
categories: Programming
---
# Pref

主要整理 SQL 语言，其次是 DBMS 等数据库知识，求职必备啊，欠下的知识迟早要补上，往后定要化被动为主动，学得太赶了，头秃……

# Basis

数据库（database）保存有组织的数据的容器（通常是一个或一组文件）

表（table）某种特定类型数据的结构化清单。

模式（schema）关于数据库和表的布局及特性的信息。

列（column）表中的一个字段。表都是由一个或多个列组成的。

数据类型（datatype）定义了列可以存储哪些数据种类。

行（row）表中的一个记录。也称记录（record），行才是正确术语。

主键（primary key）一列或几列，其值能够唯一标识表中每一行。

> 注：应总是定义主键，可能不需要，但保证创建的每个表具有一个主键，便于以后的数据操作管理。

满足条件：

- 任意两行都不具有相同的主键值；
- 每一行都必须具有一个主键值（主键列不允许空值 NULL）；
- 主键列中的值不允许修改或更新；
- 主键值不能重用（若某行从表中删除，其主键不能再赋给新行）

SQL（发音 sequel）（Structured Query Language）结构化查询语言。

多条 SQL 语句必须以分号（；）分隔，部分 DBMS 需要单条语句后都加。

SQL 语句不区分大小写。

处理 SQL 语句时，空格都被忽略。

SQL 语句一般返回无格式的数据。

子句（clause）SQL 语句由子句构成。一个子句通常由一个关键字加上所提供的数据组成。

可移植（portable）可在多个系统上运行。

查询（query）任何 SQL 语句都是查询。但一般指 SELECT 语句。

子查询（subquery）即嵌套在其他查询中的查询。

结果集（result set）SQL 查询所检索出的结果。

# 检索数据

## 检索单个列

```sql
SELECT prod_name
FROM Products;
```

从 Products 表中检索 prod_name 列。

![](/images/select_1_column.png)

根据具体 DBMS 和客户端，会得出检索行数和时间。
如 MySQL——`9 rows in set (0.01 sec)`

## 检索多个列

> 选择多列时，列名之间加逗号，最后一个不加，否则报错。

```sql
SELECT prod_id, prod_name, prod_price
FROM Products;
```

![](/images/select_2_column.png)

## 检索所有列

```sql
SELECT *
FROM Products;
```

## 检索不同值

```sql
SELECT vend_id
FROM Products;
```

![](/images/select_id.png)

返回 9 行（即使表中只有 3 个产品供应商），因为 Products 表中有 9 种产品。

DISTINCT 关键字，指示数据库只返回不同的值。

```sql
SELECT DISTINCT vend_id
FROM Products;
```

![](/images/select_id2.png)

> 注：不能部分使用 DISTINCT。作用于所有列，不单是跟在其后的那一列。

## 限制结果（DBMS 实现不同）

### SQL Server

```sql
SELECT TOP 5 prod_name
FROM Products;
```

![](/images/select_top.png)

### DB2

```sql
SELECT prod_name
FROM Products
FETCH FIRST 5 ROWS ONLY;
```

### Oracle

ROWNUM（行计数器）

```sql
SELECT prod_name
FROM Products
WHERE ROWNUM <=5;
```

### MySQL、MariaDB、PostgreSQL 或 SQLite

```sql
SELECT prod_name
FROM Products
LIMIT 5;
```

第一个数字是检索的行数，第二个数字是指从哪开始。
如下：返回从第 5 行起的 5 行数据。只有 9 种产品，所以只返回了 4 行数据。

> 注：第一个被检索的行是第 0 行。`LIMIT 1 OFFSET 1` 会检索第 2 行。

```sql
SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;
```

![](/images/select_offset.png)

#### MySQL、MariaDB 和 SQLite 捷径

可以把 `LIMIT 4 OFFSET 3` 简化为 `LIMIT 3,4`

## 注释

```sql
/* 多行注释 */
SELECT prod_name -- 注释，都支持
FROM Products; # 注释，有些不支持
```

# 排序

## 按单/多列排序

该子句取一个或多个列名，以字母顺序排序数据。

```sql
SELECT prod_name
FROM Products
ORDER BY prod_name; -- 按单列排序
ORDER BY prod_price, prod_name; -- 按多列排序
```

> 注： ORDER BY 子句的位置应该是 SELECT 语句中最后一条子句，否则会报错。

![](/images/select_order.jpeg)

![](/images/select_order2.png)

仅在多个行具有相同的 prod_price 值时，才对产品按 prod_name 进行排序。如果 prod_price 列中所有的值都是唯一的，则不会按 prod_name 排序。

## 按列位置排序

```sql
SELECT prod_id, prod_price, prod_name -- 按列位置排序
FROM Products
ORDER BY 2, 3;
```

![](/images/select_order3.jpeg)

`ORDER BY 2，3` 表示先按 prod_price，再按 prod_name 进行排序。

## 指定排序方向

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC; -- 降序，默认是升序 A-Z
```

![](/images/select_order4.png)

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name; -- 多列分别排序
```

![](/images/select_order5.jpeg)

prod_price 列以降序排序，prod_name 列（在每个价格内）按升序排序。

> 注：若想在多列上进行降序排序，必须对每一列指定 DESC。
> DESCENDING 是全写，亦可使用。
> ASCENDING「ASC」升序，默认无需指定。
> 区分大小写和排序顺序：
在字典（dictionary）排序顺序中，大小写相同，是多数 DBMS 默认做法，同时允许改变。

# 过滤数据

## WHERE 子句

搜索条件（search criteria）也称过滤条件（filter condition）

```sql
SELECT prod_name, prod_price
FROM Products
WHERE prod_price = 3.49;
```

![](/images/select_where.png)

> ORDER BY 位于 WHERE 之后，否则将报错。

## WHERE 操作符

操作符（operator）用来联结或改变 WHERE 子句中的子句的关键字，也称为逻辑操作符（logical operator）。

| 操 作 符 | 说 明    | 操 作 符 | 说 明                    |
| -------- | -------- | -------- | ------------------------ |
| =        | 等于     | >        | 大于                     |
| < >      | 不等于   | >=       | 大于等于                 |
| !=       | 不等于   | !>       | 不大于                   |
| <        | 小于     | BETWEEN  | 指定两个值之间（都包括） |
| <=       | 小于等于 | IS NULL  | 为NULL值                 |
| !<       | 不小于   |

```sql
SELECT prod_name, prod_price
FROM Products
WHERE prod_price < 10; -- 检查单个值
WHERE vend_id <> 'DLL01'; -- 不匹配检查
WHERE prod_price BETWEEN 5 AND 10; -- 范围值检查
WHERE prod_price IS NULL; -- 空值检查
```

NULL 无值（no value），与字段包含 0、空字符串或仅空格不同。
如上，返回空 prod_price 字段，不是价格为 0。

![](/images/select_where2.png)

![](/images/select_where3.png)

![](/images/select_where4.png)

# 高级数据过滤

## 组合 WHERE 子句，AND OR IN NOT 操作符

```sql
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01' AND prod_price <= 4;
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01';
```

![](/images/select_where_and.png)

许多 DBMS 在 OR WHERE 子句的第一个条件满足时，就不再计算第二个条件了。

![](/images/select_where_or.png)

### 求值顺序，() 明确分组

```sql
SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
   AND prod_price >= 10;
```

![](/images/select_where_().png)

```sql
SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ('DLL01','BRS01') -- IN 与 OR 功能相当
ORDER BY prod_name;

SELECT prod_name, prod_price
FROM Products
WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
ORDER BY prod_name;
```

检索由供应商 DLL01 和 BRS01 制造的所有产品，以上两种表达一样。

![](/images/select_where_in.png)

- IN 优点：
IN 操作符的语法更直观；
在与 AND 和 OR 组合使用 IN 时，求值顺序更容易管理；
IN 一般比一组 OR 执行更快；
IN 最大优点是可包含其他 SELECT 语句，能更动态地建立 WHERE 子句。

NOT 从不单独使用（总是与其他操作符一起使用），所以它的语法与其他操作符不同。可以用在要过滤的列前，而不仅是在其后。

```sql
SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01' -- NOT 与 <> 功能相当
ORDER BY prod_name;

SELECT prod_name
FROM Products
WHERE vend_id <> 'DLL01'
ORDER BY prod_name;
```

![](/images/select_where_not.png)

> MariaDB 支持使用 NOT 否定 IN、BETWEEN 和 EXISTS 子句。大多数
DBMS 允许使用 NOT 否定任何条件。

# 通配符过滤 LINK

通配符（wildcard）用来匹配值的一部分的特殊字符。

搜索模式（search pattern）由字面值、通配符或两者组合构成的搜索条件。

谓词（predicate）即操作符作为谓词时。从技术上说，LIKE 是谓词。虽然最终的结果是相同的。

通配符搜索只能用于文本字段（字符串）。

## 通配符 % _ []

`%` 表示任何字符出现任意次数（包括 0）。
子句 `WHERE prod_name LIKE '%'` 不会匹配产品名称为 NULL 的行。

`_` 只匹配单个字符。（DB2 不支持通配符 `_`）

`[]` 用来指定一个字符集，必须匹配指定位置的一个字符。
（SQL Server 支持集合，MySQL，Oracle，DB2，SQLite 都不支持。）
此通配符可以用前缀字符 `^`（脱字号）来否定。

```sql
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%'; -- 所有以 Fish 开头产品，大小写区分根据 DBMS 配置
WHERE prod_name LIKE '%bean bag%'; -- 可使用多个通配符
WHERE prod_name LIKE '__ inch teddy bear';
```

![](/images/link_%.png)

![](/images/link_%2.png)

![](/images/link__.png)

> 注：字符串后面可能用空格填充，故匹配以某字母结尾，需要后面加百分号 `y%`

```sql
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%' -- 找出名字以 J 或 M 起头的联系人
# WHERE cust_contact LIKE '[^JM]%' -- 更简化
# WHERE NOT cust_contact LIKE '[JM]%' -- 与 ^ 结果相同
ORDER BY cust_contact;
```

![](/images/link_[].png)

## 通配符技巧

不要过度使用通配符。耗时长，优先使用其他能达到相同目的的操作符。
尽量不要把它们用在搜索模式的开始处，这样搜索起来是最慢的。

# 创建计算字段

## 计算字段

计算字段是运行时在 SELECT 语句内创建的。

字段（field）基本上与列的意思相同，经常互换使用，不过数据库列一般称为列，而字段这个术语通常在计算字段这种场合下使用。

## 拼接字段

拼接（concatenate）将值联结到一起（将一个值附加到另一个值）构成单个值。

SQL Server 使用 `+` 号。
DB2、Oracle、PostgreSQL 和 SQLite 使用 `||`。
MySQL 和 MariaDB 使用特殊函数 `Concat`。

```sql
SELECT vend_name + ' (' + vend_country + ')'
# SELECT vend_name || ' (' || vend_country || ')'
# SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;
```

![](/images/+.png)

许多数据库保存填充为列宽的文本值，不需要这些空格时如下：

```sql
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
FROM Vendors
ORDER BY vend_name;
```

![](/images/+2.png)

## 别名 AS

别名（alias）有时也称导出列（derived column）

```sql
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
 AS vend_title
FROM Vendors
ORDER BY vend_name;
```

![](/images/alias.png)

## 执行算术计算

```sql
SELECT prod_id,
    quantity,
    item_price,
    quantity*item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;
```

![](/images/expanded.png)

操作符：`+` 加 `-` 减 `*` 乘 `/` 除

# 函数

| 函 数                | 语 法                                                                                                                                    |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| 提取字符串的组成部分 | DB2、Oracle、PostgreSQL 和 SQLite 使用 SUBSTR()；MariaDB、MySQL 和 SQL Server 使用 SUBSTRING()                                           |
| 数据类型转换         | Oracle 每种类型的转换有一个函数；DB2 和 PostgreSQL 使用 CAST()；MariaDB、MySQL 和 SQL Server 使用 CONVERT()                              |
| 取当前日期           | DB2 和 PostgreSQL 使用 CURRENT_DATE；MariaDB 和 MySQL 使用 CURDATE()；Oracle 使用 SYSDATE；SQL Server 使用 GETDATE()；SQLite 使用 DATE() |

多数 SQL 支持以下类型函数：

- 处理文本字符串的文本函数；
- 数值数据上进行算术操作的数值函数；
- 处理日期时间并提取特定成分的日期和时间函数；
- 格式化函数，如货币符号和千分位表示金额；
- 返回 DBMS 正使用的特殊信息的系统函数。

## 文本处理函数

```sql
SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name;
```

![](/images/upper.jpeg)

| 函 数                         | 说 明                                                   |
| ----------------------------- | ------------------------------------------------------- |
| LEFT()（或使用子字符串函数）  | 返回字符串左边的字符 DB2, PostgreSQL, MySQL, SQL Server |
| RIGHT()（或使用子字符串函数） | 返回字符串右边的字符                                    |
| LENGTH() DATALENGTH() LEN()   | 返回字符串的长度                                        |
| LOWER()                       | 将字符串转换为小写                                      |
| UPPER()                       | 将字符串转换为大写                                      |
| LTRIM()                       | 去掉字符串左边的空格                                    |
| RTRIM()                       | 去掉字符串右边的空格                                    |
| TRIM()                        | 去掉字符串两边的空格                                    |
| SUBSTR() SUBSTRING()          | 提取字符串的组成部分 Oracle, SQLite                     |
| SOUNDEX()                     | 返回字符串的 SOUNDEX值                                  |

SOUNDEX 是一个将任何文本串转换为描述其语音表示的字母数字模式的算法。能对字符串进行发音比较而不是字母比较。虽然 SOUNDEX 不是 SQL 概念，但多数 DBMS 都提供支持。

> PostgreSQL 不支持 SOUNDEX()。
如果在创建 SQLite 时使用了 SQLITE_SOUNDEX 编译时选项，那么 SOUNDEX() 才可用。因为 SQLITE_SOUNDEX 不是默认编译时选项，所以多数 SQLite 实现不支持 SOUNDEX()。

```sql
SELECT cust_name, cust_contact
FROM Customers
# WHERE cust_contact = 'Michael Green'; -- 用正确拼写无法检索
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');
```

表中的联系名是 Michelle Green 有误，正确拼写是 Michael Green。

## 日期和时间函数

```sql
SELECT order_num
FROM Orders
WHERE DATEPART(yy, order_date) = 2020; -- SQL Server。参数：返回的成分和从中返回成分的日期。
# WHERE DATE_PART('year', order_date) = 2020; -- PostgreSQL
# WHERE EXTRACT(year FROM order_date) = 2020; -- Oracle, PostgreSQL
# WHERE order_date BETWEEN to_date('2020-01-01', 'yyyy-mm-dd')
AND to_date('2020-12-31', 'yyyy-mm-dd'); -- Oracle，将两个字符串转换为日期；SQL Server 不支持 to_date()，但这里换成 DATEPART() 支持
# WHERE YEAR(order_date) = 2020; -- DB2，MySQL 和 MariaDB 具有各种日期处理函数，但没有 DATEPART()
# WHERE strftime('%Y', order_date) = '2020'; -- SQLite
```

![](/images/date.png)

## 数值函数

| 函 数  | 说 明              |
| ------ | ------------------ |
| ABS()  | 返回一个数的绝对值 |
| SIN()  | 返回一个角度的正弦 |
| COS()  | 返回一个角度的余弦 |
| TAN()  | 返回一个角度的正切 |
| EXP()  | 返回一个数的指数值 |
| SQRT() | 返回一个数的平方根 |
| PI()   | 返回圆周率 π 的值  |

# 汇总数据

## 聚集函数

聚集函数（aggregate function）对某些行运行的函数，计算并返回一个值。

| 函 数   | 说 明            |
| ------- | ---------------- |
| AVG()   | 返回某列的平均值 |
| COUNT() | 返回某列的行数   |
| MAX()   | 返回某列的最大值 |
| MIN()   | 返回某列的最小值 |
| SUM()   | 返回某列值之和   |

```sql
SELECT AVG(prod_price) AS avg_price -- AVG() 只用于单列，忽略列值为 NULL 的行。
FROM Products; -- 表中所有产品
```

![](/images/avg().png)

使用 COUNT(*) 对表中行的数目进行计数，包括空值（NULL）。
使用 COUNT(column) 对特定列中具有值的行进行计数，忽略 NULL 值。

```sql
SELECT COUNT(*) AS num_cust
# SELECT COUNT(cust_email) AS num_cust
FROM Customers;
```

![](/images/count().png)

MAX() 一般用来找出最大的数值或日期值；用于文本数据时，返回按该列排序后的最后一行，忽略列值为 NULL 的行。MIN() 相反。

```sql
SELECT SUM(item_price*quantity) AS total_price -- 计算总价钱
FROM OrderItems
WHERE order_num = 20005;
```

![](/images/sum().png)

## 聚集不同值

对所有行执行计算，指定 ALL 参数（默认）或不指定参数。
只包含不同的值，指定 DISTINCT 参数。

```sql
SELECT AVG(DISTINCT prod_price) AS avg_price -- 平均值只考虑各个不同的价格，相同价格会排除
FROM Products
WHERE vend_id = 'DLL01';
# 输出：4.2400
```

DISTINCT 不能用于 COUNT(*)，只能用于 COUNT()。
DISTINCT 必须使用列名，不能用于计算或表达式。

## 组合聚集函数

```sql
SELECT COUNT(*) AS num_items,
    MIN(prod_price) AS price_min,
    MAX(prod_price) AS price_max,
    AVG(prod_price) AS price_avg
FROM Products;
```

![](/images/count()2.png)

> 注：最好指定别名以包含某个聚集函数的结果。否则许多 SQL 可能会产生错误消息。

# 分组

## 创建分组 GROUP BY

```sql
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id; -- 按 vend_id 排序并分组数据
```

![](/images/group.png)

GROUP BY 子句可以包含任意数目的列，还可以嵌套，但不能是聚集函数。
如果在 SELECT 中使用表达式，则必须在 GROUP BY 中指定相同的表达式，不能使用别名。
多数 SQL 实现不允许 GROUP BY 列带有长度可变的数据类型（如文本或备注型字段）
除聚集计算语句外，SELECT 语句中的每一列都必须在 GROUP BY 中给出。
如果分组列中包含具有 NULL 值的行，则 NULL 将作为一个分组返回。列中多行 NULL 值，将分为一组。
GROUP BY 必须出现在 WHERE 之后，ORDER BY 之前。

> SQL Server 等有些 SQL 实现在 GROUP BY 中支持可选的 ALL 子句。用来返回所有分组，即使是没有匹配行的分组也返回（在此情况下，聚集将返回 NULL）。

> 通过相对位置指定列：
有些 SQL 实现允许根据 SELECT 列表中的位置指定 GROUP BY 的列。
如 `GROUP BY 2, 1` 表示按选择的第二个列分组，再按第一个列分组。

## 过滤分组

WHERE 过滤行，HAVING 过滤分组。HAVING 支持所有 WHERE 操作符。
WHERE 在数据分组前进行过滤，HAVING 在分组后过滤。
WHERE 排除的行不包括在分组中，可能会改变计算值，从而影响 HAVING 中基于这些值过滤掉的分组。
使用 HAVING 时应该结合 GROUP BY，而 WHERE 用于标准的行级过滤。

```sql
SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;
```

![](/images/having.png)

## 分组和排序

| ORDER BY                       | GROUP BY                                             |
| ------------------------------ | ---------------------------------------------------- |
| 对产生的输出排序               | 对行分组，输出可能不是分组的顺序                     |
| 任意列都可用（甚至非选择的列） | 只能使用选择列或表达式列，且必须使用每个选择列表达式 |
| 不一定需要                     | 如果与聚集函数一起使用列（或表达式），则必须使用     |

> 一般在使用 GROUP BY 时，也给出 ORDER BY。这是保证数据正确排序的唯一方法。

```sql
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;
```

![](/images/group2.png)

## SELECT 子句顺序

| 子 句    | 说 明              | 是否必须使用           |
| -------- | ------------------ | ---------------------- |
| SELECT   | 要返回的列或表达式 | 是                     |
| FROM     | 从中检索数据的表   | 仅在从表选择数据时使用 |
| WHERE    | 行级过滤           | 否                     |
| GROUP BY | 分组说明           | 仅在按组计算聚集时使用 |
| HAVING   | 组级过滤           | 否                     |
| ORDER BY | 输出排序顺序       | 否                     |

# 子查询

## 子查询过滤

```sql
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));
```

![](/images/subquery.png)

子查询的 SELECT 语句只能查询单个列。

## 作为计算字段使用

```sql
SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
        FROM Orders
        WHERE Orders.cust_id = Customers.cust_id) AS orders
        -- 完全限定列名，指定表名和列名，比较 Orders 表中的 cust_id 和正从 Customers 表中检索的 cust_id
FROM Customers
ORDER BY cust_name;
```

![](/images/subquery2.png)

SELECT 对 Customers 表中每个顾客返回三列： cust_name、
cust_state 和 orders。
orders 是一个计算字段，由括号中子查询建立。该子查询对检索出的每个顾客执行一次。

# 联结表

**联结（join）**是一种机制，用来在一条 SELECT 语句中关联表。要保证所有联结都有 WHERE 子句。

**关系表**的设计就是要把信息分解成多个表，一类数据一个表。各表通过某些共同的值互相关联（所以才叫关系数据库）。

**可伸缩（scale）**能够适应不断增加的工作量而不失败。设计良好的数据库或应用程序称为可伸缩性好（scale well）

## 创建联结

```sql
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id; -- 指示 DBMS 将 Vendors 表中的 vend_id 与 Products 表中的匹配起来。
```

![](/images/join.png)

**笛卡儿积（cartesian product）**由没有联结条件的表关系返回的结果为笛卡儿积。检索出的行的数目将是第一个表中的行数乘以第二个表中的行数。返回笛卡儿积的联结，也称**叉联结（cross join）**

```sql
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products; -- 返回笛卡尔积
```

## 内联结

以上联结称为**等值联结（equijoin）**，基于两个表之间的相等测试。也称为**内联结（inner join）**

```sql
SELECT vend_name, prod_name, prod_price
FROM Vendors
INNER JOIN Products ON Vendors.vend_id = Products.vend_id;
```

两个表之间的关系是以 INNER JOIN 指定的部分 FROM 子句。联结条件用特定的 ON 子句而不是 WHERE 子句给出。传递给 ON 的实际条件与传递给 WHERE 的相同。

> ANSI SQL 规范首选 INNER JOIN 语法。

## 联结多个表

```sql
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id = Vendors.vend_id
 AND OrderItems.prod_id = Products.prod_id
 AND order_num = 20007;
```

![](/images/join2.png)

这个例子显示订单 20007 中的物品。订单物品存储在 OrderItems 表中。
每个产品按其产品 ID 存储，它引用 Products 表中的产品。这些产品通
过供应商 ID 联结到 Vendors 表中相应的供应商，供应商 ID 存储在每个
产品的记录中。

> DBMS 对联结中表的最大数目有限制。

```sql
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));

# 联结更有效
SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
 AND Orders.order_num = OrderItems.order_num
 AND prod_id = 'RGAN01';
```

![](/images/join3.png)

# 高级联结

## 表别名

表别名只在查询执行中使用。

```sql
SELECT cust_name, cust_contact
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
 AND O.order_num = OI.order_num
 AND prod_id = 'RGAN01';
```

> Oracle 不支持 AS 关键字，直接指定即可 `Customers C`

## 不同类型的联结

### 自联结（self-join）

```sql
SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
                   FROM Customers
                   WHERE cust_contact = 'Jim Jones');

# 使用联结的相同查询
SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
AND c2.cust_contact = 'Jim Jones';
```

![](/images/join4.png)

此查询中需要的两个表实际上是相同的表，因此 Customers 表在 FROM
子句中出现了两次。虽然这是完全合法的，但对 Customers 的引用具有
歧义性，因此使用表别名。

- 用自联结而不用子查询
自联结通常作为外部语句，用来替代从相同表中检索数据的使用子查询语句。许多 DBMS 处理联结远比子查询快。

### 自然联结（natural join）

标准联结（内联结）返回所有数据，相同的列甚至多次出现。
自然联结排除多次出现，使每一列只返回一次。

自然联结只能选择唯一的列，一般通过对一个表使用通配符（SELECT *），而对其他表的列使用明确的子集来完成。

```sql
SELECT C.*, O.order_num, O.order_date,
       OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
 AND OI.order_num = O.order_num
 AND prod_id = 'RGAN01';
```

> 很可能永远都不会用到不是自然联结的内联结。

### 外联结（outer join）

联结包含了那些在相关表中没有关联行的行。

```sql
SELECT Customers.cust_id, Orders.order_num
FROM Customers
 LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;
```

![](/images/join5.jpeg)

使用 OUTER JOIN 时，必须使用 RIGHT 或 LEFT 关键字指定包括其所有行的表。RIGHT 指出的是 OUTER JOIN 右边的表，LEFT 指左边。

> SQLite 支持 LEFT OUTER JOIN，但不支持 RIGHT OUTER JOIN。

**全外联结（full outer join）**检索两个表中的所有行并关联那些可以关联的行。

```sql
SELECT Customers.cust_id, Orders.order_num
FROM Customers
 FULL OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;
```

> MariaDB、MySQL 和 SQLite 不支持全外联结。

## 带聚集函数的联结

```sql
SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers
 LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;
```

![](/images/join6.png)

> 一般使用内联结，但使用外联结也有效。
总是提供联结条件，否则会得出笛卡儿积。

# 组合查询 UNION

组合查询通常称为**并（union）**或**复合查询（compound query）**

使用情况：
在一个查询中从不同的表返回结构数据；
对一个表执行多个查询，按一个查询返回数据。

```sql
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

# WHERE 相同结果
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI') OR cust_name = 'Fun4All';
```

![](/images/union.png)

## UNION 规则

UNION 必须由两条或以上的 SELECT 语句组成，语句之间用 UNION 分隔；
UNION 中每个查询必须包含相同的列、表达式或聚集函数；
列数据类型必须兼容：类型不必完全相同，但必须是 DBMS 可以隐含转换的类型（如，不同数值类型或不同日期类型）。

> 注：结合 UNION 使用的 SELECT 语句遇到不同的列名，会返回第一个名字，其他语句使用时也必须以第一个为准，否则报错。

## 包含或取消重复的行 UNION ALL

```sql
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI')
UNION ALL -- 返回所有匹配行，可能有重复
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';
```

![](/images/union_all.png)

## 对组合查询结果排序

使用 UNION 时，只能使用一条 ORDER BY，必须位于最后一条 SELECT 语句之后。

```sql
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All'
ORDER BY cust_name, cust_contact;
```

![](/images/union2.png)

> 某些 DBMS 还支持其他 UNION：`EXCEPT`（有时称为 `MINUS`）用来检索只在第一个表中存在而在第二个表中不存在的行；而 `INTERSECT` 用来检索两个表中都存在的行。实际上这两种很少使用，因为相同结果可用联结得到。

# 插入数据 INSERT

## 插入完整行

必须给每一列提供一个值，没有值则指定 NULL。

```sql
# 不安全，避免使用，次序要和表一致。
INSERT INTO Customers
VALUES(1000000006,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA',
       NULL,
       NULL);
```

```sql
# 更安全，次序随意，以列名匹配。
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_contact,
                      cust_email)
VALUES(1000000006,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA',
       NULL,
       NULL);
```

> 不能插入同一条记录两次，主键（cust_id）的值必须有唯一性。

## 插入部分行

```sql
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
VALUES(1000000006,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA');
```

- 省略列
该列定义为允许 NULL 值（无值或空值）；
在表定义中给出默认值。

## 插入检索出的数据

从 CustNew 表中读出数据并插入到 Customers 表。

```sql
INSERT INTO Customers(cust_id,
                      cust_contact,
                      cust_email,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
SELECT cust_id,
       cust_contact,
       cust_email,
       cust_name,
       cust_address,
       cust_city,
       cust_state,
       cust_zip,
       cust_country
FROM CustNew;
```

> 注：INSERT SELECT 中的列名，这里不一定要求列名匹配，以两个表对应的列位置匹配。

INSERT 通常只插入一行。要插入多行，必须执行多个 INSERT 语句。INSERT SELECT 是例外。

## 一个表复制到另一个表

CREATE SELECT 语句（SQL Server 也可用 SELECT INTO）（DB2 不支持 CREATE SELECT）。

```sql
CREATE TABLE CustCopy AS SELECT * FROM Customers; -- MySQL, MariaDB, Oracle, PostgreSQL, SQLite
# SELECT * INTO CustCopy FROM Customers; -- SQL Server
```

> SELECT INTO 是试验新 SQL 语句前进行表复制的很好工具，不影响实际数据。

### SELECT INTO 注意事项

任何 SELECT 选项和子句都可使用；
可利用联结从多个表插入数据；
不管从多少表中检索数据，数据只能插入到一个表中。

# 更新数据

不要省略 WHERE 子句。UPDATE 语句以 WHERE 结束，它告诉 DBMS 更新哪一行。

```sql
UPDATE Customers -- 要更新的表
SET cust_contact = 'Sam Roberts',
    cust_email = 'kim@thetoystore.com' -- 列名和新值
    # cust_email = NULL -- 删除值
WHERE cust_id = 1000000005; -- 过滤条件
```

# 删除数据

```sql
DELETE FROM Customers
WHERE cust_id = 1000000006;
```

使用外键确保引用完整性的一个好处是 DBMS 通常可以防止删除某数据与其他表相关联的行。
如，要从 Products 表中删除一个产品，而这个产品用在 OrderItems 的已有订单中，那么 DELETE 语句将抛出错误并中止。这是总要定义外键的另一个理由。

DELETE 删除整行而不是列。删除指定列，用 UPDATE 语句。

想从表中删除所有行，可使用 `TRUNCATE TABLE` 语句速度更快（因为不记录数据的变动）。

## 更新和删除指导原则

除非打算更新和删除每一行，否则绝对带着 WHERE 子句。

在 UPDATE 或 DELETE 语句使用 WHERE 子句前，应先用 SELECT 进行测试，保证它过滤的是正确的记录，以防编写的 WHERE 子句不正确。

```sql
SELECT * FROM Customers
WHERE cust_id = 1000000042;
DELETE Customers
WHERE cust_id = 1000000042;
```

# 表

## 创建表 CREATE TABLE

```sql
CREATE TABLE Products -- 新表名
( -- 表列的名字和定义，逗号分隔
    prod_id CHAR(10) NOT NULL,
    vend_id CHAR(10) NOT NULL,
    prod_name CHAR(254) NOT NULL,
    prod_price DECIMAL(8,2) NOT NULL,
    prod_desc VARCHAR(1000) NULL -- DB2 必须从最后一列中去掉 NULL
);
```

允许 NULL 值的列也允许在插入行时不给出该列的值。
不允许的列不接受没有列值的行，即插入或更新行时，该列必须有值。
只有不允许 NULL 值的列可作为主键。

NULL 值不是空字符串，如果指定 `''`（其间无字符），这在 NOT NULL 列中是允许的。空字符串是一个有效的值，它不是无值。

## 指定默认值 DEFAULT

```sql
CREATE TABLE OrderItems
(
    order_num INTEGER NOT NULL,
    order_item INTEGER NOT NULL,
    prod_id CHAR(10) NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    item_price DECIMAL(8,2) NOT NULL
);
```

- 获得系统日期
| DBMS       | 函数/变量      |
| ---------- | -------------- |
| DB2        | CURRENT_DATE   |
| MySQL      | CURRENT_DATE() |
| Oracle     | SYSDATE        |
| PostgreSQL | CURRENT_DATE   |
| SQL Server | GETDATE()      |
| SQLite     | date('now')    |

## 更新表 ALTER TABLE

许多 DBMS 不允许删除或更改表中的列，允许重命名；
限制对已经填有数据的列进行更改，对未填有数据的列几乎无限制。

```sql
ALTER TABLE Vendors
ADD vend_phone CHAR(20);
# DROP COLUMN vend_phone; -- 部分 DBMS 支持
```

> SQLite 不支持用 ALTER TABLE 定义主键和外键，必须在最初创建表时指定。

- 复杂的表结构更改一般需要手动删除：
1. 创建一个新表；
2. 用 INSERT SELECT 语句从旧表复制数据到新表，按需要修改；
3. 检验包含所需数据的新表；
4. 重命名旧表（若确定，可删除它）；
5. 用旧表名字重命名新表；
6. 重新创建触发器、存储过程、索引和外键。

## 删除表 DROP TABLE

删除表没有确认步骤，不能撤销，将永久删除。

```sql
DROP TABLE CustCopy;
```

## 重命名表

DB2、MariaDB、MySQL、Oracle、PostgreSQL 使用 RENAME 语句；
SQL Server 使用 sp_rename 存储过程；
SQLite 使用 ALTER TABLE 语句。

# 视图

视图是虚拟的表。表包含数据，视图只包含使用时动态检索数据的查询。

> SQLite 仅支持只读视图，所以视图可以创建、读，但内容不能更改。
> 所有 DBMS 一致支持视图创建语法。

删除视图，`DROP VIEW viewname;`
覆盖或更新视图，必须先删除再重新创建。

```sql
SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num
AND prod_id = 'RGAN01';

-- 把上面查询包装成虚拟表 ProductCustomers
SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';
```

## 视图应用

重用 SQL 语句。
简化复杂的 SQL 操作。
使用表的一部分而不是整个表。
保护数据。可以授予用户访问表的特定部分的权限，而不是整个表的访问权限。
更改数据格式和表示。视图可返回与底层表的表示和格式不同的数据。

## 视图规则和限制

视图必须唯一命名，不能和其他表名重复。
创建的视图数目没有限制，必须具有足够的访问权限。
视图可以嵌套，即可以利用从其他视图中检索数据的查询来构造视图。所允许的嵌套层数在不同的 DBMS 中有所不同（嵌套视图可能会严重降低查询性能，因此使用前应进行全面测试）。
许多 DBMS 禁止在视图查询中使用 ORDER BY 子句。
有些 DBMS 要求对返回的所有列进行命名，如果列是计算字段，则需要使用别名。
视图不能索引，也不能有关联的触发器或默认值。
有些 DBMS 把视图作为只读的查询，这表示可以从视图检索数据，但不能将数据写回底层表。
有些 DBMS 允许创建这样的视图，它不能进行导致行不再属于视图的插入或更新。例如有一个视图，只检索带有邮件地址的顾客。如果更新某个顾客，删除他的电子邮件地址，将使该顾客不再属于视图。这是允许的默认行为，但有的 DBMS 可能会阻止。

## 用视图简化复杂的联结

```sql
CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
 AND OrderItems.order_num = Orders.order_num;
```

```sql
SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';
```

![](/images/view.png)

## 用视图重新格式化检索出的数据

```sql
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
    AS vend_title
FROM Vendors
ORDER BY vend_name;
```

![](/images/view2.png)

```sql
-- 视图格式化
CREATE VIEW VendorLocations AS
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
    AS vend_title
FROM Vendors;

-- 检索数据
SELECT * FROM VendorLocations;
```

## 用视图过滤不想要的数据

```sql
CREATE VIEW CustomerEMailList AS
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL;

SELECT * FROM CustomerEMailList;
```

![](/images/view3.png)

## 使用视图与计算字段

```sql
CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity*item_price AS expanded_price
FROM OrderItems

SELECT * FROM OrderItemsExpanded
WHERE order_num = 20008;
```

![](/images/view4.png)

# 存储过程

存储过程就是为以后使用而保存的一条或多条 SQL 语句。可将其视为批文件。通常以编译过的形式存储，所以 DBMS 处理命令所需的工作量少，提高了性能。

> SQLite 不支持存储过程。

## 执行存储过程

EXECUTE 接受存储过程名和需要传递给它的任何参数。

```sql
EXECUTE AddNewProduct('JTS01', -- 供应商 ID（Vendors 表的主键）
                      'Stuffed Eiffel Tower', -- 产品名
                      6.49, -- 价格
                      'Description'); -- 描述
```

这 4 个参数匹配存储过程中 4 个预期变量（定义为存储过程自身的组成部分）。此存储过程将新行添加到 Products 表，并将传入的属性赋给相应的列。
另一个需要值的 prod_id 列是这个表的主键，最好是使生成此 ID 的过程自动化（而不是依赖于最终用户的输入）。

- 存储过程所完成的工作：
验证传递的数据，保证所有参数都有值；
生成用作主键的唯一 ID；
将新产品插入表，在合适的列中存储生成的主键和传递的数据。

- 具体可选项：
参数可选，具有不提供参数时的默认值。
不按次序给出参数，以「参数=值」方式给出参数值。
输出参数，允许存储过程在正执行的应用程序中更新所用的参数。
用 SELECT 语句检索数据。
返回代码，允许存储过程返回一个值到正在执行的应用程序。

## 创建存储过程

```sql
-- Oracle 版本，对邮件发送清单中具有邮件地址的顾客进行计数。
CREATE PROCEDURE MailingListCount (
    ListCount OUT INTEGER
)
IS
v_rows INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_rows
    FROM Customers
    WHERE NOT cust_email IS NULL;
    ListCount := v_rows;
END;
/*
ListCount 参数从存储过程返回一个值。关键字 OUT 用来指示这种行为。
Oracle 支持 IN（传递值给存储过程）、OUT（从存储过程返回值）、INOUT（既传递又返回值）类型的参数。
存储过程的代码括在 BEGIN 和 END 语句中，用检索出的行数设置 ListCount（要传递的输出参数）
*/

-- SQL Server 版本
CREATE PROCEDURE MailingListCount
AS
DECLARE @cnt INTEGER
SELECT @cnt = COUNT(*)
FROM Customers
WHERE NOT cust_email IS NULL;
RETURN @cnt;

/*
此存储过程没有参数。调用程序检索 SQL Server 返回代码提供的值。
用 DECLARE 语句声明了一个局部变量（SQL Server 中所有局部变量名都以@ 起头）；在 SELECT 语句中让它包含 COUNT() 函数返回的值；最后用 RETURN @cnt 语句将计数返回给调用程序。
*/
```

```sql
-- 调用 Oracle 版本
var ReturnValue NUMBER
EXEC MailingListCount(:ReturnValue);
SELECT ReturnValue;

-- 调用 SQL Server 版本
DECLARE @ReturnValue INT
EXECUTE @ReturnValue=MailingListCount;
SELECT @ReturnValue;
```

```sql
-- SQL Server
CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- 插入新订单
INSERT INTO Orders(cust_id)
VALUES(@cust_id)
-- 返回订单号
SELECT order_num = @@IDENTITY;
```

SQL Server 中称这些自动增量的列为标识字段（identity field）
其他 DBMS 称之为自动编号（auto number）或序列（sequence）
DBMS 对日期使用默认值（GETDATE() 函数），订单号自动生成。
在 SQL Server 上可在全局变量 @@IDENTITY 中得到，它返回到调用程序（这里的 SELECT）。

# 事务处理

使用事务处理（transaction processing），通过确保成批的 SQL 操作完全执行或完全不执行，来维护数据库完整性。

事务（transaction）一组 SQL 语句；
回退（rollback）撤销指定 SQL 语句的过程；
提交（commit）将未存储的 SQL 语句结果写入数据库表；
保留点（savepoint）事务处理中设置的临时占位符（placeholder），可以对它发布回退（与回退整个事务处理不同）。

事务处理用来管理 INSERT、UPDATE 和 DELETE 语句。不能回退 SELECT 语句，也没必要，也不能回退 CREATE 或 DROP 操作。进行回退时，这些操作也不撤销。

## 控制事务处理

```sql
-- SQL Server
BEGIN TRANSACTION -- 明确事务处理块的开始和结束
... -- 实际代码
COMMIT TRANSACTION

-- MariaDB 和 MySQL
START TRANSACTION
...

-- Oracle
SET TRANSACTION
...

-- PostgreSQL 使用 ANSI SQL 语法
BEGIN
...
```

## ROLLBACK

```sql
DELETE FROM Orders;
ROLLBACK;
```

## COMMIT

一般 SQL 语句都是针对数据库表直接执行和编写的，即隐式提交（implicit commit），提交（写或保存）操作是自动进行的。
在事务处理块中，提交不会隐式进行。有的 DBMS 按隐式提交处理事务端。

```sql
-- SQL Server
BEGIN TRANSACTION -- 利用事务保证完全删除订单
DELETE OrderItems WHERE order_num = 12345
DELETE Orders WHERE order_num = 12345
COMMIT TRANSACTION

-- Oracle
SET TRANSACTION
DELETE OrderItems WHERE order_num = 12345;
DELETE Orders WHERE order_num = 12345;
COMMIT;
```

## 保留点

每个保留点都要取能够标识它的唯一名字。保留点越多越好。

```sql
-- MariaDB、MySQL 和 Oracle
SAVEPOINT delete1;

ROLLBACK TO delete1; -- 回退

-- SQL Server
SAVE TRANSACTION delete1;

ROLLBACK TRANSACTION delete1; -- 回退
```

# 游标 cursor

游标是一个存储在 DBMS 服务器上的数据库查询，它不是一条 SELECT 语句，而是被该语句检索出来的结果集。在存储了游标之后，应用程序可以根据需要滚动或浏览其中的数据。

> SQLite 支持的游标称为步骤（step）

## 常见特性

能标记游标为只读；
能控制可以执行的定向操作（向前、向后、第一、最后、绝对位置和相对位置等）；
能标记某些列为可编辑的，某些不可编辑；
规定范围，使游标对创建它的特定请求（如存储过程）或对所有请求可访问；
指示 DBMS 对检索出的数据进行复制，使数据在游标打开和访问期间不变化。

## 使用游标

使用游标前，必须声明。这个过程实际上没有检索数据，只是定义要使用的 SELECT 语句和游标选项；
一旦声明，就必须打开游标以供使用。这个过程用前面定义的 SELECT 语句把数据实际检索出来；
对于填有数据的游标，根据需要检索各行；
结束游标使用时，必须关闭游标，可能的话，释放游标（有赖于具体 DBMS）。

## 创建游标 DECLARE

```sql
-- DB2、MariaDB、MySQL 和 SQL Server
DECLARE CustCursor CURSOR
FOR
SELECT * FROM Customers
WHERE cust_email IS NULL;

-- Oracle 和 PostgreSQL
DECLARE CURSOR CustCursor
IS
SELECT * FROM Customers
WHERE cust_email IS NULL;
```

## 使用游标 OPEN CURSOR

```sql
OPEN CURSOR CustCursor
```

FETCH 指出要检索哪些行，从何处检索它们以及将它们放于何处（如变量名）。

```sql
-- Oracle
DECLARE TYPE CustCursor IS REF CURSOR
    RETURN Customers%ROWTYPE;
DECLARE CustRecord Customers%ROWTYPE
BEGIN
    OPEN CustCursor;
    LOOP
    FETCH CustCursor INTO CustRecord; -- 自动从第一行开始检索
    EXIT WHEN CustCursor%NOTFOUND; -- 取不出行时退出循环
        ... -- 具体处理代码
    END LOOP;
    CLOSE CustCursor;
END;
```

## 关闭游标 CLOSE

```sql
-- DB2、 Oracle 和 PostgreSQL
CLOSE CustCursor

-- SQL Server
CLOSE CustCursor
DEALLOCATE CURSOR CustCursor
```

# 高级 SQL 特性

## 约束 constraint

约束：管理如何插入或处理数据库数据的规则。
大多数约束是在表定义中定义的。

### 主键

主键是一种特殊的约束，用来保证一列（或一组列）中的值是唯一的，而且永不改动。

表中任意列只要满足以下条件，都可用于主键。
任意两行的主键值都不相同。
每行都具有一个主键值（即列中不允许 NULL 值）。
包含主键值的列从不修改或更新。（大多数 DBMS 不允许这么做）
主键值不能重用。如果从表中删除某一行，其主键值不分配给新行。

```sql
CREATE TABLE Vendors
(
    vend_id CHAR(10) NOT NULL PRIMARY KEY, -- 通过创建定义主键
    vend_name CHAR(50) NOT NULL,
    vend_address CHAR(50) NULL,
    vend_city CHAR(50) NULL,
    vend_state CHAR(5) NULL,
    vend_zip CHAR(10) NULL,
    vend_country CHAR(50) NULL
);

-- 另一种定义主键
ALTER TABLE Vendors
ADD CONSTRAINT PRIMARY KEY (vend_id);
```

> SQLite 不允许使用 ALTER TABLE 定义键，要求在初始的 CREATE TABLE 语句中定义它们。

### 外键

外键是表中的一列，其值必须列在另一表的主键中。

REFERENCES 关键字，表示 cust_id 中的任何值都必须是 Customers 表的 cust_id 中的值。
```sql
CREATE TABLE Orders
(
    order_num INTEGER NOT NULL PRIMARY KEY,
    order_date DATETIME NOT NULL,
    cust_id CHAR(10) NOT NULL REFERENCES Customers(cust_id)
);

-- 相同工作
ALTER TABLE Orders
ADD CONSTRAINT
FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);
```

> 有的 DBMS 支持级联删除（cascading delete）特性。如果启用，该特性在从一个表中删除行时删除所有相关的数据。如，从 Customers 表中删除某个顾客，则任何关联的订单行也会被自动删除。

### 唯一约束

唯一约束用来保证一列（或一组列）中的数据是唯一的。类似于主键，但存在以下重要区别：

- 表可包含多个唯一约束，但每个表只允许一个主键。
- 唯一约束列可包含 NULL 值。
- 唯一约束列可修改或更新。
- 唯一约束列的值可重复使用。
- 与主键不一样，唯一约束不能用来定义外键。

唯一约束既可以用 UNIQUE 关键字在表定义中定义，也可以用单独的 CONSTRAINT 定义。

### 检查约束

检查约束用来保证一列（或一组列）中的数据满足一组指定的条件。

常见用途：
- 检查最小或最大值。如，防止 0 个物品的订单。
- 指定范围。
- 只允许特定的值。

```sql
CREATE TABLE OrderItems
(
    order_num INTEGER NOT NULL,
    order_item INTEGER NOT NULL,
    prod_id CHAR(10) NOT NULL,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    item_price MONEY NOT NULL
);

-- 检查 gender 列只包含 M 或 F
ADD CONSTRAINT CHECK (gender LIKE '[MF]');
```

## 索引 CREATE INDEX

索引用来排序数据以加快搜索和排序操作的速度。

开始创建索引前：
- 索引改善检索操作的性能，但降低了数据插入、修改和删除的性能。在执行这些操作时，DBMS 必须动态地更新索引。
- 索引数据可能要占用大量的存储空间。
- 并非所有数据都适合做索引。
- 索引用于数据过滤和排序。
- 可在索引中定义多个列（如州加上城市）。这样的索引仅在以州加城市的顺序排序时有用。

```sql
-- 不同 DBMS 创建索引的语句变化很大
CREATE INDEX prod_name_ind -- 索引必须唯一命名
ON Products (prod_name);
```

## 触发器

触发器是特殊的存储过程，它在特定的数据库活动发生时自动执行。
触发器可与特定表上的 INSERT、UPDATE 和 DELETE 操作相关联。

与存储过程不一样，触发器与单个的表相关联。与 Orders 表上的 INSERT 操作相关联的触发器只在 Orders 表中插入行时执行。

触发器内的代码具有以下数据的访问权：
- INSERT 操作中的所有新数据；
- UPDATE 操作中的所有新旧数据；
- DELETE 操作中删除的数据。

常见用途：
- 保证数据一致。如，在 INSERT 操作中将所有州名转换为大写。
- 基于某个表的变动在其他表上执行活动。如，每当更新或删除一行时将审计跟踪记录写入某个日志表。
- 进行额外的验证并根据需要回退数据。如，保证某个顾客的可用资金不超限定，如果已经超出，则阻塞插入。
- 计算计算列的值或更新时间戳。

```sql
-- SQL Server
CREATE TRIGGER customer_state
ON Customers
FOR INSERT, UPDATE
AS
UPDATE Customers
SET cust_state = Upper(cust_state)
WHERE Customers.cust_id = inserted.cust_id;

-- Oracle 和 PostgreSQL
CREATE TRIGGER customer_state
AFTER INSERT OR UPDATE
FOR EACH ROW
BEGIN
UPDATE Customers
SET cust_state = Upper(cust_state)
WHERE Customers.cust_id = :OLD.cust_id
END;
```

> 一般来说，约束处理比触发器快，因此应该尽量使用约束。

## 数据库安全

一般说来，需要保护的操作：
- 对数据库管理功能（创建表、更改或删除已存在的表等）的访问；
- 对特定数据库或表的访问；
- 访问的类型（只读、对特定列的访问等）；
- 仅通过视图或存储过程对表进行访问；
- 创建多层次的安全措施，从而允许多种基于登录的访问和控制；
- 限制管理用户账号的能力。

安全性使用 SQL 的 GRANT 和 REVOKE 语句来管理，不过大多数 DBMS 提供了交互式的管理实用程序，在内部使用 GRANT 和 REVOKE。

# 样例表脚本

## Vendors 表

列 说 明
vend_id（主键） 唯一的供应商ID
vend_name 供应商名
vend_address 供应商的地址
vend_city 供应商所在城市
vend_state 供应商所在州
vend_zip 供应商地址邮政编码
vend_country 供应商所在国家

## Products 表

列 说 明
prod_id（主键） 唯一的产品ID
vend_id 产品供应商ID（关联到Vendors表的vend_id）
prod_name 产品名
prod_price 产品价格
prod_desc 产品描述

> 为实施引用完整性，在 vend_id 上定义一个外键，关联到 Vendors 的 vend_id 列。

## Customers 表

列 说 明
cust_id（主键） 唯一的顾客ID
cust_name 顾客名
cust_address 顾客的地址
cust_city 顾客所在城市
cust_state 顾客所在州
cust_zip 顾客地址邮政编码
cust_country 顾客所在国家
cust_contact 顾客的联系名
cust_email 顾客的电子邮件地址

## Orders 表

列 说 明
order_num 唯一的订单号
order_date 订单日期
cust_id 订单顾客ID（关联到Customers表的cust_id）

> cust_id 上定义外键，关联到 Customers 的 cust_id 列。

## OrderItems 表

列 说 明
order_num（主键） 订单号（关联到Orders表的order_num）
order_item（主键） 订单物品号（订单内的顺序）
prod_id 产品ID（关联到Products表的prod_id）
quantity 物品数量
item_price 物品价格

> 关联 order_num 到 Orders 的 order_num 列；
> 关联 prod_id 到 Products的 prod_id 列。

![](/images/five_tables.bmp)

create.txt 包含创建 5 个数据库表（包括定义所有主键和外键约束）的 SQL 语句。
populate.txt 包含用来填充这些表的 SQL INSERT 语句。

```sql
-- Example table creation scripts for MySQL & MariaDB

-- Create Customers table
CREATE TABLE Customers
(
  cust_id      char(10)  NOT NULL ,
  cust_name    char(50)  NOT NULL ,
  cust_address char(50)  NULL ,
  cust_city    char(50)  NULL ,
  cust_state   char(5)   NULL ,
  cust_zip     char(10)  NULL ,
  cust_country char(50)  NULL ,
  cust_contact char(50)  NULL ,
  cust_email   char(255) NULL
);

-- Create OrderItems table
CREATE TABLE OrderItems
(
  order_num  int          NOT NULL ,
  order_item int          NOT NULL ,
  prod_id    char(10)     NOT NULL ,
  quantity   int          NOT NULL ,
  item_price decimal(8,2) NOT NULL
);

-- Create Orders table
CREATE TABLE Orders
(
  order_num  int      NOT NULL ,
  order_date datetime NOT NULL ,
  cust_id    char(10) NOT NULL
);

-- Create Products table
CREATE TABLE Products
(
  prod_id    char(10)      NOT NULL ,
  vend_id    char(10)      NOT NULL ,
  prod_name  char(255)     NOT NULL ,
  prod_price decimal(8,2)  NOT NULL ,
  prod_desc  text          NULL
);

-- Create Vendors table
CREATE TABLE Vendors
(
  vend_id      char(10) NOT NULL ,
  vend_name    char(50) NOT NULL ,
  vend_address char(50) NULL ,
  vend_city    char(50) NULL ,
  vend_state   char(5)  NULL ,
  vend_zip     char(10) NULL ,
  vend_country char(50) NULL
);

-- Define primary keys
ALTER TABLE Customers ADD PRIMARY KEY (cust_id);
ALTER TABLE OrderItems ADD PRIMARY KEY (order_num, order_item);
ALTER TABLE Orders ADD PRIMARY KEY (order_num);
ALTER TABLE Products ADD PRIMARY KEY (prod_id);
ALTER TABLE Vendors ADD PRIMARY KEY (vend_id);

-- Define foreign keys
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (order_num) REFERENCES Orders (order_num);
ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_Products FOREIGN KEY (prod_id) REFERENCES Products (prod_id);
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);
ALTER TABLE Products ADD CONSTRAINT FK_Products_Vendors FOREIGN KEY (vend_id) REFERENCES Vendors (vend_id);


-- Example table population scripts for MySQL & MariaDB

-- Populate Customers table
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000001', 'Village Toys', '200 Maple Lane', 'Detroit', 'MI', '44444', 'USA', 'John Smith', 'sales@villagetoys.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000002', 'Kids Place', '333 South Lake Drive', 'Columbus', 'OH', '43333', 'USA', 'Michelle Green');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000003', 'Fun4All', '1 Sunny Place', 'Muncie', 'IN', '42222', 'USA', 'Jim Jones', 'jjones@fun4all.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email)
VALUES('1000000004', 'Fun4All', '829 Riverside Drive', 'Phoenix', 'AZ', '88888', 'USA', 'Denise L. Stephens', 'dstephens@fun4all.com');
INSERT INTO Customers(cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact)
VALUES('1000000005', 'The Toy Store', '4545 53rd Street', 'Chicago', 'IL', '54545', 'USA', 'Kim Howard');

-- Populate Vendors table
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRS01','Bears R Us','123 Main Street','Bear Town','MI','44444', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('BRE02','Bear Emporium','500 Park Street','Anytown','OH','44333', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('DLL01','Doll House Inc.','555 High Street','Dollsville','CA','99999', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FRB01','Furball Inc.','1000 5th Avenue','New York','NY','11111', 'USA');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('FNG01','Fun and Games','42 Galaxy Road','London', NULL,'N16 6PS', 'England');
INSERT INTO Vendors(vend_id, vend_name, vend_address, vend_city, vend_state, vend_zip, vend_country)
VALUES('JTS01','Jouets et ours','1 Rue Amusement','Paris', NULL,'45678', 'France');

-- Populate Products table
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR01', 'BRS01', '8 inch teddy bear', 5.99, '8 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR02', 'BRS01', '12 inch teddy bear', 8.99, '12 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BR03', 'BRS01', '18 inch teddy bear', 11.99, '18 inch teddy bear, comes with cap and jacket');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG01', 'DLL01', 'Fish bean bag toy', 3.49, 'Fish bean bag toy, complete with bean bag worms with which to feed it');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG02', 'DLL01', 'Bird bean bag toy', 3.49, 'Bird bean bag toy, eggs are not included');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('BNBG03', 'DLL01', 'Rabbit bean bag toy', 3.49, 'Rabbit bean bag toy, comes with bean bag carrots');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RGAN01', 'DLL01', 'Raggedy Ann', 4.99, '18 inch Raggedy Ann doll');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RYL01', 'FNG01', 'King doll', 9.49, '12 inch king doll with royal garments and crown');
INSERT INTO Products(prod_id, vend_id, prod_name, prod_price, prod_desc)
VALUES('RYL02', 'FNG01', 'Queen doll', 9.49, '12 inch queen doll with royal garments and crown');

-- Populate Orders table
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20005, '2020-05-01', '1000000001');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20006, '2020-01-12', '1000000003');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20007, '2020-01-30', '1000000004');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20008, '2020-02-03', '1000000005');
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20009, '2020-02-08', '1000000001');

-- Populate OrderItems table
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20005, 1, 'BR01', 100, 5.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20005, 2, 'BR03', 100, 10.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 1, 'BR01', 20, 5.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 2, 'BR02', 10, 8.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20006, 3, 'BR03', 10, 11.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 1, 'BR03', 50, 11.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 2, 'BNBG01', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 3, 'BNBG02', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 4, 'BNBG03', 100, 2.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20007, 5, 'RGAN01', 50, 4.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 1, 'RGAN01', 5, 4.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 2, 'BR03', 5, 11.99);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 3, 'BNBG01', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 4, 'BNBG02', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20008, 5, 'BNBG03', 10, 3.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 1, 'BNBG01', 250, 2.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 2, 'BNBG02', 250, 2.49);
INSERT INTO OrderItems(order_num, order_item, prod_id, quantity, item_price)
VALUES(20009, 3, 'BNBG03', 250, 2.49);
```

# SQL 语句语法

## 约定

| 符号指出多选择之一；
[] 包含关键字或子句是可选的。

## ALTER TABLE

更新已存在表结构。

```sql
ALTER TABLE tablename
(
    ADD|DROP    column    datatype    [NULL|NOT NULL]    [CONSTRAINTS],
    ADD|DROP    column    datatype    [NULL|NOT NULL]    [CONSTRAINTS],
    ...
);
```

## COMMIT

将事务写入数据库。

```sql
COMMIT [TRANSACTION]
```

## CREATE INDEX

再一个或多个列上创建索引。

```sql
CREATE INDEX indexname
ON tablename (column, ...);
```

## CREATE PROCEDURE

创建存储过程。Oracle 语法不同。

```sql
CREATE PROCEDURE procedurename [parameters] [options]
AS
SQL statement;
```

## CREATE TABLE

```sql
CREATE TABLE tablename
(
    column    datatype    [NULL|NOT NULL]    [CONSTRAINTS],
    column    datatype    [NULL|NOT NULL]    [CONSTRAINTS],
    ...
);
```

## CREATE VIEW

创建一个或多个表上的视图。

```sql
CREATE VIEW viewname AS
SELECT columns, ...
FROM tables, ...
[WHERE ...]
[GROUP BY ...]
[HAVING ...];
```

## DELETE

从表中删除一行或多行。

```sql
DELETE FROM tablename
[WHERE ...];
```

## DROP

永久删除数据库对象（表、视图、索引等）。

```sql
DROP INDEX|PROCEDURE|TABLE|VIEW indexname|procedure|tablename|viewname;
```

## INSERT

为表添加一行。

```sql
INSERT INTO tablename [(columns, ...)]
VALUES(values, ...);
```

## INSERT SELECT

将 SELECT 的结果插入到一个表。

```sql
INSERT INTO tablename [(columns, ...)]
SELECT columns, ... FROM tablename, ...
[WHERE ...];
```

## ROLLBACK

撤销一个事务块。

```sql
ROLLBACK [TO savepointname];
或
ROLLBACK TRANSACTION;
```

## SELECT

从一个或多个表（视图）中检索数据。

```sql
SELECT columnname, ...
FROM tablename, ...
[WHERE ...]
[UNION ...]
[GROUP BY ...]
[HAVING ...]
[ORDER BY ...];
```

## UPDATE

更新表中的一行或多行。

```sql
UPDATE tablename
SET columnname = value, ...
[WHERE ...];
```

# SQL 数据类型

## 字符串（单引号内）

| 数据类型                             | 说 明                                                                     |
| ------------------------------------ | ------------------------------------------------------------------------- |
| CHAR                                 | 1～ 255 个字符的定长字符串。它的长度必须在创建时规定                      |
| NCHAR                                | CHAR的特殊形式，用来支持多字节或 Unicode 字符（此类型的不同实现变化很大） |
| NVARCHAR                             | TEXT 的特殊形式，用来支持多字节或 Unicode 字符                            |
| TEXT（也称为LONG、 MEMO 或 VARCHAR） | 变长文本                                                                  |

定长字符串的长度在创建表时指定，空余字符用空格填充，或根据需要补为 NULL。

## 数值（不用引号）

| 数据类型             | 说 明                                             |
| -------------------- | ------------------------------------------------- |
| BIT                  | 单个二进制位值，或者为0或者为1，主要用于开/关标志 |
| DECIMAL（或NUMERIC） | 定点或精度可变的浮点值                            |
| FLOAT（或NUMBER）    | 浮点值                                            |
| INT（或INTEGER）     | 4 字节整数值，支持 −2147483648～2147483647        |
| REAL                 | 4 字节浮点值                                      |
| SMALLINT             | 2 字节整数值，支持−32768～32767                   |
| TINYINT              | 1 字节整数值，支持0～255                          |

### 货币数据类型

MONEY 或 CURRENCY，有特定取值范围的 DECIMAL 数据类型。

## 日期和时间

| 数据类型                | 说 明                              |
| ----------------------- | ---------------------------------- |
| DATE                    | 日期值                             |
| DATETIME（或TIMESTAMP） | 日期时间值                         |
| SMALLDATETIME           | 日期时间值，精确到分（无秒或毫秒） |
| TIME                    | 时间值                             |

### ODBC 日期

该格式对每种数据库都起作用。

日期 `{d '2020-12-30'}`
时间 `{t '12:30:59'}`
日期时间 `{ts '2020-12-30 12:30:59'}`

## 二进制

兼容性最差，最少使用，可包含任何数据。

| 数据类型                | 说 明                                                                 |
| ----------------------- | --------------------------------------------------------------------- |
| BINARY                  | 定长二进制数据（最大长度从255 B到8000 B，有赖于具体的实现）           |
| LONG RAW                | 变长二进制数据，最长2 GB                                              |
| RAW（某些实现为BINARY） | 定长二进制数据，最多255 B                                             |
| VARBINARY               | 变长二进制数据（最大长度一般在255 B到8000 B间变化，依赖于具体的实现） |

# SQL 关键字

<details><summary>保留字</summary>

```sql
ABORT
ABSOLUTE
ACTION
ACTIVE
ADD
AFTER
ALL
ALLOCATE
ALTER
ANALYZE
AND
ANY
ARE
AS
ASC
ASCENDING
ASSERTION
AT
AUTHORIZATION
AUTO
AUTO-INCREMENT
AUTOINC
AVG
BACKUP
BEFORE
BEGIN
BETWEEN
BIGINT
BINARY
BIT
BLOB
BOOLEAN
BOTH
BREAK
BROWSE
BULK
BY
BYTES
CACHE
CALL
CASCADE
CASCADED
CASE
CAST
CATALOG
CHANGE
CHAR
CHARACTER
CHARACTER_LENGTH
CHECK
CHECKPOINT
CLOSE
CLUSTER
CLUSTERED
COALESCE
COLLATE
COLUMN
COLUMNS
COMMENT
COMMIT
COMMITTED
COMPUTE
COMPUTED
CONDITIONAL
CONFIRM
CONNECT
CONNECTION
CONSTRAINT
CONSTRAINTS
CONTAINING
CONTAINS
CONTAINSTABLE
CONTINUE
CONTROLROW
CONVERT
COPY
COUNT
CREATE
CROSS
CSTRING
CUBE
CURRENT
CURRENT_DATE
CURRENT_TIME
CURRENT_TIMESTAMP
CURRENT_USER
CURSOR
DATABASE
DATABASES
DATE
DATETIME
DAY
DBCC
DEALLOCATE
DEBUG
DEC
DECIMAL
DECLARE
DEFAULT
DELETE
DENY
DESC
DESCENDING
DESCRIBE
DISCONNECT
DISK
DISTINCT
DISTRIBUTED
DIV
DO
DOMAIN
DOUBLE
DROP
DUMMY
DUMP
ELSE
ELSEIF
ENCLOSED
END
ERRLVL
ERROREXIT
ESCAPE
ESCAPED
EXCEPT
EXCEPTION
EXEC
EXECUTE
EXISTS
EXIT
EXPLAIN
EXTEND
EXTERNAL
EXTRACT
FALSE
FETCH
FIELD
FIELDS
FILE
FILLFACTOR
FILTER
FLOAT
FLOPPY
FOR
FORCE
FOREIGN
FOUND
FREETEXT
FREETEXTTABLE
FROM
FULL
FUNCTION
GENERATOR
GET
GLOBAL
GO
GOTO
GRANT
GROUP
HAVING
HOLDLOCK
HOUR
IDENTITY
IF
IN
INACTIVE
INDEX
INDICATOR
INFILE
INNER
INOUT
INPUT
INSENSITIVE
INSERT
INT
INTEGER
INTERSECT
INTERVAL
INTO
IS
ISOLATION
JOIN
KEY
KILL
LANGUAGE
LAST
LEADING
LEFT
LENGTH
LEVEL
LIKE
LIMIT
LINENO
LINES
LISTEN
LOAD
LOCAL
LOCK
LOGFILE
LONG
LOWER
MANUAL
MATCH
MAX
MERGE
MESSAGE
MIN
MINUTE
MIRROREXIT
MODULE
MONEY
MONTH
MOVE
NAMES
NATIONAL
NATURAL
NCHAR
NEXT
NEW
NO
NOCHECK
NONCLUSTERED
NONE
NOT
NULL
NULLIF
NUMERIC
OF
OFF
OFFSET
OFFSETS
ON
ONCE
ONLY
OPEN
OPTION
OR
ORDER
OUTER
OUTPUT
OVER
OVERFLOW
OVERLAPS
PAD
PAGE
PAGES
PARAMETER
PARTIAL
PASSWORD
PERCENT
PERM
PERMANENT
PIPE
PLAN
POSITION
PRECISION
PREPARE
PRIMARY
PRINT
PRIOR
PRIVILEGES
PROC
PROCEDURE
PROCESSEXIT
PROTECTED
PUBLIC
PURGE
RAISERROR
READ
READTEXT
REAL
REFERENCES
REGEXP
RELATIVE
RENAME
REPEAT
REPLACE
REPLICATION
REQUIRE
RESERV
RESERVING
RESET
RESTORE
RESTRICT
RETAIN
RETURN
RETURNS
REVOKE
RIGHT
ROLLBACK
ROLLUP
ROWCOUNT
RULE
SAVE
SAVEPOINT
SCHEMA
SECOND
SECTION
SEGMENT
SELECT
SENSITIVE
SEPARATOR
SEQUENCE
SESSION_USER
SET
SETUSER
SHADOW
SHARED
SHOW
SHUTDOWN
SINGULAR
SIZE
SMALLINT
SNAPSHOT
SOME
SORT
SPACE
SQL
SQLCODE
SQLERROR
STABILITY
STARTING
STARTS
STATISTICS
SUBSTRING
SUM
SUSPEND
TABLE
TABLES
TEMP
TEMPORARY
TEXT
TEXTSIZE
THEN
TIME
TIMESTAMP
TO
TOP
TRAILING
TRAN
TRANSACTION
TRANSLATE
TRIGGER
TRIM
TRUE
TRUNCATE
TYPE
UNCOMMITTED
UNION
UNIQUE
UNTIL
UPDATE
UPDATETEXT
UPPER
USAGE
USE
USER
USING
VALUE
VALUES
VARCHAR
VARIABLE
VARYING
VERBOSE
VIEW
VOLUME
WAIT
WAITFOR
WHEN
WHERE
WHILE
WITH
WORK
WRITE
WRITETEXT
XOR
YEAR
ZONE
```

</details>

# Refer

《SQL必知必会（第5版）》
《MySQL必知必会（第1版）》

# PS

数据库除了语法全大写有点看不习惯，整体语句还是比较简单的，SQL 学完后就是针对性学习各类 DBMS 了。