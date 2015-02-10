//
//  ViewController.m
//  CardForm
//
//  Created by Lea Marolt on 2/7/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import "CardFormViewController.h"


@interface CardFormViewController ()

@end

@implementation CardFormViewController {
    CardNumber *cardNumber;
    CardCCV *cardCCV;
    CardExp *cardExp;
    Card *card;
    
    BOOL ValidNumber;
    BOOL ValidLuhn;
    BOOL ValidDate;
    BOOL ValidCCV;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cardNumber = [[CardNumber alloc] initWithString:@""];
    card = [[Card alloc] initWithGenerics];
    
    [self changeUserMessageTo:@"Enter credit card number!"];
    [self configureEnabled];
    [self configureView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - text field delegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.cardCCVField]) {
        
        [self changeUserMessageTo:@"Enter CCV number!"];
        [self cardImageTransitionWithImage:[card cardCVVImage]];
        
    }
    else if ([textField isEqual:self.cardExpField]) {
        
        [self changeUserMessageTo:@"Enter expiration date in format: MM/YY!"];
        [self cardImageTransitionWithImage:[card cardImage]];
        
    }
    
    else {
        
        [self changeUserMessageTo:@"Enter credit card number!"];
        [self cardImageTransitionWithImage:[card cardImage]];
        [self configureEnabled];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
//    NSLog(@"text field text SHOULD RETURN: %@", textField.text);

    return NO;
}

// makes sure that the only characters that can be entered are 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int length;
    
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    
    BOOL validString = NO;
    BOOL validCard = NO;
    BOOL validExpDate = NO;
    
    // prevent copying and pasting crash
    // http://stackoverflow.com/questions/433337/set-the-maximum-character-length-of-a-uitextfield
    if (range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    // only 19 characters can go in the number field, including whitespace
    
    // TO DO: Handle Amex
        
    if ([textField isEqual:self.cardNumberField]) {
        
        if ([cardNumber cardType] != Amex) {
            // prevent user from entering more than 6 numbers of a card, if by then it doesn't match any
            // network
            if ([textField.text length] && [cardNumber cardType] == Unknown) {
                length = 8;
            }
            else {
                length = 20;
            }
        }
        else {
            length = 18;
        }
        
        validString = ([string isEqualToString:filtered] && newLength < length);
        validCard = [self cardNumberShouldChangeCharactersInRange:range withReplacementString:string];
        
        return validString && validCard;
    }
    
    // only 5 characters can go in the expiration date field, including the "/"
    else if ([textField isEqual:self.cardExpField]) {
        
        length = 6;
        
        validString = ([string isEqualToString:filtered] && newLength < length);
        validExpDate = [self cardExpShouldChangeCharactersInRange:range withReplacementString:string];
        
        return validString && validExpDate;
    }
    // only 3 digits can go in the CCV field
    else {
        
        if ([cardNumber cardType] != Amex) {
            length = 4;
        }
        else {
            length = 5;
        }
        validString = ([string isEqualToString:filtered] && newLength < length);

    }
    
    return ([string isEqualToString:filtered] && newLength < length);
    
}

