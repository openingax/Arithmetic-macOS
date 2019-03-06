//
//  main.m
//  Arithmetic
//
//  Created by 谢立颖 on 2019/2/11.
//  Copyright © 2019 xiely. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RunLoop/RunLoopMain.h"
#import "Sort/SortMain.h"
#import "MRCMain.h"
#import "RunLoop/RuntimeMain.h"
#import "RunLoop/GCDMain.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        RunLoopMain *runLoopMain = [[RunLoopMain alloc] init];
//        [runLoopMain execute];
        
        SortMain *sortMain = [[SortMain alloc] init];
        [sortMain execute];
        
//        MRCMain *mrcMain = [[MRCMain alloc] init];
//        [mrcMain execute];
//        
//        RuntimeMain *runtimeMain = [[RuntimeMain alloc] init];
//        [runtimeMain execute];
////        [runtimeMain testMethod];
//        
//        GCDMain *gcdMain = [[GCDMain alloc] init];
//        [gcdMain execute];
    }
    return 0;
}
