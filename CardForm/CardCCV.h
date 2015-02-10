//
//  CardCCV.h
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardNumber.h"
#import "CardExp.h"

@interface CardCCV : NSObject

@property (nonatomic, strong) CardNumber *cardNumber;
@property (nonatomic, strong) CardExp *expDate;
@property (nonatomic, strong) NSString *CCV;

+ (instancetype)cardCCVWithString:(NSString *)string andCardNumber:(CardNumber *)number;;
- (instancetype)initWithString:(NSString *)string andCardNumber:(CardNumber *)number;
- (BOOL) validCCV;

@end
