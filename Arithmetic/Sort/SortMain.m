//
//  SortMain.m
//  Arithmetic
//
//  Created by 谢立颖 on 2019/2/11.
//  Copyright © 2019 xiely. All rights reserved.
//

#import "SortMain.h"

BOOL needLogNumbers = NO;

@interface SortMain ()

@property(nonatomic,strong) NSMutableArray *publicArray;
@property(nonatomic,strong) NSOperationQueue *queue;

@end

@implementation SortMain

- (void)execute
{
//    self.publicArray = [self generalArrayWithCount:500];
    
    // 并发执行排序操作
//
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    __weak typeof(self) ws = self;
//    dispatch_async(queue, ^{
//        [ws selectionSort];
//    });
//    dispatch_async(queue, ^{
//        [ws insertionSort];
//    });
//    dispatch_async(queue, ^{
//        [self insertionSortDichotomy];
//    });
//    dispatch_async(queue, ^{
//        [self shellSort];
//    });
//    dispatch_async(queue, ^{
//        [self mergeSortRecursion];
//    });
//    dispatch_async(queue, ^{
//        [self mergeSortIteration];
//    });
//    dispatch_async(queue, ^{
//        [self quickSort];
//    });
    

    self.queue = [[NSOperationQueue alloc] init];
    self.queue.maxConcurrentOperationCount = 8;
    
    __weak typeof(self) ws = self;
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws selectionSort];
        CFRelease(currentRunLoop);
    }];
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws insertionSort];
    }];
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws insertionSortDichotomy];
    }];
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws shellSort];
    }];
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws mergeSortRecursion];
    }];
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws mergeSortIteration];
    }];
    [self.queue addOperationWithBlock:^{
        CFRunLoopRef currentRunLoop = CFRunLoopGetCurrent();
        NSLog(@"current RunLoop: %@", currentRunLoop);
        [ws quickSort];
    }];
    
//    NSInvocationOperation *invo0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(selectionSort) object:nil];
//    NSInvocationOperation *invo1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(insertionSort) object:nil];
//
//    [invo0 addDependency:invo1];
//
//    [self.queue addOperation:invo0];
//    [self.queue addOperation:invo1];
    
    
    [NSThread sleepForTimeInterval:9999999999];

//    [self bubbleSort];
//    [self cocktailSort];
//    [self selectionSort];
//    [self insertionSort];
//    [self insertionSortDichotomy];
//    [self shellSort];
//    [self mergeSortRecursion];
//    [self mergeSortIteration];
//    [self quickSort];
}

/**
 随机生成一个数值范围为 0 ~ 10000 整数的随机数组

 @param count 要生成的数组大小
 @return 数组
 */
- (NSMutableArray *)generalArrayWithCount:(NSInteger)count
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (int i = 0; i < count; i++) {
        int x = arc4random() % 1000;
        [temp addObject:[NSNumber numberWithInt:x]];
    }
    
    return temp;
}

#pragma mark - Public
/**
 交换元素
 */
- (void)swapWithArray:(NSMutableArray *)arr firstIdx:(NSInteger)firstIdx secondIdx:(NSInteger)secondIdx
{
    NSNumber *temp = arr[firstIdx];
    [arr replaceObjectAtIndex:firstIdx withObject:arr[secondIdx]];
    [arr replaceObjectAtIndex:secondIdx withObject:temp];
}

#pragma mark - 冒泡排序
/**
 冒泡排序
 */
- (void)bubbleSort
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
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
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"冒泡排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}


/**
 鸡尾酒排序
 */
- (void)cocktailSort
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
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
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"鸡尾酒排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}

#pragma mark - 选择排序
/**
 选择排序
 */
- (void)selectionSort
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
//    NSMutableArray *originArr = [[NSMutableArray alloc] initWithArray:@[@(4), @(3), @(5), @(8), @(6), @(1), @(7), @(2)]];
    
    // i 的取值范围要减 1
    for (int i = 0; i < originArr.count - 1; i++) {
        NSInteger min = i;
        
        // 关键是这个 for 循环的 j，注意 j 的取值范围
        for (int j = i + 1; j < originArr.count; j++) {
            if ([originArr[j] integerValue] < [originArr[min] integerValue]) {
                // 这里找出最小的数
                min = j;
            }
        }
        
        if (min != i) {
            [self swapWithArray:originArr firstIdx:i secondIdx:min];
        }
//        NSLog(@"%@", originArr);
    }
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"选择排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}

#pragma mark - 插入排序
/**
 插入排序
 */
- (void)insertionSort
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
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
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"插入排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}


/**
 二分法插入排序
 */
- (void)insertionSortDichotomy
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
//    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
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
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"二分法插入排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}


/**
 希尔排序
 */
- (void)shellSort
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
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
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"希尔排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}


#pragma mark - 归并排序

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

- (void)mergeSortRecursionWithArr:(NSMutableArray *)arr left:(NSInteger)left right:(NSInteger)right
{
    if (left == right) return;
    
    NSInteger mid = (left + right) / 2;
    
    [self mergeSortRecursionWithArr:arr left:left right:mid];
    [self mergeSortRecursionWithArr:arr left:mid + 1 right:right];
    [self mergeWithArr:arr left:left mid:mid right:right];
}


/**
 递归实现的归并排序（自顶向下）
 */
- (void)mergeSortRecursion
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
    [self mergeSortRecursionWithArr:originArr left:0 right:originArr.count - 1];
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"递归实现的归并排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}

/**
 非递归（迭代）实现的归并排序
 */
- (void)mergeSortIteration
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
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
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"迭代实现的归并排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}


#pragma mark - 快速排序

- (NSInteger)partitionWithArray:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right
{
    NSInteger pivot = [array[right] integerValue];
    NSInteger tail = left - 1;
    
    for (NSInteger i = left; i < right; i++) {
        if ([array[i] integerValue] <= pivot) {
            [self swapWithArray:array firstIdx:++tail secondIdx:i];
        }
    }
    
    [self swapWithArray:array firstIdx:tail + 1 secondIdx:right];
    
    return tail + 1;
}

- (void)quickSortWithArray:(NSMutableArray *)array left:(NSInteger)left right:(NSInteger)right
{
    if (left >= right) return;
    
    NSInteger pivot_index = [self partitionWithArray:array left:left right:right];
    
    [self quickSortWithArray:array left:left right:pivot_index - 1];
    [self quickSortWithArray:array left:pivot_index + 1 right:right];
}


/**
 快速排序
 */
- (void)quickSort
{
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    
    NSMutableArray *originArr = [self generalArrayWithCount:10000];
    
    [self quickSortWithArray:originArr left:0 right:originArr.count - 1];
    
    CFAbsoluteTime linkTime = CFAbsoluteTimeGetCurrent() - startTime;
    
    NSLog(@"快速排序 -- %lf", linkTime);
    
    if (needLogNumbers) {
        for (NSNumber *num in originArr) {
            NSLog(@"%ld\n", num.integerValue);
        }
    }
}

@end
