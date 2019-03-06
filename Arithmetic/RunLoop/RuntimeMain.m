//
//  RuntimeMain.m
//  Arithmetic
//
//  Created by 谢立颖 on 2019/3/5.
//  Copyright © 2019 xiely. All rights reserved.
//

#import "RuntimeMain.h"
#import <objc/runtime.h>

@implementation RuntimeMain

//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
////    [RuntimeMain testClassMethod];
//    [self forwardingTargetForSelector:sel];
//    return YES;
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//    return [super resolveClassMethod:sel];
//}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    
    
    return [super forwardingTargetForSelector:aSelector];
}

- (void)execute
{
//    class_getMethodImplementation([RuntimeMain class], @selector(execute));
    
}


@end
