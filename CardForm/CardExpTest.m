//
//  CardExpTest.m
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CardExp.h"

@interface CardExpTest : XCTestCase

@end

@implementation CardExpTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testIsValidExpDate {
    
    
    // Valid Card Numbers
    // VISA:
    NSString *VISA = @"4485224267094078";
    // Amex:
    NSString *AM = @"341957809059727";

    // Slightly Invalid Card Numbers
    // VISA:
    NSString *InvalidVISA = @"4485224267094079";
    // Amex:
    NSString *InvalidAM = @"341957809059728";
    
    // Invalid length, right network
    NSString *InvalidLength1 = @"448522";
    NSString *InvalidLength2 = @"31121670650053503234";
    
    // Invalid network, right length
    NSString *InvalidNet1 = @"1111111111111111";
    NSString *InvalidNet2 = @"234598723483728";
    
    // Invalid length & network
    NSString *Invalid1 = @"12354123";
    NSString *Invalid2 = @"090";
    
    // VALID DATE
    NSString *validDate= @"09/23";
    
    CardExp *cardExp = [CardExp cardExpDateWithString:validDate andCardNumber:[CardNumber cardNumberWithString:VISA]];
    
    XCTAssertEqual(1, [cardExp validExpDate], @"Should have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertEqual(1, [cardExp validExpDate], @"Should have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidVISA]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidAM]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidLength1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidLength2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidNet1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidNet2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
   
    [cardExp setCardNumber:[CardNumber cardNumberWithString:Invalid1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:Invalid2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    // SLIGHTLY INVALID DATE
    NSString *slightlyInvalidDate = @"12/08";
    
    
    [cardExp setExpDate:slightlyInvalidDate];
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:VISA]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidVISA]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidAM]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidLength1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidLength2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidNet1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidNet2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:Invalid1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:Invalid2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    // COMPLETELY INVALID DATE
    NSString *invalidDate = @"w384957yt3iu";
    
    [cardExp setExpDate:invalidDate];
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:VISA]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should have matched.");
    
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:AM]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidVISA]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidAM]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidLength1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidLength2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidNet1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:InvalidNet2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:Invalid1]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
    [cardExp setCardNumber:[CardNumber cardNumberWithString:Invalid2]];
    XCTAssertNotEqual(1, [cardExp validExpDate], @"Should not have matched.");
    
}


@end
