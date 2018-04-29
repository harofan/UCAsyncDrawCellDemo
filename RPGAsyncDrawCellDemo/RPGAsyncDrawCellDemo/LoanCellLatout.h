//
//  LoanCellLatout.h
//  UCPlan
//
//  Created by 范杨 on 2018/4/26.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CFastLoanProductModel;
@interface LoanCellLatout : NSObject

/************  额度  ***************/
@property (assign, nonatomic, readonly) CGFloat limitLabelTop;
@property (assign, nonatomic, readonly) CGFloat limitLabelLeft;
@property (assign, nonatomic, readonly) CGFloat limitLabelHeight;
@property (assign, nonatomic, readonly) CGFloat limitLabelWidth;
@property (assign, nonatomic, readonly) CGFloat limitLabelFont;
@property (strong, nonatomic, readonly) NSMutableAttributedString *limitLabelAttributedString;

/************  贷款描述  ***************/
@property (assign, nonatomic, readonly) CGFloat productDescLabelTop;
@property (assign, nonatomic, readonly) CGFloat productDescLabelLeft;
@property (assign, nonatomic, readonly) CGFloat productDescLabelHeight;
@property (assign, nonatomic, readonly) CGFloat productDescLabelWidth;
@property (assign, nonatomic, readonly) CGFloat productDescLabelFont;
@property (strong, nonatomic, readonly) UIColor *productDescLabelColor;
@property (copy,   nonatomic, readonly) NSString *productDescStr;

/************  贷款名称  ***************/
@property (assign, nonatomic, readonly) CGFloat productNameLabelTop;
@property (assign, nonatomic, readonly) CGFloat productNameLabelLeft;
@property (assign, nonatomic, readonly) CGFloat productNameLabelHeight;
@property (assign, nonatomic, readonly) CGFloat productNameLabelWidth;
@property (assign, nonatomic, readonly) CGFloat productNameLabelFont;
@property (strong, nonatomic, readonly) UIColor *productNameLabelColor;
@property (strong, nonatomic, readonly) NSMutableAttributedString *productNameStr;

/************  贷款返现  ***************/
@property (assign, nonatomic, readonly) CGFloat loanDescLabelTop;
@property (assign, nonatomic, readonly) CGFloat loanDescLabelLeft;
@property (assign, nonatomic, readonly) CGFloat loanDescLabelHeight;
@property (assign, nonatomic, readonly) CGFloat loanDescLabelWidth;
@property (assign, nonatomic, readonly) CGFloat loanDescLabelFont;
@property (strong, nonatomic, readonly) UIColor *loanDescLabelColor;
@property (strong, nonatomic, readonly) NSMutableAttributedString *loanDescNameStr;

/************  贷款申请人数  ***************/
@property (assign, nonatomic, readonly) CGFloat applyPeopleNumLabelTop;
@property (assign, nonatomic, readonly) CGFloat applyPeopleNumLabelLeft;
@property (assign, nonatomic, readonly) CGFloat applyPeopleNumLabelHeight;
@property (assign, nonatomic, readonly) CGFloat applyPeopleNumLabelWidth;
@property (assign, nonatomic, readonly) CGFloat applyPeopleNumLabelFont;
@property (strong, nonatomic, readonly) UIColor *applyPeopleNumLabelColor;
@property (strong, nonatomic, readonly) NSMutableAttributedString *applyPeopleNumNameStr;

/************  固定图片标签  ***************/
@property (assign, nonatomic, readonly) CGFloat hotLoanProductImageTop;
@property (assign, nonatomic, readonly) CGFloat hotLoanProductImageLeft;
@property (assign, nonatomic, readonly) CGFloat hotLoanProductImageHeight;
@property (assign, nonatomic, readonly) CGFloat hotLoanProductImageWidth;
@property (copy,   nonatomic, readonly) NSString *hotLoanProductImageStr;

/************  第一个标签  ***************/
@property (copy,   nonatomic, readonly) NSString *firstTagStr;
@property (strong, nonatomic, readonly) UIColor *firstTagStrColor;
@property (assign, nonatomic, readonly) CGFloat firstTagStrFont;
@property (assign, nonatomic, readonly) CGFloat firstTagViewLeft;
@property (assign, nonatomic, readonly) CGFloat firstTagViewTop;
@property (assign, nonatomic, readonly) CGFloat firstTagViewWidth;
@property (assign, nonatomic, readonly) CGFloat firstTagViewHeight;
@property (assign, nonatomic, readonly) CGFloat firstTagViewLeftDistance;
@property (assign, nonatomic, readonly) CGFloat firstTagViewTopDistance;
@property (assign, nonatomic, readonly) CGFloat firstTagViewBorderWidth;
@property (assign, nonatomic, readonly) CGFloat firstTagViewBorderRadius;
@property (strong, nonatomic, readonly) UIColor *firstTagViewBorderColor;

/************  异步获取图片  ***************/
@property (assign, nonatomic, readonly) CGFloat urlImageTop;
@property (assign, nonatomic, readonly) CGFloat urlImageLeft;
@property (assign, nonatomic, readonly) CGFloat urlImageHeight;
@property (assign, nonatomic, readonly) CGFloat urlImageWidth;
@property (copy,   nonatomic, readonly) NSString *urlImageStr;

/**
 cell高度
 */
@property (assign, nonatomic, readonly) CGFloat cellHeight;

- (instancetype)initWithData:(CFastLoanProductModel *)model;
@end
