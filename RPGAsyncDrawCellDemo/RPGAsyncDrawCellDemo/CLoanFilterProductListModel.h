//
//  CLoanFilterProductListModel.h
//  CreditCat
//
//  Created by 范杨 on 2017/11/24.
//  Copyright © 2017年 luming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFastLoanProductModel.h"
@interface CLoanFilterProductListModel : NSObject

@property (nonatomic,copy) NSArray <CFastLoanProductModel * > *loanProducts;

@end
