//
//  ViewController.m
//  WeatherForcast
//
//  Created by Benny Dalby on 11/16/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import "ViewController.h"
#import "StudentIDViewController.h"
#import "ResultActivityViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.jpg"]];
    _street.delegate=self ;
    _city.delegate=self ;
    _farenheit.on=YES;
    _celsius.on=NO ;
    _state.delegate=self;
    _state.dataSource=self ;
    
    populate_pickerArray=[[NSArray alloc]initWithObjects:@"Select",@"Alabama",@"Alaska",@"Arkansas",@"California",@"Clorado",@"Connecticut",@"Delaware",@"District of Columbia",@"Florida",@"Georgia",@"Hawai",@"Idaho",@"Lowa",@"Kansas",@"Kentucky",@"Louisiana",@"Maine",@"Maryland",@"Massachusetts",@"Michigan",@"Minnesota",@"Mississippi",@"Montana",@"Nebraska",@"Nevada",@"New Hampshire",@"New Jersy",@"New Mexico",@"New York",@"New Carolina",@"New Dakota",@"Ohio",@"Oklahoma",@"Oregon",@"Pennsylvania",@"Rhode Island",@"South Carolina",@"South Dakota",@"Tennessee",@"Texes",@"Utah",@"Vermont",@"Virginia",@"Washington",@"West Virginia",@"Wisconsin",@"Wyoming", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchPressed:(id)sender {
    
    if([_street.text isEqualToString:(@"")])
    {
        _condition_street.hidden=NO ;
    }
    
    else
    {
        _condition_street.hidden=YES ;
    }
    
    if([_city.text isEqualToString:(@"")])
    {
        _condition_city.hidden=NO ;
    }
    else
    {
        _condition_city.hidden=YES ;
    }
    
    if ([_state selectedRowInComponent:0]==0) {
        
        _condition_state.hidden=NO ;
        
    }
    else
    {
        _condition_state.hidden=YES ;
    }
    
    
    if (_condition_street.hidden==YES && _condition_city.hidden==YES && _condition_state.hidden==YES)
    {
        NSString *finalURL;
        if (_farenheit.on) {
            
           finalURL =[NSString stringWithFormat:@"http://forcastweather-env.elasticbeanstalk.com/index.php?city1=%@&city=%@&temp=farenheit&search=on",_street.text,_city.text];
            
        }
        
        else
        {
             finalURL =[NSString stringWithFormat:@"http://forcastweather-env.elasticbeanstalk.com/index.php?city1=%@&city=%@&temp=celsius&search=on",_street.text,_city.text];
            
        }
        
        //NSString *finalURL = @"https://google.com" ;
         finalURL=[finalURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        NSURL *blogURL=[NSURL URLWithString:finalURL];
       
        
        NSData *jsonData = [NSData dataWithContentsOfURL:blogURL];
        NSError *error = nil;
        if (jsonData!=nil)
        {
            NSDictionary *dataDictionary = [NSJSONSerialization
                                            JSONObjectWithData:jsonData options:0 error:&error];
            
            
            NSLog(@"Sync JSON: %@", dataDictionary);
            
//            ResultActivityViewController *resultActivity =[self.storyboard instantiateViewControllerWithIdentifier:@"ResultActivityViewController"];
//            [self.navigationController pushViewController:resultActivity animated:YES];
            
            if (dataDictionary) {
                
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                ResultActivityViewController *resultActivity = [storyBoard instantiateViewControllerWithIdentifier:@"ResultActivityViewController"];
                //Do whatever with the viewcontroller object
                resultActivity.jsondata=[dataDictionary mutableCopy];
                
                resultActivity.isFareh=_farenheit.isOn ;
               
                [self.navigationController pushViewController:resultActivity animated:YES ];
                
            }
            
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Results"
                                                                message:@"Please enter a valid city name."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
            
            
            
        }
        
        
    }
  
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
   if(textField.tag==0)
   {
       _condition_street.hidden=YES ;
   }
    
    if (textField.tag==1)
    {
        _condition_city.hidden=YES ;
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if([_street.text isEqualToString:(@"")])
    {
        _condition_street.hidden=NO ;
    }
    
    else
    {
        _condition_street.hidden=YES ;
    }
    
    if([_city.text isEqualToString:(@"")])
    {
        _condition_city.hidden=NO ;
    }
    else
    {
        _condition_city.hidden=YES ;
    }

    
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)clearPressed:(id)sender {
    
    _street.text=@"";
    _city.text=@"" ;
    _condition_street.hidden=YES;
    _condition_city.hidden=YES ;
    _condition_state.hidden=YES ;
}

- (IBAction)farenheitPressed:(id)sender {
    
    if (_farenheit.isOn)
    {
        _farenheit.on=YES;
        _celsius.on=NO ;
        
    }
    
    else
    {
        _farenheit.on=NO;
        _celsius.on=YES ;
    }
    
    
    
}
- (IBAction)degreePressed:(id)sender {
    
    if (_celsius.isOn)
    {
        _farenheit.on=NO;
        _celsius.on=YES ;
        
    }
    
    else
    {
        _farenheit.on=YES;
        _celsius.on=NO ;
    }
    
    
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1 ;
    
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [populate_pickerArray count] ;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [populate_pickerArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row==0)
    {
        _condition_state.hidden=NO;
    }
    
    else
    {
        _condition_state.hidden=YES ;
    }
}



@end
