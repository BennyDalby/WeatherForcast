//
//  DeailActivityViewController.m
//  WeatherForcast
//
//  Created by Benny Dalby on 11/17/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import "DeailActivityViewController.h"
#import "Next24HrsTableViewCell.h"
#import "Next7DaysTableViewCell.h"

@interface DeailActivityViewController ()

@end

@implementation DeailActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _hrs_tableView.delegate=self;
    _hrs_tableView.dataSource=self;
    
    _days_tableView.delegate=self;
    _days_tableView.dataSource=self ;
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont fontWithName:@"Helvetica" size:17], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [_segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(UIImage *)weather_SummaryUpdate:(NSInteger)row
{
    NSDictionary *currently = [_jsondata objectForKey:@"currently"];
    NSString *icon ;
    UIImage *icon_image ;
    NSString *timeZone ;
    
    NSDictionary *daily=[_jsondata objectForKey:@"hourly"];
    NSArray *data=[daily objectForKey:@"data"];
    NSLog(@"row value is %ld",row);
    NSDictionary *contents =[data objectAtIndex:row];
    
    if (contents)
    {
        
        icon = [contents objectForKey:@"icon"] ;
        
        if ([icon isEqual:@"clear-day"]) {
            
            icon_image=[UIImage imageNamed:@"clear.png"];
            
        }
        
        else if ([icon isEqual:@"clear-night"]) {
            
            icon_image=[UIImage imageNamed:@"clear_night.png"];
            
        }
        
        else if ([icon isEqual:@"rain"]) {
            
            icon_image=[UIImage imageNamed:@"rain.png"];
            
        }
        
        else if ([icon isEqual:@"snow"]) {
            
            icon_image=[UIImage imageNamed:@"snow.png"];
            
        }
        
        else if ([icon isEqual:@"sleet"]) {
            
            icon_image=[UIImage imageNamed:@"sleet.png"];
            
        }
        
        else if ([icon isEqual:@"wind"]) {
            
            icon_image=[UIImage imageNamed:@"wind.png"];
            
        }
        
        else if ([icon isEqual:@"fog"]) {
            
            icon_image=[UIImage imageNamed:@"fog.png"];
            
        }
        
        else if ([icon isEqual:@"cloudy"]) {
            
            icon_image=[UIImage imageNamed:@"cloudy.png"];
            
        }
        
        else if ([icon isEqual:@"partly-cloudy-day"]) {
            
            icon_image=[UIImage imageNamed:@"cloud_day.png"];
            
        }
        
        else if ([icon isEqual:@"partly-cloudy-night"]) {
            
            icon_image=[UIImage imageNamed:@"cloud_night.png"];
            
        }
        
    }
    
   // _weather_summary.image=icon_image ;
    timeZone = [_jsondata objectForKey:@"timezone"];
//    NSArray *areas = [timeZone componentsSeparatedByString:@"/"];
//    NSString *current_Summary = [currently objectForKey:@"summary"] ;
//    
    
    return icon_image ;
}

-(NSString *)timehourly:(NSInteger)row
{
    NSDictionary *daily=[_jsondata objectForKey:@"hourly"];
    NSArray *data=[daily objectForKey:@"data"];
    NSLog(@"row value is %ld",row);
    NSDictionary *contents =[data objectAtIndex:row];
    
    int time = [[contents objectForKey:@"time"]intValue];
     NSString *timeZone = [_jsondata objectForKey:@"timezone"];
    
    NSDate *rise_date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
    
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
    
    return ([formatter stringFromDate:rise_date]);

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==10) {
        return 24 ;
        
    }
    else
    {
        return 7 ;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Next24HrsTableViewCell *cell24 ;
    Next7DaysTableViewCell *cell7 ;
    
    if (tableView.tag==10) {
        
        static NSString *CellIdentifier = @"cell" ;
        
        
         cell24= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        NSDictionary *currently = [_jsondata objectForKey:@"hourly"];
        NSDictionary *data = [currently objectForKey:@"data"];
        
        if (cell24 == nil)
        {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Next24HrsTableViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell24 = [topLevelObjects objectAtIndex:0];
            
        
        }
        
        cell24.summary_icon.image=[self weather_SummaryUpdate:indexPath.row];
        cell24.time.text = [self timehourly:indexPath.row];
       // cell24.time.text=@"Hello";

        return cell24;
    }
    
    else
    {
        static NSString *CellIdentifier = @"cell" ;
        
        cell7= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell7 == nil)
        {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Next7DaysTableViewCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell7 = [topLevelObjects objectAtIndex:0];
            
           
        }
        
        
        
    }
    
    
    return cell7 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag==11)
    {
        return 90;
    }
    
    else
    {
        return 60 ;
    }
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==10) {
        
        NSString *time = @"Time" ;
        NSString *summary = @"Summary" ;
        NSString *temp = @"Temp(F)" ;
        
        return [NSString stringWithFormat:@"%@            %@               %@",time,summary,temp] ;

        
    }
    
    else
    {
        return @"" ;
    }
    
    
}


- (IBAction)segment_buttonPressed:(id)sender
{
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    
    switch (segment.selectedSegmentIndex) {
        case 0:
            _next24hrs.hidden=NO;
            _next7days.hidden=YES ;
            break;
        case 1:
            _next24hrs.hidden=YES;
            _next7days.hidden=NO ;
            break;
        default:
            break;
    }
    
}
- (IBAction)backButtonPressed:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}



@end
