//
//  CardNumber.h
//  CardForm
//
//  Created by Lea Marolt on 2/7/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CardType.h"
#import "CardNumber.h"

@interface Card : NSObject

@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *CCV;
@property (nonatomic, strong) NSString *expirationMonth;
@property (nonatomic, strong) NSString *expirationYear;
@property (nonatomic, strong) UIImage *cardImage;
@property (nonatomic, strong) UIImage *cardCVVImage;
@property (nonatomic, strong) NSString *cardType;

+ (instancetype)card;
- (instancetype)initWithGenerics;
- (void) configureTypeFor: (CardType) cardType;

@end
