//
//  LoanCell.h
//  UCPlan
//
//  Created by 范杨 on 2018/4/26.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoanCellLatout;
@interface LoanCell : UITableViewCell
@property (strong, nonatomic) LoanCellLatout *cellLayout;

- (void)draw;
- (void)clear;
@end
