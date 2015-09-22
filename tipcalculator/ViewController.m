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

- (void)fetchUserDefaults;
- (void)updateValues;

- (IBAction)valuesChanged:(id)sender;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.billTextField becomeFirstResponder];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self fetchUserDefaults];
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipPercent = (int)self.tipControl.value;
    float tipAmount = billAmount * tipPercent / 100.0;
    float totalAmount = billAmount + tipAmount;
    
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%0.0f%%", tipPercent];
    self.tipLabel.text = [NSString stringWithFormat:@"%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%0.2f", totalAmount];
}

- (void)fetchUserDefaults {
    if ([[self.userDefaults valueForKey:@"tipcalculator_settings_default_tip_percent"] floatValue]) {
        self.tipControl.minimumValue = [[self.userDefaults valueForKey:@"tipcalculator_settings_min_tip_percent"] floatValue];
        self.tipControl.maximumValue = [[self.userDefaults valueForKey:@"tipcalculator_settings_max_tip_percent"] floatValue];
        self.tipControl.value = [[self.userDefaults valueForKey:@"tipcalculator_settings_default_tip_percent"] floatValue];
    }
}

- (IBAction)valuesChanged:(id)sender {
    [self updateValues];
}

@end
