//
//  CardTest.m
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Card.h"

@interface CardTest : XCTestCase

@end

@implementation CardTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testConfigureTypeFor {
    CardType type1 = Amex;
    Card *card = [Card card];
    [card configureTypeFor:type1];
    
    XCTAssertEqualObjects(@"Amex", card.cardType, @"Should have matched");
    
    CardType type2 = Visa;
    [card configureTypeFor:type2];
    XCTAssertEqualObjects(@"Visa", card.cardType, @"Should have matched");
    
    XCTAssertNotEqualObjects(@"Discover", card.cardType, @"Should not have matched");
}

- (void) testGenericCard {
    Card *card = [Card card];
    UIImage *CVVGenericImage = [UIImage imageNamed:@"CVV"];
    UIImage *cardGenericImage = [UIImage imageNamed:@"GenericCard"];
    NSString *cardGenericType = @"Unknown";
    
    UIImage *CVVImage = [UIImage imageNamed:@"AmexCVV"];
    UIImage *cardImage = [UIImage imageNamed:@"Amex"];
    NSString *cardType = @"Amex";
    
    
    XCTAssertEqualObjects(CVVGenericImage, card.cardCVVImage, @"Should have matched");
    XCTAssertEqualObjects(cardGenericImage, card.cardImage, @"Should have matched");
    XCTAssertEqualObjects(cardGenericType, card.cardType, @"Should have matched");
    
    XCTAssertNotEqualObjects(CVVImage, card.cardCVVImage, @"Should not have matched");
    XCTAssertNotEqualObjects(cardImage, card.cardImage, @"Should not have matched");
    XCTAssertNotEqualObjects(cardType, card.cardType, @"Should not have matched");
}

@end
