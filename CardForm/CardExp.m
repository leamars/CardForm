//
//  CardExpDate.m
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import "CardExp.h"

@implementation CardExp {
    CardType cardType;
}

+ (instancetype)cardExpDateWithString:(NSString *)string andCardNumber:(CardNumber *)number;
{
    return [[self alloc] initWithString:string andCardNumber:(CardNumber *)number];
}

- (instancetype)initWithString:(NSString *)string andCardNumber:(CardNumber *)number
{
    self = [super init];
    if (self) {
        // Strip non-digits
        [self setCardNumber:number];
        cardType = [[self cardNumber] cardType];
        self.expDate = string;
    }
    return self;
}

- (BOOL) validExpDate {
    
    if ([[self cardNumber] validCardNumber]) {
        
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"MM/yy"];
        NSDate *today = [NSDate date];
        if ([self.expDate length] == 5) {
            NSDate *expDate = [dateFormatter dateFromString:self.expDate];
            
            return (expDate && [expDate timeIntervalSinceDate:today] > 0);
        }
        else {
            return NO;
        }
        
    }
    else {
        return NO;
    }
}

@end
