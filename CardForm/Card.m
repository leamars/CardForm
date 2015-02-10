//
//  CardNumber.m
//  CardForm
//
//  Created by Lea Marolt on 2/7/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import "Card.h"

@implementation Card

+ (instancetype)card
{
    return [[self alloc] initWithGenerics];
}

- (instancetype)initWithGenerics
{
    self = [super init];
    
    Card *newCard = [[Card alloc] init];
    
    if (self) {
        // Strip non-digits
        
        [newCard setCardCVVImage:[UIImage imageNamed:@"CVV"]];
        [newCard setCardImage:[UIImage imageNamed:@"GenericCard"]];
        [newCard setCardType:@"Unknown"];
        
    }
    return newCard;
}

- (void) configureTypeFor: (CardType) cardType {
    
    [self setCardCVVImage:[UIImage imageNamed:@"CVV"]];
    
    if (cardType == Visa) {
        [self setCardImage:[UIImage imageNamed:@"Visa"]];
        [self setCardType:@"Visa"];
    }
    else if (cardType == MasterCard) {
        [self setCardImage:[UIImage imageNamed:@"Mastercard"]];
        [self setCardType:@"Mastercard"];
    }
    else if (cardType == JCB) {
        [self setCardImage:[UIImage imageNamed:@"JCB"]];
        [self setCardType:@"JCB"];
    }
    else if (cardType == Discover) {
        [self setCardImage:[UIImage imageNamed:@"Discover"]];
        [self setCardType:@"Discover"];
    }
    else if (cardType == Amex) {
        [self setCardImage:[UIImage imageNamed:@"Amex"]];
        [self setCardCVVImage:[UIImage imageNamed:@"AmexCVV"]];
        [self setCardType:@"Amex"];
    }
    else {
        [self setCardImage:[UIImage imageNamed:@"GenericCard"]];
        [self setCardType:@"Unknown"];
    }
    
}

@end
