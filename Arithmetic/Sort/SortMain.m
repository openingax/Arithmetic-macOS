//
//  SortMain.m
//  Arithmetic
//
//  Created by 谢立颖 on 2019/2/11.
//  Copyright © 2019 xiely. All rights reserved.
//

#import "SortMain.h"

@implementation SortMain

- (void)execute
{
//    [self bubbleSort];
//    [self cocktailSort];
//    [self selectionSort];
//    [self insertionSort];
    [self insertionSortDichotomy];
//    [self shellSort];
//    [self mergeSortRecursion];
//    [self mergeSortIteration];
}

/**
 交换元素
 */
- (void)swapWithArray:(NSMutableArray *)arr firstIdx:(NSInteger)firstIdx secondIdx:(NSInteger)secondIdx
{
    NSNumber *temp = arr[firstIdx];
    [arr replaceObjectAtIndex:firstIdx withObject:arr[secondIdx]];
    [arr replaceObjectAtIndex:secondIdx withObject:temp];
}

/**
 冒泡算法
 */
- (void)bubbleSort
{
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:@[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)]];
    
    for (int i = 0; i < originArr.count - 1; i++) {
        for (int j = 0; j < originArr.count - 1 - i; j++) {
            NSInteger firstNum = [originArr[j] integerValue];
            NSInteger secondNum = [originArr[j+1] integerValue];
            
            if (firstNum > secondNum) {
                // 交换
                [self swapWithArray:originArr firstIdx:j secondIdx:j+1];
            }
        }
    }
    
    NSLog(@"冒泡排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}


/**
 鸡尾酒排序
 */
- (void)cocktailSort
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    //    NSArray *array = @[@(2), @(3), @(4), @(1)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    NSInteger left = 0;
    NSInteger right = originArr.count - 1;
    
    while (left < right) {
        
        // 把左边最大的数移到右边
        for (NSInteger i = left; i < right; i++) {
            if ([originArr[i] integerValue] > [originArr[i+1] integerValue]) {
                [self swapWithArray:originArr firstIdx:i secondIdx:i+1];
            }
        }
        
        right --;
        
        // 把右边最小的数移到左边
        for (NSInteger i = right; i > left; i--) {
            if ([originArr[i-1] integerValue] > [originArr[i] integerValue]) {
                [self swapWithArray:originArr firstIdx:i-1 secondIdx:i];
            }
        }
        
        left ++;
    }
    
    NSLog(@"鸡尾酒排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}


/**
 选择排序
 */
- (void)selectionSort
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    for (int i = 0; i < originArr.count - 1; i++) {
        NSInteger min = i;
        
        // 关键是这个 for 循环的 j
        for (int j = i + 1; j < originArr.count; j++) {
            if ([originArr[j] integerValue] < [originArr[min] integerValue]) {
                min = j;
            }
        }
        
        if (min != i) {
            [self swapWithArray:originArr firstIdx:i secondIdx:min];
        }
    }
    
    NSLog(@"选择排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}


/**
 插入排序
 */
- (void)insertionSort
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    for (int i = 1; i < originArr.count; i++) {
        // 1、先抽出一张牌
        NSInteger get = [originArr[i] integerValue];
        
        // 2、获取已抽出牌左边的位置
        int j = i - 1;
        
        // 3、用抽出的牌与它左边的牌一一对比，如果抽出的牌小于左边的牌，则把左边的牌往右移动一位
        while (j >= 0 && [originArr[j] integerValue] > get) {
            originArr[j+1] = originArr[j];
            j--;
        }
        // 4、第3步走完后，说明找到了抽出的牌的位置，把这张牌放进 j+1 的位置
        originArr[j+1] = [NSNumber numberWithInteger:get];
    }
    
    NSLog(@"插入排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}


/**
 二分法插入排序
 */
- (void)insertionSortDichotomy
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    for (int i = 1; i < originArr.count; i++) {
        // 1、先抽出一张牌
        NSInteger get = [originArr[i] integerValue];
        
        // 2、定义左边边界与右边边界
        int left = 0;
        int right = i - 1;
        
        // 3、当左边小于右边时
        while (left <= right) {
            int mid = (left + right) / 2;
            if ([originArr[mid] integerValue] > get) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        
        for (int j = i - 1; j >= left; j--) {
            originArr[j+1] = originArr[j];
        }
        
        originArr[left] = [NSNumber numberWithInteger:get];
    }
    
    NSLog(@"二分法插入排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}


/**
 希尔排序
 */
- (void)shellSort
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    int h = 0;
    
    // 生成初始增量
    while (h <= originArr.count) {
        h = 3 * h + 1;
    }
    
    while (h >= 1) {
        for (int i = h; i < originArr.count; i++) {
            int j = i - h;
            NSInteger get = [originArr[i] integerValue];
            
            while (j >= 0 && [originArr[j] integerValue] > get) {
                originArr[j + h] = originArr[j];
                j = j - h;
            }
            
            originArr[j + h] = [NSNumber numberWithInteger:get];
        }
        
        h = (h - 1) / 3;        // 递减增量
    }
    
    NSLog(@"希尔排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}


- (void)mergeWithArr:(NSMutableArray *)array left:(NSInteger)left mid:(NSInteger)mid right:(NSInteger)right
{
    NSInteger len = right - left + 1;
    NSMutableArray *tempArr = [[NSMutableArray alloc] init];
    NSInteger index = 0;
    NSInteger i = left;
    NSInteger j = mid + 1;
    
    while (i <= mid && j <= right) {
        tempArr[index ++] = [array[i] integerValue] <= [array[j] integerValue] ? array[i ++] : array[j ++];
    }
    
    while (i <= mid) {
        tempArr[index ++] = array[i++];
    }
    
    while (j <= right) {
        tempArr[index ++] = array[j++];
    }
    
    for (int k = 0; k < len; k++) {
        array[left ++] = tempArr[k];
    }
}


/**
 递归实现的归并排序（自顶向下）
 */
- (void)mergeSortRecursion
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    [self mergeSortRecursionWithArr:originArr left:0 right:originArr.count - 1];
    
    NSLog(@"递归实现的归并排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}

- (void)mergeSortRecursionWithArr:(NSMutableArray *)arr left:(NSInteger)left right:(NSInteger)right
{
    if (left == right) return;
    
    NSInteger mid = (left + right) / 2;
    
    [self mergeSortRecursionWithArr:arr left:left right:mid];
    [self mergeSortRecursionWithArr:arr left:mid + 1 right:right];
    [self mergeWithArr:arr left:left mid:mid right:right];
}


/**
 非递归（迭代）实现的归并排序
 */
- (void)mergeSortIteration
{
    NSArray *array = @[@(6), @(5), @(3), @(1), @(8), @(7), @(2), @(4)];
    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:array];
    
    int left, mid, right;
    for (int i = 1; i < originArr.count; i *= 2) {
        left = 0;
        while (left + i < originArr.count) {
            mid = left + i - 1;
            right = mid + i < originArr.count ? mid + i : (int)originArr.count - 1;
            [self mergeWithArr:originArr left:left mid:mid right:right];
            left = right + 1;
        }
    }
    
    NSLog(@"迭代实现的归并排序");
    for (NSNumber *num in originArr) {
        NSLog(@"%ld\n", num.integerValue);
    }
}

@end
