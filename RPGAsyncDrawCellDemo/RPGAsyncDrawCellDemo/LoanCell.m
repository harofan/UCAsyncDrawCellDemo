//
//  LoanCell.m
//  UCPlan
//
//  Created by 范杨 on 2018/4/26.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "LoanCell.h"
#import "LoanCellLatout.h"
#import <CoreText/CoreText.h>
#import <OpenGLES/ES1/gl.h>
#import "LoanCellHelper.h"
#import <YYDispatchQueuePool.h>
#import <CALayer+YYWebImage.h>

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width

@interface LoanCell()

@property (strong, nonatomic) UILabel *limitTitleLabel;
@property (assign, nonatomic) BOOL isDraw;
@property (strong, nonatomic) UIImageView *containerImageView;
@property (strong, nonatomic) CALayer *asyncImageLayer;
@end

@implementation LoanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.containerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.containerImageView];
        self.containerImageView.image = nil;
    }
    return self;
}

#pragma mark - public
- (void)draw{
    
    //已经画过了,或者没数据
    if (_isDraw && (!self.cellLayout)) return;
    _isDraw = YES;
    
    //使用YY大佬的一个线程池创建和CPU核心数相同的线程
    dispatch_queue_t queue = [[LoanCellHelper shareHelper] getNoBusyQueue];
    dispatch_async(queue, ^{
        NSLog(@"%@",[NSThread currentThread]);
        CGRect rect = CGRectMake(0, 0, ScreenWidth, self.cellLayout.cellHeight);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //背景色
        //        [[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1] set];
        [[UIColor whiteColor] set];
        CGContextFillRect(context, rect);
        
        //若外部滚动过快强行停止,那么没必要继续绘制
        if (!self.isDraw) return ;
        
        //渲染额度标题
        [self p_drawWithAttributedString:self.cellLayout.limitLabelAttributedString
                                 context:context
                            textPosition:CGPointMake(self.cellLayout.limitLabelLeft, self.cellLayout.limitLabelTop)
                               textWidth:self.cellLayout.limitLabelWidth
                              textHeight:self.cellLayout.limitLabelHeight
                                textFont:[UIFont systemFontOfSize:self.cellLayout.limitLabelFont]];
        
        if (!self.isDraw) return ;
        
        //费率
        [self p_drawWithNormalStr:self.cellLayout.productDescStr
                          context:context
                     textPosition:CGPointMake(self.cellLayout.productDescLabelLeft, self.cellLayout.productDescLabelTop)
                        textWidth:self.cellLayout.productDescLabelWidth
                       textHeight:self.cellLayout.productDescLabelHeight
                        textColor:self.cellLayout.productDescLabelColor
                         textFont:[UIFont systemFontOfSize:self.cellLayout.productDescLabelFont]];
        
        //后面的文字渲染就全部采用富文本了
        
        if (!self.isDraw) return ;
        
        //贷款产品名称
        [self p_drawWithAttributedString:self.cellLayout.productNameStr
                                 context:context
                            textPosition:CGPointMake(self.cellLayout.productNameLabelLeft, self.cellLayout.productNameLabelTop)
                               textWidth:self.cellLayout.productNameLabelWidth
                              textHeight:self.cellLayout.productNameLabelHeight
                                textFont:[UIFont systemFontOfSize:self.cellLayout.productNameLabelFont]];
        
        if (!self.isDraw) return ;
        
        //贷款奖励
        [self p_drawWithAttributedString:self.cellLayout.loanDescNameStr
                                 context:context
                            textPosition:CGPointMake(self.cellLayout.loanDescLabelLeft, self.cellLayout.loanDescLabelTop)
                               textWidth:self.cellLayout.loanDescLabelWidth
                              textHeight:self.cellLayout.loanDescLabelHeight
                                textFont:[UIFont systemFontOfSize:self.cellLayout.loanDescLabelFont]];
        
        if (!self.isDraw) return ;
        
        //申请人数
        [self p_drawWithAttributedString:self.cellLayout.applyPeopleNumNameStr
                                 context:context
                            textPosition:CGPointMake(self.cellLayout.applyPeopleNumLabelLeft, self.cellLayout.applyPeopleNumLabelTop)
                               textWidth:self.cellLayout.applyPeopleNumLabelWidth
                              textHeight:self.cellLayout.applyPeopleNumLabelHeight
                                textFont:[UIFont systemFontOfSize:self.cellLayout.applyPeopleNumLabelFont]];
        
        if (!self.isDraw) return ;
        
        //画一个固定图片
        [self p_drawWithNormalImage:[UIImage imageNamed:self.cellLayout.hotLoanProductImageStr]
                            context:context
                      imagePosition:CGPointMake(self.cellLayout.hotLoanProductImageLeft, self.cellLayout.hotLoanProductImageTop)
                         imageWidth:self.cellLayout.hotLoanProductImageWidth
                        imageHeight:self.cellLayout.hotLoanProductImageHeight];
        
        if (!self.isDraw) return ;
        
        //画tag
        [self p_drawTagViewWithTagStr:self.cellLayout.firstTagStr
                              context:context
                          tagStrColor:self.cellLayout.firstTagStrColor
                           tagStrFont:self.cellLayout.firstTagStrFont
                      tagViewPosition:CGPointMake(self.cellLayout.firstTagViewLeft, self.cellLayout.firstTagViewTop)
                         tagViewWidth:self.cellLayout.firstTagViewWidth
                        tagViewHeight:self.cellLayout.firstTagViewHeight
                   tagStrLeftDistance:self.cellLayout.firstTagViewLeftDistance
                    tagStrTopDistance:self.cellLayout.firstTagViewTopDistance
                   tagViewBorderWidth:self.cellLayout.firstTagViewBorderWidth
                   tagViewBorderColor:self.cellLayout.firstTagViewBorderColor
                  tagViewBorderRadius:self.cellLayout.firstTagViewBorderRadius];
        
        if (!self.isDraw) return ;
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            self.containerImageView.frame = rect;
            self.containerImageView.image = temp;
            
            //添加一个异步加载的layer上去
            [self p_drawAsyncImageLayerWithUrl:self.cellLayout.urlImageStr
                            imageLayerPosition:CGPointMake(self.cellLayout.urlImageLeft, self.cellLayout.urlImageTop)
                               imageLayerWidth:self.cellLayout.urlImageWidth
                              imageLayerHeight:self.cellLayout.urlImageHeight];
        });
    });
    
}

