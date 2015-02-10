//
//  ViewController.h
//  CardForm
//
//  Created by Lea Marolt on 2/7/15.
//  Copyright (c) 2015 Hellosunschein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardNumber.h"
#import "Card.h"
#import "CardCCV.h"
#import "CardExp.h"

@interface CardFormViewController : UIViewController <UITextFieldDelegate>

// PROPERTIES
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberField;
@property (weak, nonatomic) IBOutlet UITextField *cardExpField;
@property (weak, nonatomic) IBOutlet UITextField *cardCCVField;
@property (weak, nonatomic) IBOutlet UILabel *messageForUser;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *topFieldBackgroundView;
@property (weak, nonatomic) IBOutlet UIView *bottomFieldBackgroundView;

- (IBAction)submit:(id)sender;
- (IBAction) editingChanged:(id)sender;


@end

