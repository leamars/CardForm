//
//  CardCCVTest.m
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CardCCV.h"

@interface CardCCVTest : XCTestCase

@end

@implementation CardCCVTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testIsValidCCV {
    
    // Valid Card Numbers
    // VISA:
    NSString *VISA = @"4485224267094078";
    // MasterCard:
    NSString *MC = @"5459567620415300";
    // Amex:
    NSString *AM = @"341957809059727";
    // Discover:
    NSString *DC = @"6011741106859815";
    // JCB:
    NSString *JCBCard = @"3530111333300000";
    
    
    // 1. Valid CCV for not Amex
    NSString *validCCV = @"234";
    
    CardNumber *cardNumber = [CardNumber cardNumberWithString:VISA];
    CardCCV *cardCCV = [CardCCV cardCCVWithString:validCCV andCardNumber:cardNumber];
    CardExp *cardExp = [CardExp cardExpDateWithString:@"10/17" andCardNumber:cardNumber];
    [cardCCV setExpDate:cardExp];
    
    // test that it passes with valid non Amex card
    XCTAssertEqual(1, [cardCCV validCCV], @"Should have matched.");
    
    // test that it doesn't pass with an Amex card
    cardCCV = [CardCCV cardCCVWithString:validCCV andCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    
    // 2. Valid CCV for Amex
    
    NSString *validAmexCCV = @"2345";
    cardCCV = [CardCCV cardCCVWithString:validAmexCCV andCardNumber:[CardNumber cardNumberWithString:AM]];
    CardExp *cardAmexExp = [CardExp cardExpDateWithString:@"10/17" andCardNumber:[CardNumber cardNumberWithString:AM]];
    [cardCCV setExpDate:cardAmexExp];
    
    // test that it passes with valid Amex card
    XCTAssertEqual(1, [cardCCV validCCV], @"Should have matched.");
    
    // test that it doesn't pass with a non Amex card
    cardCCV = [CardCCV cardCCVWithString:validAmexCCV andCardNumber:[CardNumber cardNumberWithString:JCBCard]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    
    // 3. Invalid CCV
    
    NSString *invalidCCVShort = @"23";
    NSString *invalidCCVLong = @"23456";
    
    // TOO SHORT
    // test that it fails for valid card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVShort andCardNumber:[CardNumber cardNumberWithString:DC]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for amex card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVShort andCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVShort andCardNumber:[CardNumber cardNumberWithString:@"345934857"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    
    // TOO LONG
    // test that it fails for valid card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:DC]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for amex card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid network card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"1111111111111111"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid length card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"448522"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for completely invalid card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"345934"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    
    // Slightly Invalid Card Numbers
    // VISA:
    NSString *InvalidVISA = @"4485224267094079";
    // Amex:
    NSString *InvalidAM = @"341957809059728";
    
    // test that it doesn't pass with a slightly invalid VISA card
    // test that it doesn't pass with an Amex card
    cardCCV = [CardCCV cardCCVWithString:validCCV andCardNumber:[CardNumber cardNumberWithString:InvalidVISA]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it doesn't pass with a slightly invalid Amex card
    cardCCV = [CardCCV cardCCVWithString:validCCV andCardNumber:[CardNumber cardNumberWithString:InvalidAM]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    
    // test for invalid expiration date
    
    cardExp = [CardExp cardExpDateWithString:@"10/13" andCardNumber:[CardNumber cardNumberWithString:AM]];
    [cardCCV setExpDate:cardExp];
    
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:DC]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for amex card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid network card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"1111111111111111"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid length card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"448522"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for completely invalid card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"345934"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test for completely wrong formatted date string
    
    cardExp = [CardExp cardExpDateWithString:@"234554" andCardNumber:[CardNumber cardNumberWithString:AM]];
    [cardCCV setExpDate:cardExp];
    
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:DC]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for amex card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid network card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"1111111111111111"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for invalid length card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"448522"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
    // test that it fails for completely invalid card
    cardCCV = [CardCCV cardCCVWithString:invalidCCVLong andCardNumber:[CardNumber cardNumberWithString:@"345934"]];
    XCTAssertNotEqual(1, [cardCCV validCCV], @"Should not have matched.");
    
}


@end
