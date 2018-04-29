//
//  CLoanFilterProductListModel.m
//  CreditCat
//
//  Created by 范杨 on 2017/11/24.
//  Copyright © 2017年 luming. All rights reserved.
//

#import "CLoanFilterProductListModel.h"

@implementation CLoanFilterProductListModel

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"loanProducts":@"data.loanProducts"
             };
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"loanProducts":[CFastLoanProductModel class]
             };
}

@end
