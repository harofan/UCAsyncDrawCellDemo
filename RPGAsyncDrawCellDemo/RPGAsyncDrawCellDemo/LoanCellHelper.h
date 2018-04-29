//
//  LoanCellHelper.h
//  UCPlan
//
//  Created by 范杨 on 2018/4/28.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoanCellHelper : NSObject

+ (instancetype)shareHelper;
+ (void)destoryHelper;

- (dispatch_queue_t)getNoBusyQueue;
@end