- (void)clear{
    if (!_isDraw) return;
    
    self.containerImageView.frame = CGRectZero;
    self.containerImageView.image = nil;
    _isDraw = NO;
}

#pragma mark - private
- (void)p_drawWithNormalStr:(NSString *)string
                    context:(CGContextRef)context
               textPosition:(CGPoint)textPosition
                  textWidth:(CGFloat)textWidth
                 textHeight:(CGFloat)textHeight
                  textColor:(UIColor *)textColor
                   textFont:(UIFont *)textFont{
    
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:string];
    NSRange range1 = NSMakeRange(0, string.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:textColor range:range1];
    [attributedString addAttribute:NSFontAttributeName value:textFont range:range1];
    
    [self p_drawWithAttributedString:attributedString
                             context:context
                        textPosition:textPosition
                           textWidth:textWidth
                          textHeight:textHeight
                            textFont:textFont];
    
}

- (void)p_drawWithAttributedString:(NSMutableAttributedString *)attributedString
                           context:(CGContextRef)context
                      textPosition:(CGPoint)textPosition
                         textWidth:(CGFloat)textWidth
                        textHeight:(CGFloat)textHeight
                          textFont:(UIFont *)textFont{
    
    CGSize size = CGSizeMake(textWidth, textFont.pointSize+10);
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0,textHeight);
    CGContextScaleCTM(context,1.0,-1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectMake(textPosition.x, textHeight- textPosition.y-size.height,(size.width),(size.height)));
    
    
    CFAttributedStringRef cfAttributedString = (__bridge CFAttributedStringRef)attributedString;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    CTFrameRef ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(0,CFAttributedStringGetLength(cfAttributedString)),path,NULL);
    CTFrameDraw(ctframe,context);
    CGPathRelease(path);
    CFRelease(framesetter);
    CFRelease(ctframe);
    CGContextSetTextMatrix(context,CGAffineTransformIdentity);
    CGContextTranslateCTM(context,0, textHeight);
    CGContextScaleCTM(context,1.0,-1.0);
}

- (void)p_drawWithNormalImage:(UIImage *)image
                      context:(CGContextRef)context
                imagePosition:(CGPoint)imagePosition
                   imageWidth:(CGFloat)imageWidth
                  imageHeight:(CGFloat)imageHeight{
    
//    [image drawInRect:CGRectMake(imagePosition.x, imagePosition.y, imageWidth, imageHeight)];//在坐标中画出图片
    
    CGContextSaveGState(context);
    // 图形上下文形变，避免图片倒立显示
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(imagePosition.x, -imagePosition.y - imageHeight, imageWidth, imageHeight), image.CGImage);
    CGContextRestoreGState(context);

}

