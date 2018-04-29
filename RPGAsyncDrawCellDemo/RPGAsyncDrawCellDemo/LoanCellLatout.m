//
//  LoanCellLatout.m
//  UCPlan
//
//  Created by 范杨 on 2018/4/26.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "LoanCellLatout.h"
#import "CFastLoanProductModel.h"

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
@interface LoanCellLatout()
@property (strong, nonatomic) CFastLoanProductModel *model;

@property (assign, nonatomic, readwrite) CGFloat cellHeight;

/************  额度  ***************/
@property (assign, nonatomic, readwrite) CGFloat limitLabelTop;
@property (assign, nonatomic, readwrite) CGFloat limitLabelLeft;
@property (assign, nonatomic, readwrite) CGFloat limitLabelHeight;
@property (assign, nonatomic, readwrite) CGFloat limitLabelWidth;
@property (assign, nonatomic, readwrite) CGFloat limitLabelFont;
@property (strong, nonatomic, readwrite) NSMutableAttributedString *limitLabelAttributedString;

/************  贷款描述  ***************/
@property (assign, nonatomic, readwrite) CGFloat productDescLabelTop;
@property (assign, nonatomic, readwrite) CGFloat productDescLabelLeft;
@property (assign, nonatomic, readwrite) CGFloat productDescLabelHeight;
@property (assign, nonatomic, readwrite) CGFloat productDescLabelWidth;
@property (assign, nonatomic, readwrite) CGFloat productDescLabelFont;
@property (strong, nonatomic, readwrite) UIColor *productDescLabelColor;
@property (copy,   nonatomic, readwrite) NSString *productDescStr;

/************  贷款名称  ***************/
@property (assign, nonatomic, readwrite) CGFloat productNameLabelTop;
@property (assign, nonatomic, readwrite) CGFloat productNameLabelLeft;
@property (assign, nonatomic, readwrite) CGFloat productNameLabelHeight;
@property (assign, nonatomic, readwrite) CGFloat productNameLabelWidth;
@property (assign, nonatomic, readwrite) CGFloat productNameLabelFont;
@property (strong, nonatomic, readwrite) UIColor *productNameLabelColor;
@property (strong, nonatomic, readwrite) NSMutableAttributedString *productNameStr;

/************  贷款返现  ***************/
@property (assign, nonatomic, readwrite) CGFloat loanDescLabelTop;
@property (assign, nonatomic, readwrite) CGFloat loanDescLabelLeft;
@property (assign, nonatomic, readwrite) CGFloat loanDescLabelHeight;
@property (assign, nonatomic, readwrite) CGFloat loanDescLabelWidth;
@property (assign, nonatomic, readwrite) CGFloat loanDescLabelFont;
@property (strong, nonatomic, readwrite) UIColor *loanDescLabelColor;
@property (strong, nonatomic, readwrite) NSMutableAttributedString *loanDescNameStr;

/************  贷款申请人数  ***************/
@property (assign, nonatomic, readwrite) CGFloat applyPeopleNumLabelTop;
@property (assign, nonatomic, readwrite) CGFloat applyPeopleNumLabelLeft;
@property (assign, nonatomic, readwrite) CGFloat applyPeopleNumLabelHeight;
@property (assign, nonatomic, readwrite) CGFloat applyPeopleNumLabelWidth;
@property (assign, nonatomic, readwrite) CGFloat applyPeopleNumLabelFont;
@property (strong, nonatomic, readwrite) UIColor *applyPeopleNumLabelColor;
@property (strong, nonatomic, readwrite) NSMutableAttributedString *applyPeopleNumNameStr;

/************  固定图片标签  ***************/
@property (assign, nonatomic, readwrite) CGFloat hotLoanProductImageTop;
@property (assign, nonatomic, readwrite) CGFloat hotLoanProductImageLeft;
@property (assign, nonatomic, readwrite) CGFloat hotLoanProductImageHeight;
@property (assign, nonatomic, readwrite) CGFloat hotLoanProductImageWidth;
@property (copy,   nonatomic, readwrite) NSString *hotLoanProductImageStr;

