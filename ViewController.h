//
//  ViewController.h
//  WeatherForcast
//
//  Created by Benny Dalby on 11/16/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultActivityViewController.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSArray *populate_pickerArray ;
    
}
@property (weak, nonatomic) IBOutlet UITextField *street;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UIPickerView *state;
@property (weak, nonatomic) IBOutlet UISwitch *farenheit;
@property (weak, nonatomic) IBOutlet UISwitch *celsius;
@property (weak, nonatomic) IBOutlet UIButton *search;
@property (weak, nonatomic) IBOutlet UIButton *clear;
@property (weak, nonatomic) IBOutlet UILabel *condition_street;
@property (weak, nonatomic) IBOutlet UILabel *condition_city;
@property (weak, nonatomic) IBOutlet UILabel *condition_state;
@property (weak, nonatomic) IBOutlet UIButton *about_button;




@end

