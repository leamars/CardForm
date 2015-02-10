//
//  CardNumber.m
//  CardForm
//
//  Created by Lea Marolt on 2/7/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import "CardNumber.h"

@implementation CardNumber

+ (instancetype)cardNumberWithString:(NSString *)string
{
    return [[self alloc] initWithString:string];
}

- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        // Strip non-digits
        [self setNumber:string];
        [self setCardType:Unknown];
    }
    return self;
}

- (CardType) cardType {
    
    int firstFew = [[self number] intValue];
    
    NSRegularExpression *visaRegex = [NSRegularExpression regularExpressionWithPattern:@"^4[0-9]{0,15}" options:0 error:nil];
    NSRegularExpression *amexRegex = [NSRegularExpression regularExpressionWithPattern:@"^(34|37)[0-9]{0,13}" options:0 error:nil];
    NSRegularExpression *discoverRegex = [NSRegularExpression regularExpressionWithPattern:@"^6(011[0-9]{0,12}|[45][0-9]{0,14}|22[0-9]{0,13})" options:0 error:nil];
    NSRegularExpression *masterCardRegex = [NSRegularExpression regularExpressionWithPattern:@"^5[1-5][0-9]{0,14}" options:0 error:nil];
    NSRegularExpression *JCBRegex = [NSRegularExpression regularExpressionWithPattern:@"^35(2[8-9]|[3-7][0-9]|8[0-9])[0-9]{0,13}" options:0 error:nil];
    
    
    NSTextCheckingResult *visaMatch = [visaRegex firstMatchInString:[self number] options:0 range:NSMakeRange(0, [[self number] length])];
    NSTextCheckingResult *amexMatch = [amexRegex firstMatchInString:[self number] options:0 range:NSMakeRange(0, [[self number] length])];
    NSTextCheckingResult *JCBMatch = [JCBRegex firstMatchInString:[self number] options:0 range:NSMakeRange(0, [[self number] length])];
    NSTextCheckingResult *masterCardMatch = [masterCardRegex firstMatchInString:[self number] options:0 range:NSMakeRange(0, [[self number] length])];
    NSTextCheckingResult *discoverMatch = [discoverRegex firstMatchInString:[self number] options:0 range:NSMakeRange(0, [[self number] length])];
    
    if (visaMatch) {
        return Visa;
    }
    else if (amexMatch) {
        return Amex;
    }
    else if (JCBMatch) {
        return JCB;
    }
    else if (masterCardMatch) {
        return MasterCard;
    }
    else if (discoverMatch) {
        return Discover;
    }
    else {
        return Unknown;
    }
    
}

// http://en.wikipedia.org/wiki/Luhn_algorithm

- (BOOL) validLuhn {
    
    int validLength;
    
    // handles Amex Luhn validation
    BOOL switchOdd = NO;
    
    // make sure that it doesn't start validatin luhn number before the whole card is entered, amex exception
    if ([self cardType] == Amex) {
        validLength = 14;
        switchOdd = YES;
    }
    
    else {
        validLength = 15;
    }
    
    
    if ([[self number] length] > validLength) {
    
        NSMutableArray *digits = [[NSMutableArray alloc] initWithCapacity:16];
    
        int sumOdd = 0;
        int sumEven = 0;
    
        for (int i = 0; i < [[self number] length]; i++) {
            
            NSString *charDigit = [NSString stringWithFormat:@"%c", [[self number] characterAtIndex:i]];
            
            [digits addObject:charDigit];
        }
    
        for (int i = [digits count] - 1; i >= 0; i--) {
            
            if (i%2 == switchOdd) {
                
                int evenDigit = 2*[digits[i] intValue];
                
                if (evenDigit > 9) {
                    int tens = evenDigit % 10;
                    int ones = (evenDigit/10) % 10;
                    
                    evenDigit = tens+ones;
                }
                
                sumEven += evenDigit;
                
            }
            else {
        
                int oddDigit = [digits[i] intValue];
                sumOdd += oddDigit;
            }
        }
        
        return ((sumOdd + sumEven) % 10 == 0);
    }
    else {
        return YES;
    }
}

- (BOOL) validCardNumber {
    if ([self cardType] == Amex) {
        if (([[self number] length] == 15) && [self validLuhn]) {
            return YES;
        }
        else return NO;
    }
    else {
        if (([[self number] length] == 16) && [self validLuhn]) {
            return YES;
        }
        else return NO;
    }
}

@end