/************  第一个标签  ***************/
@property (copy,   nonatomic, readwrite) NSString *firstTagStr;
@property (strong, nonatomic, readwrite) UIColor *firstTagStrColor;
@property (assign, nonatomic, readwrite) CGFloat firstTagStrFont;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewLeft;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewTop;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewWidth;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewHeight;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewLeftDistance;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewTopDistance;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewBorderWidth;
@property (assign, nonatomic, readwrite) CGFloat firstTagViewBorderRadius;
@property (strong, nonatomic, readwrite) UIColor *firstTagViewBorderColor;

/************  异步获取图片  ***************/
@property (assign, nonatomic, readwrite) CGFloat urlImageTop;
@property (assign, nonatomic, readwrite) CGFloat urlImageLeft;
@property (assign, nonatomic, readwrite) CGFloat urlImageHeight;
@property (assign, nonatomic, readwrite) CGFloat urlImageWidth;
@property (copy,   nonatomic, readwrite) NSString *urlImageStr;
@end

@implementation LoanCellLatout

#pragma mark - life circle
- (instancetype)initWithData:(CFastLoanProductModel *)model{
    if (self = [super init]) {
        _model = model;
        _cellHeight = 100;
        [self p_layout];
    }
    return self;
}

#pragma mark - private
- (void)p_layout{

    [self p_layoutLimitTitleLabel];//布局额度标题
    [self p_layoutProductDescLabel];//费率
    [self p_layoutProductNameLabel];//贷款名称
    [self p_layoutLoanDescLabel];//贷款成功可返现
    [self p_layoutApplyPeopleNumLabel];//贷款申请人数
    [self p_layoutHotLoanImageView];//热门贷款图标
    [self p_layoutFirstTagView];//第一个tag
    [self p_layoutAsyncImageLayer];
}

/**
 额度
 */
- (void)p_layoutLimitTitleLabel{
    
    NSString *limitTitleStr = self.model.creditLimit;
    if (limitTitleStr.length == 0) return;
    
    _limitLabelFont = 18;
    
    //富文本
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:limitTitleStr];
    NSRange range1 = NSMakeRange(0, limitTitleStr.length - 1);
//    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"3FA9C4"] range:range1];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range1];
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:range1];
    NSRange range2 = NSMakeRange(limitTitleStr.length - 1, 1);
//    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:range2];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range2];
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range2];
    self.limitLabelAttributedString = hintString;
    
    CGSize size =[limitTitleStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_limitLabelFont]}];
    
    _limitLabelTop = 15;
    _limitLabelLeft = 15;
    _limitLabelHeight = size.height;
    _limitLabelWidth = size.width;
    
}

/**
 费率
 */
- (void)p_layoutProductDescLabel{
    
    NSString *productStr = self.model.productDesc;
    if (productStr.length == 0) return;
    
    _productDescLabelTop = 40;
    _productDescLabelLeft = 15;
    _productDescLabelFont = 11;
    
    //计算宽高
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:_productDescLabelFont]};
    CGSize labelSize = [productStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attrs
                                                context:nil].size;
    
    _productDescLabelWidth = labelSize.width;
    _productDescLabelHeight = labelSize.height;
    _productDescLabelColor = [UIColor blueColor];
    _productDescStr = productStr;
}

- (void)p_layoutProductNameLabel{
    
    NSString *productNameStr = self.model.productName;
    if (productNameStr.length == 0) return;
    
    _productNameLabelColor = [UIColor blackColor];
    _productNameLabelFont = 14;
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:productNameStr];
    NSRange range1 = NSMakeRange(0, productNameStr.length);
    //    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"3FA9C4"] range:range1];
    [hintString addAttribute:NSForegroundColorAttributeName value:_productNameLabelColor range:range1];
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_productNameLabelFont] range:range1];
    self.productNameStr = hintString;

    CGSize size =[productNameStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_productNameLabelFont]}];
    _productNameLabelWidth = size.width;
    _productNameLabelHeight = size.height;
    _productNameLabelTop = 15;
    _productNameLabelLeft = ScreenWidth - _productNameLabelWidth - 15;
}

