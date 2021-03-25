---
title: Data structure & algorithm Summary
date: 2021-02-25 10:13:10
categories: Algorithm
---
## Perface
> 知识有没有用，主要是看你要实现的目标是什么。

编程的书看了不少，一直缺乏实战提高，正式开启算法训练，提高编程能力。


## Quicksort
```C
/*
快速排序算法
核心：找到基准值的位置。
将小于基准值的元素放在基准值的前面，大于的元素放在后面。这一步通常被叫做 partition 操作，中文直译就是分割操作
partition 就是空出一个位置，反复地前后调换元素。
利用双指针进行前后迭代。前后两个指针，同时移动，后面小于基准值的放前面，前面大于基准值的放后面。
30 13 52 10 24 41 29 43
*/

#include <stdio.h>
#include <stdlib.h>
#define MAX 10000
#define DEBUG 1
void output(int, int, int);

// arr    : 用来存储待排序的元素
// n      : 代表元素数量
// output : 输出过程中的调试信息
// DEBUG  : 调试信息开关

int arr[MAX], n;
void start() {
    printf("请输入元素数量：");
    scanf("%d", &n);
    printf("请输入 %d 个整数：\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", arr + i);
    }
    while (getchar() != '\n');
    return;
}

// 快速排序：对 arr 中 l 到 r 位进行排序
// l   : 待排序区间起始坐标
// r   : 待排序区间结束坐标

void sort(int* arr, int l, int r) {
    // 递归的边界条件是区间中只有一个元素
    // x : 记录从前向后扫描的位置
    // y : 记录从后向前扫描的位置
    // z : 基准值，选择待排序区间的第一个元素
    // while 循环中是 partition 过程
    // 每一轮，先从后向前扫，再从前向后扫
    if (l >= r) return;
    int x = l, y = r, z = arr[l];
    while (x < y) {
        while (x < y && arr[y] >= z) --y;
        if (x < y) arr[x++] = arr[y];
        while (x < y && arr[x] <= z) ++x;
        if (x < y) arr[y--] = arr[x];
    }
    // 将基准值 z 放入其正确位置数组的 x 位
    // 其实此时 x==y，所以 arr[y] = z 也行
    // 再分别对左右区间，进行快速排序
    arr[x] = z;
    output(l, x, r);
    sort(arr, l, x - 1);
    sort(arr, x + 1, r);
    return;
}

void output(int l, int x, int r) {
    if (!DEBUG) return;
    printf("\n待排序区间范围 [%d, %d]\n", l, r);
    printf("基准值：%d\n", arr[x]);

    char str[30];
    int cnt = 2; // 预留 '[ ' 的空间
    for (int i = 0; i < x; i++) {
        cnt += sprintf(str, "%d ", arr[i]); //spritnf 返回了本次函数调用最终打印到字符缓冲区中的字符数目
    }
    for (int i = 0; i < l; i++) printf("%d ", arr[i]);
    printf("[ ");
    for (int i = l; i <= r; i++) {
        printf("%d ", arr[i]);
    }
    printf("] ");
    for (int i = r + 1; i < n; i++) printf("%d ", arr[i]);
    printf("\n");
    for (int i = 0; i < cnt; i++) printf(" ");
    printf("^\n");
    printf("按回车继续...");
    while (getchar() != '\n');
    return;
}

int main() {
    start();
    sort(arr, 0, n - 1);
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    return 0;
}
```

## 







## Reference
*《常用算法 25 讲》*
*《数据结构与算法之美》*