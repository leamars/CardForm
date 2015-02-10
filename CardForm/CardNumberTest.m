//
//  CardNumberTest.m
//  CardForm
//
//  Created by Lea Marolt on 2/9/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CardNumber.h"

@interface CardNumberTest : XCTestCase

@end

@implementation CardNumberTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void) testIsValidLuhn {
    
    // valid credit card numbers
    // http://www.freeformatter.com/credit-card-number-generator-validator.html
    // except for JCB, because Wikipedia says the ones on that website would be invalis
    // JCB taken from: http://www.paypalobjects.com/en_US/vhelp/paypalmanager_help/credit_card_numbers.htm
    
    // VISA:
        NSString *VISA1 = @"4485224267094078";
        NSString *VISA2 = @"4532801436639827";
    // MasterCard:
        NSString *MC1 = @"5459567620415300";
        NSString *MC2 = @"5141057184709599";
    // Amex:
        NSString *Amex1 = @"341957809059727";
        NSString *Amex2 = @"347234879529805";
    // Discover:
        NSString *Discover1 = @"6011741106859815";
        NSString *Discover2 = @"6011937431131199";
    // JCB:
        NSString *JCB1 = @"3530111333300000";
        NSString *JCB2 = @"3566002020360505";
    
    CardNumber *cardNumber = [CardNumber cardNumberWithString:VISA1];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:VISA2];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MC1];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MC2];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Amex1];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Amex2];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Discover1];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Discover2];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:JCB1];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:JCB2];
    XCTAssertEqual(1, [cardNumber validLuhn], @"Should have matched.");
    
    // Invalid card numbers (just added +1 to the number) that are identified as valid based on their networks
    // InvalidVISA:
        NSString *InvalidVISA1 = @"4485224267094079";
        NSString *InvalidVISA2 = @"4532801436639828";
    // InvalidMasterCard:
        NSString *InvalidMC1 = @"5459567620415301";
        NSString *InvalidMC2 = @"5141057184709598";
    // InvalidAmex:
        NSString *InvalidAmex1 = @"341957809059728";
        NSString *InvalidAmex2 = @"347234879529806";
    // InvalidDiscover:
        NSString *InvalidDiscover1 = @"6011741106859816";
        NSString *InvalidDiscover2 = @"6011937431131198";
    // InvalidJCB:
        NSString *InvalidJCB1 = @"3530111333300001";
        NSString *InvalidJCB2 = @"3566002020360506";
    
    cardNumber = [CardNumber cardNumberWithString:InvalidVISA1];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidVISA2];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidMC1];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidMC2];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidAmex1];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidAmex2];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidDiscover1];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidDiscover2];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidJCB1];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidJCB2];
    XCTAssertNotEqual(1, [cardNumber validLuhn], @"Should not have matched.");
    
}

- (void) testIsValidCardNumber {
    
    // Valid Card Numbers
    // VISA:
        NSString *VISA1 = @"4485224267094078";
        NSString *VISA2 = @"4532801436639827";
    // MasterCard:
        NSString *MC1 = @"5459567620415300";
        NSString *MC2 = @"5141057184709599";
    // Amex:
        NSString *Amex1 = @"341957809059727";
        NSString *Amex2 = @"347234879529805";
    // Discover:
        NSString *Discover1 = @"6011741106859815";
        NSString *Discover2 = @"6011937431131199";
    // JCB:
        NSString *JCB1 = @"3530111333300000";
        NSString *JCB2 = @"3566002020360505";
    
    CardNumber *cardNumber = [CardNumber cardNumberWithString:VISA1];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:VISA2];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MC1];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MC2];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Amex1];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Amex2];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Discover1];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Discover2];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:JCB1];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:JCB2];
    XCTAssertEqual(1, [cardNumber validCardNumber], @"Should have matched.");
    
    // Almost valid card numbers:
    // They match in network + length, but fail to pass the luhn test
    // MostlyVISA:
        NSString *MostlyVISA1 = @"4485224267094079";
        NSString *MostlyVISA2 = @"4532801436639828";
    // MostlyMasterCard:
        NSString *MostlyMC1 = @"5459567620415301";
        NSString *MostlyMC2 = @"5141057184709598";
    // Mostlymex:
        NSString *MostlyAmex1 = @"341957809059728";
        NSString *MostlyAmex2 = @"347234879529806";
    // MostlyDiscover:
        NSString *MostlyDiscover1 = @"6011741106859816";
        NSString *MostlyDiscover2 = @"6011937431131198";
    // MostlyJCB:
        NSString *MostlyJCB1 = @"3530111333300001";
        NSString *MostlyJCB2 = @"3566002020360506";
    
    cardNumber = [CardNumber cardNumberWithString:MostlyVISA1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyVISA2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyMC1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyMC2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyAmex1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyAmex2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyDiscover1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyDiscover2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyJCB1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MostlyJCB2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    // Invalid length, right network
        NSString *InvalidLength1 = @"448522";
        NSString *InvalidLength2 = @"31121670650053503234";
    
    cardNumber = [CardNumber cardNumberWithString:InvalidLength1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidLength2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");

    
    // Invalid network, right length
        NSString *InvalidNet1 = @"1111111111111111";
        NSString *InvalidNet2 = @"234598723483728";
    
    cardNumber = [CardNumber cardNumberWithString:InvalidNet1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:InvalidNet2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    // Invalid length & network
        NSString *Invalid1 = @"12354123";
        NSString *Invalid2 = @"090";
    
    cardNumber = [CardNumber cardNumberWithString:Invalid1];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:Invalid2];
    XCTAssertNotEqual(1, [cardNumber validCardNumber], @"Should not have matched.");
    
}

- (void) testCorrectCardType {
    
    CardNumber *cardNumber = [CardNumber cardNumberWithString:@""];
    
    // check that objects gets set up properly with Unknown type
    XCTAssertNotEqual(Amex, [cardNumber cardType], @"Should not have matched.");
    XCTAssertEqual(Unknown, [cardNumber cardType], @"Should have matched.");
    
    // Valid card numbers:
    // VISA:
    NSString *VISA = @"4485224267094078";
    // MasterCard:
    NSString *MC = @"5459567620415300";
    // Amex:
    NSString *AM = @"341957809059727";
    // Discover:
    NSString *DiscoverNum = @"6011741106859815";
    // JCB:
    NSString *JCBNum = @"3530111333300000";
    
    cardNumber = [CardNumber cardNumberWithString:VISA];
    XCTAssertEqual(Visa, [cardNumber cardType], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:MC];
    XCTAssertEqual(MasterCard, [cardNumber cardType], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:AM];
    XCTAssertEqual(Amex, [cardNumber cardType], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:JCBNum];
    XCTAssertEqual(JCB, [cardNumber cardType], @"Should have matched.");
    
    cardNumber = [CardNumber cardNumberWithString:DiscoverNum];
    XCTAssertEqual(Discover, [cardNumber cardType], @"Should have matched.");
    
}


@end
