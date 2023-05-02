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


## 子句操作符


# 高级数据过滤

## 组成 WHERE 子句

## IN 操作符

## NOT 操作符

# 通配符过滤

## LIKE 操作符


## 通配符技巧

# 创建计算字段

## 计算字段

## 拼接字段

## 执行算术计算

# 函数

# 汇总数据

## 聚集函数

## 聚集不同值

## 组合聚集函数

# 分组

## 数据分组

## 创建分组

## 过滤分组

## 分组和排序

## SELECT 子句顺序

# 子查询

## 子查询过滤

## 作为计算字段使用

# 联结表

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

