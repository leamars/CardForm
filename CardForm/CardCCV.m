//
//  CardCCV.m
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import "CardCCV.h"

@implementation CardCCV {
    CardType cardType;
    NSString *CCVString;
}

+ (instancetype)cardCCVWithString:(NSString *)string andCardNumber: (CardNumber *) number
{
    return [[self alloc] initWithString:string andCardNumber:(CardNumber *) number];
}

- (instancetype)initWithString:(NSString *)string andCardNumber:(CardNumber *) number
{
    self = [super init];
    if (self) {
        // Strip non-digits
        [self setCardNumber:number];
        cardType = [[self cardNumber] cardType];
        CCVString = string;
        self.CCV = string;
    }
    return self;
}

- (BOOL) validCCV {
    
    if ([[self cardNumber] validCardNumber] && [[self expDate] validExpDate]) {
        
        if (cardType == Amex) {
            
            if ([CCVString length] == 4) {
                return YES;
            }
            else return NO;
        }
        else {
            if ([CCVString length] == 3) {
                return YES;
            }
            else return NO;
        }
    }
    else {
        return NO;
    }
}

@end
