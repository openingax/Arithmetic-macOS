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
    [self insertionSort];
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
        NSInteger get = [originArr[i] integerValue];
        
        // !!
        int j = i - 1;
        
        // !!! 把大于 get 的元素右移
        while (j >= 0 && [originArr[j] integerValue] > get) {
            originArr[j+1] = originArr[j];
            j--;
        }
        // !!!! 把 get 元素插入到 j+1 的位置
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
    
}

@end
