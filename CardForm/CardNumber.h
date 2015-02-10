//
//  CardNumber.h
//  CardForm
//
//  Created by Lea Marolt on 2/7/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardType.h"

@interface CardNumber : NSObject

@property (nonatomic) CardType cardType;
@property (nonatomic, strong) NSString *number;

+ (instancetype)cardNumberWithString:(NSString *)string;
- (instancetype)initWithString:(NSString *)string;
- (CardType) cardType;
- (BOOL) validLuhn;
- (BOOL) validCardNumber;

@end
