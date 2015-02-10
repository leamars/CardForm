//
//  CardExpDate.h
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardNumber.h"

@interface CardExp : NSObject

@property (nonatomic, strong) CardNumber *cardNumber;
@property (nonatomic, strong) NSString *expDate;

+ (instancetype)cardExpDateWithString:(NSString *)string andCardNumber:(CardNumber *)number;
- (instancetype)initWithString:(NSString *)string andCardNumber:(CardNumber *)number;
- (BOOL) validExpDate;

@end
