//
//  MRCMain.m
//  Arithmetic
//
//  Created by 谢立颖 on 2019/3/5.
//  Copyright © 2019 xiely. All rights reserved.
//

#import "MRCMain.h"
#import "Person.h"

@implementation MRCMain

+ (void)load
{
    
}

+ (void)initialize
{
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    [MRCMain testClassMethod];
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    return NO;
}

- (void)execute
{
    Person __unsafe_unretained *unretainedPerson;
    if (1) {
        Person *p = [[Person alloc] init];
        unretainedPerson = p;
//        NSLog(@"%@", unretainedPerson);
    }
//    NSLog(@"%@", unretainedPerson);
}

- (void)dealloc
{
    // ARC 只能处理 OC 对象，非 OC 对象需要手动释放
}

@end
