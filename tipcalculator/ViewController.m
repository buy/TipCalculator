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

- (IBAction)valuesChanged:(id)sender;
- (void)updateValues;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.billTextField becomeFirstResponder];
    [self updateValues];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)valuesChanged:(id)sender {
    [self updateValues];
}

- (void)updateValues {
    float billAmount = [self.billTextField.text floatValue];
    float tipPercent = self.tipControl.value;
    float tipAmount = billAmount * tipPercent;
    float totalAmount = billAmount + tipAmount;
    
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%0.0f%%", tipPercent * 100];
    self.tipLabel.text = [NSString stringWithFormat:@"%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%0.2f", totalAmount];
}

@end
