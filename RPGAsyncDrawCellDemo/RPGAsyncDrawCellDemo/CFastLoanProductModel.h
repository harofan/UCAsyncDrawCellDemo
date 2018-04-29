//
//  CFastLoanProductModel.h
//  CreditCat
//
//  Created by luming on 2017/11/24.
//  Copyright © 2017年 luming. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFastLoanProductModel : NSObject
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *productName;
@property (nonatomic,copy) NSString *productIcon;
@property (nonatomic,copy) NSString *creditLimit;
@property (nonatomic,copy) NSString *productDesc;
@property (nonatomic,copy) NSString *productLabel;
@property (nonatomic,copy) NSString *featureTag;
@property (nonatomic,copy) NSString *productRemark;
@property (nonatomic,copy) NSString *statisticalDesc;
@property (nonatomic,copy) NSString *jumpUrl;

@end
