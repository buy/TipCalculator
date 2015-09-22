//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Chang Liu on 9/21/15.
//  Copyright © 2015 Chang Liu. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *settingsMinTipPercent;
@property (weak, nonatomic) IBOutlet UITextField *settingsMaxTipPercent;
@property (weak, nonatomic) IBOutlet UITextField *settingsDefaultTipPercent;
@property (nonatomic) NSUserDefaults *userDefaults;

- (void)fetchUserDefaults;
- (void)saveUserDefaults;

- (IBAction)valuesChanged:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userDefaults = [NSUserDefaults standardUserDefaults];
    [self fetchUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fetchUserDefaults {
    if ([self.userDefaults valueForKey:@"tipcalculator_settings_default_tip_percent"]) {
        self.settingsMinTipPercent.text = [NSString stringWithFormat:@"%@", [self.userDefaults valueForKey:@"tipcalculator_settings_min_tip_percent"]];
        self.settingsMaxTipPercent.text = [NSString stringWithFormat:@"%@", [self.userDefaults valueForKey:@"tipcalculator_settings_max_tip_percent"]];
        self.settingsDefaultTipPercent.text = [NSString stringWithFormat:@"%@", [self.userDefaults valueForKey:@"tipcalculator_settings_default_tip_percent"]];
    }
}

- (void)saveUserDefaults {
    [self.userDefaults setValue:self.settingsMinTipPercent.text forKey:@"tipcalculator_settings_min_tip_percent"];
    [self.userDefaults setValue:self.settingsMaxTipPercent.text forKey:@"tipcalculator_settings_max_tip_percent"];
    [self.userDefaults setValue:self.settingsDefaultTipPercent.text forKey:@"tipcalculator_settings_default_tip_percent"];
    [self.userDefaults synchronize];
}

- (IBAction)valuesChanged:(id)sender {
    [self saveUserDefaults];
}

@end