// handle credit card number input
- (BOOL) cardNumberShouldChangeCharactersInRange:(NSRange) range withReplacementString:(NSString *) string {
    
    [self editingChanged:self.cardNumberField];
    
    // automatically add space between every 4 digits if NOT amex
    if ([cardNumber cardType] != Amex) {
        if ((range.length == 0) && (range.location == 4 || range.location == 9 || range.location == 14)) {
            self.cardNumberField.text = [NSString stringWithFormat:@"%@ %@", self.cardNumberField.text, string];
            return NO;
        }
    
        else if (range.length == 1 && (range.location == 5 || range.location == 10 || range.location == 15))  {
            range.location--;
            range.length = 2;
            self.cardNumberField.text = [self.cardNumberField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    
    // automatically add space between digits 3 & 4 and 9 & 10
    else {
        
        if ((range.length == 0) && (range.location == 3 || range.location == 10)) {
            self.cardNumberField.text = [NSString stringWithFormat:@"%@ %@", self.cardNumberField.text, string];
            return NO;
        }
        
        else if (range.length == 1 && (range.location == 4 || range.location == 11))  {
            range.location--;
            range.length = 2;
            self.cardNumberField.text = [self.cardNumberField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    
    return YES;
}

- (BOOL) cardExpShouldChangeCharactersInRange:(NSRange) range withReplacementString:(NSString *) string {
    
    [self changeUserMessageTo:@"Enter expiration date in format: MM/YY!"];
    [self editingChanged:self.cardExpField];
    
    if (range.length == 0) {
        if (range.location == 0 || range.location == 1) {
            
            // make sure the month can only start with 0 or 1
            if (range.location == 0 && ([string intValue] > 1)) {
                // if not, append a 0 to the beginning to keep the format
                self.cardExpField.text = [NSString stringWithFormat:@"0%@/", string];
                return NO;
            }
            
            else if (range.location == 1) {
                self.cardExpField.text = [NSString stringWithFormat:@"%@%@/", self.cardExpField.text, string];
                return NO;
            }
        }
        
        
        else if (range.location == 2) {
            self.cardExpField.text = [NSString stringWithFormat:@"%@/%@", self.cardExpField.text, string];
            return NO;
        }
        
        
        // make sure year is at current year or beyond
        else if (range.location == 3 || range.location == 4) {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"YY"];
            NSDate *today = [NSDate date];
            NSString *todayString = [dateFormatter stringFromDate:today];
            
            int tens = [[NSString stringWithFormat:@"%c", [todayString characterAtIndex:0]] intValue];
            int ones = [[NSString stringWithFormat:@"%c", [todayString characterAtIndex:1]] intValue];
            
            if (range.location == 3 && tens > [string intValue]) {
                // disallow entry when the tens number is smaller thant the current year's
                return NO;
            }
            
            else if (range.location == 4) {
                // disallow entry when the ones number is smaller than the current year's
                // only do that if the tens year number matches the current year
                
                int currentTens = [[NSString stringWithFormat:@"%c", [self.cardExpField.text characterAtIndex:3]] intValue];
                
                if (ones > [string intValue] && tens == currentTens) {
                    [self changeUserMessageTo:@"This expiration date seems like it's in the past. Try again!"];
                    
                    return NO;
                }
            }
            
        }
    }
    
    else if (range.length == 1 && range.location == 3) {
        range.location--;
        range.length = 2;
        self.cardExpField.text = [self.cardExpField.text stringByReplacingCharactersInRange:range withString:@"/"];
        return NO;
    }
    
    return YES;
}

#pragma mark - alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        [self wipeData];
    }
}

#pragma mark - IBActions

-(IBAction) editingChanged:(id)sender {
    
    NSString *currentString = self.cardNumberField.text;
    NSString *currentStringTrimmed = [currentString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    UITextField *currentTextField = (UITextField *)sender;
    
    // set card number
    cardNumber = [CardNumber cardNumberWithString:currentStringTrimmed];
    
    // set card type
    CardType cardType = [cardNumber cardType];
    [card configureTypeFor:cardType];

    // set card expiration
    cardExp = [CardExp cardExpDateWithString:self.cardExpField.text andCardNumber:cardNumber];
    
    // set card CCV
    cardCCV = [CardCCV cardCCVWithString:self.cardCCVField.text andCardNumber:cardNumber];
    [cardCCV setExpDate:cardExp];
    
    if (![currentTextField isEqual:self.cardCCVField]) {
        [self cardImageTransitionWithImage:[card cardImage]];
    }
    else {
        [self cardImageTransitionWithImage:[card cardCVVImage]];
    }
    
    
    if ([cardNumber validLuhn]) {
        self.cardNumberField.textColor = [UIColor blackColor];
        if ([currentTextField isEqual:self.cardNumberField]) {
            [self changeUserMessageTo:@"Enter credit card number!"];
        }
        
    }
    else {
        self.cardNumberField.textColor = [UIColor redColor];
        [self changeUserMessageTo:@"Invalid number, try again!"];
    }
    
    [self configureEnabled];
}

- (IBAction)submit:(id)sender {
    
    card.number = [cardNumber number];
    card.expirationMonth = [self.cardExpField.text substringToIndex:2];
    card.expirationYear = [self.cardExpField.text substringFromIndex:3];
    card.CCV = self.cardCCVField.text;
    
    UIAlertView *alert = [self displayAlertForCardSubmission];
    
    [alert show];
    
    //[self wipeEverything];
}

#pragma-mark helpers

- (void) changeUserMessageTo:(NSString *) message {
    
    self.messageForUser.text = message;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.messageForUser.layer addAnimation:transition forKey:nil];
    
}

- (void) configureEnabled {
    
    self.cardExpField.enabled = [cardNumber validCardNumber];
    self.cardCCVField.enabled = [cardExp validExpDate];
    self.submitButton.enabled = [cardCCV validCCV];
    
    if (!self.submitButton.enabled) {
        [self.submitButton setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:108.0/255.0 alpha:0.5]];
        
        [self.submitButton setTitleColor:[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:198.0/255.0 alpha:0.5] forState:UIControlStateDisabled];
    }
    else {
        [self.submitButton setBackgroundColor:[UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:0.5]];
    }
}

// gracefully transition from different card images
- (void) cardImageTransitionWithImage: (UIImage *) img {
    
    self.cardImage.image = img;
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.cardImage.layer addAnimation:transition forKey:nil];
    
}

// set appropriate font and messages if the credit card passes or doesn't pass the luhn test
- (void) configureStateChange {
    
    if ([cardNumber validLuhn]) {
        if (([cardNumber cardType] != Amex) && [card.number length] == 16)
            self.cardNumberField.textColor = [UIColor blackColor];

    }
    else {
        self.cardNumberField.textColor = [UIColor redColor];
        [self changeUserMessageTo:@"Invalid number, try again!"];
        [self configureEnabled];
    }
}

- (UIAlertView *) displayAlertForCardSubmission {
    
    UIAlertView *alert;
    
    ValidNumber = [cardNumber validCardNumber];
    ValidLuhn = [cardNumber validLuhn];
    ValidDate = [cardExp validExpDate];
    ValidCCV = [cardCCV validCCV];
    
    // if everything passes validation
    if (ValidDate && ValidNumber && ValidLuhn && ValidCCV) {
        
        NSString *configureCardNumberForPrivacy = [self displayCardNumberBack];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:[NSString stringWithFormat:@"You've a card with the following information: \n\n Type: %@ \n Number: %@ \n Expiration Date: %@/%@ \n CVV: %@" , card.cardType, configureCardNumberForPrivacy, card.expirationMonth, card.expirationYear, card.CCV] delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    }
    
    else {
        
        NSString *helpfulMessage = @"Something went wrong!";
        
        if (!ValidCCV) {
            helpfulMessage = [helpfulMessage stringByAppendingString:@" The CCV looks invalid."];
        }
        if (!ValidDate) {
            helpfulMessage = [helpfulMessage stringByAppendingString:@" The Expiration Date looks invalid."];
        }
        if (!ValidNumber || !ValidLuhn) {
            helpfulMessage = [helpfulMessage stringByAppendingString:@" The Card Number looks invalid."];
        }
        
        helpfulMessage = [helpfulMessage stringByAppendingString:@"Try again!"];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Uh, oh!" message:helpfulMessage delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil];
    }
    
    return alert;
}

- (void) wipeData {
    self.cardNumberField.text = @"";
    self.cardExpField.text = @"";
    self.cardCCVField.text = @"";
    
    [cardNumber setNumber:@""];
    [cardCCV setCCV:@""];
    [cardExp setExpDate:@""];
    [card setNumber:@""];
    
    [card setCardImage:[UIImage imageNamed:@"GenericCard"]];
    
    [self cardImageTransitionWithImage:card.cardImage];
    [self.cardNumberField becomeFirstResponder];
}
                                             


- (void) configureView {
    self.topFieldBackgroundView.layer.cornerRadius = 5;
    self.topFieldBackgroundView.layer.masksToBounds = YES;
    
    self.bottomFieldBackgroundView.layer.cornerRadius = 5;
    self.bottomFieldBackgroundView.layer.masksToBounds = YES;
    
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;

    [self.submitButton setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:108.0/255.0 alpha:0.5]];
    
    [self.submitButton setTitleColor:[UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:198.0/255.0 alpha:0.5] forState:UIControlStateDisabled];
}

- (NSString *) displayCardNumberBack {
    
    NSString *numForPrivacy;
    
    // put * for everything but last 4, unless it's amex, in which case, don't obscure,
    // but at least format appropriately

    if ([cardNumber cardType] == Amex) {
        
        NSRange firstSix = NSMakeRange(3, 6);
        
        numForPrivacy = [NSString stringWithFormat:@"%@ %@ %@",
                        [cardNumber.number substringToIndex:3],
                        [cardNumber.number substringWithRange:firstSix],
                        [cardNumber.number substringFromIndex:9]]
        ;
    }
                         
    else {
        numForPrivacy = [NSString stringWithFormat:@"**** **** **** %@", [card.number substringFromIndex:12]];
    }
    
    return numForPrivacy;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
