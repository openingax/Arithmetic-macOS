//
//  GCDMain.m
//  Arithmetic
//
//  Created by 谢立颖 on 2019/3/6.
//  Copyright © 2019 xiely. All rights reserved.
//

#import "GCDMain.h"

@implementation GCDMain

- (void)execute
{
    // 计算 NSString 字符个数
    NSString *str = @"计算 NSString 字符个数 ^_^ 😬😀😁😂 ^6^";
    
    NSLog(@"%ld", [self lengthOfString:str]);
    
//    [NSThread detachNewThreadSelector:@selector(executeInvocationOperation) toTarget:self withObject:nil];
    [NSThread detachNewThreadWithBlock:^{
        NSLog(@"%@ detach block operation", [NSThread currentThread]);
    }];
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@ block operation", [NSThread currentThread]);
    }];
    [blockOperation start];
    NSLog(@"%@ end", [NSThread currentThread]);
}

- (void)executeInvocationOperation
{
    NSInvocationOperation *invoOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invoOperationAction:) object:nil];
    [invoOperation start];
}

- (void)invoOperationAction:(NSInvocationOperation *)operation
{
    NSLog(@"invocation operation");
}


/**
 把传入的字符串提取出一个个单独的字符，所有字符按顺序放入字符数组里

 @param str 字符串
 @return 字符数组
 */
- (NSArray <NSString *> *)subStringWithStr:(NSString *)str
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSRange range;
    for (int i=0; i < str.length; i+=range.length) {
        range = [str rangeOfComposedCharacterSequenceAtIndex:i];
        NSAttributedString *s = [attrStr attributedSubstringFromRange:range];
        [arr addObject:s.string];
    }
    return arr;
}

- (NSUInteger)lengthOfString:(NSString *)str
{
    NSUInteger length = 0;
    NSRange range;
    for (int i=0; i < str.length; i+=range.length) {
        range = [str rangeOfComposedCharacterSequenceAtIndex:i];
        length += 1;
    }
    
    return length;
}

@end
