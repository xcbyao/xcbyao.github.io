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
SELECT prod_name -- 注释，很多都支持
FROM Products;
```

```sql
# 注释，有些不支持
SELECT prod_name
FROM Products;
```

```sql
/* 多行注释 */
SELECT prod_name
FROM Products;
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

# 联结（join）表

**关系表**的设计就是要把信息分解成多个表，一类数据一个表。各表通过某些共同的值互相关联（所以才叫关系数据库）。

**可伸缩（scale）**能够适应不断增加的工作量而不失败。设计良好的数据库或应用程序称为可伸缩性好（scale well）


# 高级联结

## 表别名

## 不同类型的联结

## 带聚集函数的联结

## 联结条件

# 组合查询

# 插入数据

## 从一个表复制到另一个表

# 更新数据

# 删除数据

## 更新删除指导原则

# 表

## 创建表

## 更新表

## 删除表

## 重命名表

# 视图

# 存储过程

# 事务处理

# 游标

# 高级 SQL 特性

## 约束

## 索引

## 触发器

## 数据库安全


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
README 文件，它提供了针对特定 DBMS 的具体设置和安装步骤。

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


# PS

