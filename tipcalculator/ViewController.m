//
//  ViewController.m
//  tipcalculator
//
//  Created by Chang Liu on 9/20/15.
//  Copyright © 2015 Chang Liu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISlider *tipControl;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (nonatomic) NSUserDefaults *userDefaults;

- (void)updateValues;
- (void)fetchUserDefaults;
- (void)fetchUserInputs;
- (void)saveUserInputs;

- (IBAction)billAmountChanged:(id)sender;
- (IBAction)tipPercentageChanged:(id)sender;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.billTextField becomeFirstResponder];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self fetchUserDefaults];
    [self fetchUserInputs];
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//calculate the tip and update the view
- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipPercent = (int)self.tipControl.value;
    float tipAmount = billAmount * tipPercent / 100.0;
    float totalAmount = billAmount + tipAmount;
    
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%0.0f%%", tipPercent];
    self.tipLabel.text = [NSString stringWithFormat:@"%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%0.2f", totalAmount];
}

//load user settings
- (void)fetchUserDefaults {
    if ([[self.userDefaults valueForKey:@"tipcalculator_settings_default_tip_percent"] floatValue]) {
        self.tipControl.minimumValue = [[self.userDefaults valueForKey:@"tipcalculator_settings_min_tip_percent"] floatValue];
        self.tipControl.maximumValue = [[self.userDefaults valueForKey:@"tipcalculator_settings_max_tip_percent"] floatValue];
        self.tipControl.value = [[self.userDefaults valueForKey:@"tipcalculator_settings_default_tip_percent"] floatValue];
    }
}

//fetch the last bill amount if user used the app within the last 10 mins
- (void)fetchUserInputs {
    NSTimeInterval timeSinceLastUse = [[NSDate date] timeIntervalSinceDate:[self.userDefaults objectForKey:@"tipcalculator_bill_text_field_expiration"]];

    if (timeSinceLastUse < 600) {
        self.billTextField.text = [self.userDefaults valueForKey:@"tipcalculator_bill_text_field"];
    }
}

//store the current user bill inputs
- (void)saveUserInputs {
    [self.userDefaults setValue:self.billTextField.text forKey:@"tipcalculator_bill_text_field"];
    [self.userDefaults setObject:[NSDate date] forKey:@"tipcalculator_bill_text_field_expiration"];
    [self.userDefaults synchronize];
}

- (IBAction)tipPercentageChanged:(id)sender {
    [self updateValues];
}

- (IBAction)billAmountChanged:(id)sender {
    [self updateValues];
    [self saveUserInputs];
}

@end