- (void)p_layoutLoanDescLabel{
    
    NSString *loanDestStr = @"贷款成功可返现";
    _loanDescLabelColor = [UIColor redColor];
    _loanDescLabelFont = 11;
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:loanDestStr];
    NSRange range1 = NSMakeRange(0, loanDestStr.length);
    [hintString addAttribute:NSForegroundColorAttributeName value:_loanDescLabelColor range:range1];
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_loanDescLabelFont] range:range1];
    
    self.loanDescNameStr = hintString;
    
    CGSize size =[loanDestStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_loanDescLabelFont]}];
    _loanDescLabelWidth = size.width;
    _loanDescLabelHeight = size.height;
    _loanDescLabelTop = 44;
    _loanDescLabelLeft = ScreenWidth - _loanDescLabelWidth - 15;
    
}

- (void)p_layoutApplyPeopleNumLabel{
    
    NSString *applyPeopelNumStr = self.model.statisticalDesc;
    if (applyPeopelNumStr.length == 0) return;
    
    _applyPeopleNumLabelColor = [UIColor orangeColor];
    _applyPeopleNumLabelFont = 11;
    
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:applyPeopelNumStr];
    NSRange range1 = NSMakeRange(0, applyPeopelNumStr.length);
    [hintString addAttribute:NSForegroundColorAttributeName value:_applyPeopleNumLabelColor range:range1];
    [hintString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:_applyPeopleNumLabelFont] range:range1];

    self.applyPeopleNumNameStr = hintString;
    CGSize size =[applyPeopelNumStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_loanDescLabelFont]}];
    _applyPeopleNumLabelWidth = size.width;
    _applyPeopleNumLabelHeight = size.height;
    _applyPeopleNumLabelTop = 66;
    _applyPeopleNumLabelLeft = ScreenWidth - _applyPeopleNumLabelWidth - 15;

}

- (void)p_layoutHotLoanImageView{
    
    _hotLoanProductImageTop = 10;
    _hotLoanProductImageWidth = 36;
    _hotLoanProductImageHeight = 27;
    _hotLoanProductImageLeft = ScreenWidth - 15 - _productNameLabelWidth - 5 - _hotLoanProductImageWidth;
    _hotLoanProductImageStr = @"img_hb";
}

- (void)p_layoutFirstTagView{
    
    NSString *firstTagStr = self.model.productLabel;
    if (firstTagStr.length == 0) return;
    
    _firstTagStr = firstTagStr;
    _firstTagStrColor = [UIColor orangeColor];
    _firstTagStrFont = 12;
    _firstTagViewLeft = 15;
    _firstTagViewTop = 63;
    _firstTagViewLeftDistance = 15;
    _firstTagViewTopDistance = 3;
    _firstTagViewBorderWidth = 1;
    _firstTagViewBorderRadius = 8;
    _firstTagViewBorderColor = [UIColor orangeColor];
    
    //计算宽高
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:_firstTagStrFont]};
    CGSize labelSize = [firstTagStr boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attrs
                                                context:nil].size;
    _firstTagViewWidth = 2 * _firstTagViewLeftDistance + labelSize.width;
    _firstTagViewHeight = 2 * _firstTagViewTopDistance + labelSize.height;
}

- (void)p_layoutAsyncImageLayer{
    
    if (self.model.productIcon.length == 0) return;
        
    _urlImageTop = 10;
    _urlImageWidth = 26;
    _urlImageHeight = 26;
    _urlImageLeft = _hotLoanProductImageLeft - 5 - _urlImageWidth;
    _urlImageStr = self.model.productIcon;
}

- (void)p_caculateCellHeight{
    
    _cellHeight = _firstTagViewTop + _firstTagViewHeight + 15;
}

@end