- (void)p_drawTagViewWithTagStr:(NSString *)tagStr
                        context:(CGContextRef)context
                    tagStrColor:(UIColor *)tagStrColor
                     tagStrFont:(CGFloat)tagStrFont
                tagViewPosition:(CGPoint)tagViewPosition
                   tagViewWidth:(CGFloat)tagViewWidth
                  tagViewHeight:(CGFloat)tagViewHeight
             tagStrLeftDistance:(CGFloat)tagStrLeftDistance
              tagStrTopDistance:(CGFloat)tagStrTopDistance
             tagViewBorderWidth:(CGFloat)tagViewBorderWidth
             tagViewBorderColor:(UIColor *)tagViewBorderColor
            tagViewBorderRadius:(CGFloat)tagViewBorderRadius{
    
    //画文字
    UIFont *strFont = [UIFont systemFontOfSize:tagStrFont];
    NSMutableAttributedString *attributedString=[[NSMutableAttributedString alloc]initWithString:tagStr];
    NSRange range1 = NSMakeRange(0, tagStr.length);
    [attributedString addAttribute:NSForegroundColorAttributeName value:tagStrColor range:range1];
    [attributedString addAttribute:NSFontAttributeName value:strFont range:range1];
    
    [self p_drawWithAttributedString:attributedString
                             context:context
                        textPosition:CGPointMake(tagViewPosition.x + tagStrLeftDistance, tagViewPosition.y + tagStrTopDistance)
                           textWidth:(tagViewWidth - 2 * tagStrLeftDistance)
                          textHeight:(tagViewHeight - 2 * tagStrTopDistance)
                            textFont:strFont];
    
    
    //参考:https://blog.csdn.net/yugudeveloper/article/details/32350179
    CGFloat width = tagViewWidth;
    CGFloat height = tagViewHeight;
    CGFloat radius = tagViewBorderRadius;
    CGFloat tagViewX = tagViewPosition.x;
    CGFloat tagViewY = tagViewPosition.y;
    
    // 移动到初始点
       CGContextSetStrokeColorWithColor(context, tagViewBorderColor.CGColor);
    CGContextMoveToPoint(context, tagViewX + radius, tagViewY);
    // 绘制第1条线和第1个1/4圆弧，右上圆弧
    CGContextAddLineToPoint(context, tagViewX + radius + width - 2 * radius, tagViewY);
    CGContextAddArc(context, tagViewX + width - radius, tagViewY + radius, radius, -0.5 *M_PI,0.0,0);

    // 绘制第2条线和第2个1/4圆弧，右下圆弧
    CGContextAddLineToPoint(context, tagViewX + width, tagViewY + height - radius);
    CGContextAddArc(context, tagViewX + width - radius, tagViewY + height - radius, radius,0.0,0.5 *M_PI,0);

    // 绘制第3条线和第3个1/4圆弧，左下圆弧
    CGContextAddLineToPoint(context, tagViewX + radius, tagViewY + height);
    CGContextAddArc(context, tagViewX + radius, tagViewY + height - radius, radius,0.5 *M_PI,M_PI,0);
    
    // 绘制第4条线和第4个1/4圆弧，左上圆弧
    CGContextAddLineToPoint(context, tagViewX, tagViewY + radius);
    CGContextAddArc(context, tagViewX + radius, tagViewY + radius, radius,M_PI,1.5 *M_PI,0);
  
    CGContextStrokePath(context);
   
}

- (void)p_drawAsyncImageLayerWithUrl:(NSString *)urlStr
                  imageLayerPosition:(CGPoint)imageLayerPosition
                     imageLayerWidth:(CGFloat)imageLayerWidth
                    imageLayerHeight:(CGFloat)imageLayerHeight{
    
    self.asyncImageLayer.frame = CGRectMake(imageLayerPosition.x, imageLayerPosition.y, imageLayerWidth, imageLayerHeight);
    [self.asyncImageLayer setImageURL:[NSURL URLWithString:urlStr] ];
    
}


//- (void)p_drawWithAttributedString:(NSMutableAttributedString *)attributedString
//                           context:(CGContextRef)context
//                      textPosition:(CGPoint)textPosition
//                          textSize:(CGSize)size{
//
////    CGContextConcatCTM(context, CGAffineTransformScale(CGAffineTransformMakeTranslation(0, size.height), 1.f, -1.f));
////
////    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
////    CGMutablePathRef path = CGPathCreateMutable();
////    CGPathAddRect(path, NULL, CGRectMake(textPosition.x, textPosition.y, size.width, size.height));
////
////    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
////    CFRelease(path);
////    CFRelease(framesetter);
////
////    CTFrameDraw(frame, context);
////    CFRelease(frame);
//
//
//}

#pragma mark - set && get
- (UILabel *)limitTitleLabel{
    if (_cellLayout && !_limitTitleLabel) {
        _limitTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_cellLayout.limitLabelLeft, _cellLayout.limitLabelTop, _cellLayout.limitLabelWidth, _cellLayout.limitLabelHeight)];
        _limitTitleLabel.attributedText = _cellLayout.limitLabelAttributedString;
    }
    return _limitTitleLabel;
}

- (CALayer *)asyncImageLayer{
    if (!_asyncImageLayer) {
       _asyncImageLayer = [[CALayer alloc] init];
        [self.containerImageView.layer addSublayer:_asyncImageLayer];
    }
    return _asyncImageLayer;
}

@end
