//
//  ResultActivityViewController.m
//  WeatherForcast
//
//  Created by Benny Dalby on 11/17/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import "ResultActivityViewController.h"
#import "ResultTableViewCell.h"
#import  "DeailActivityViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MapViewController.h"


@interface ResultActivityViewController ()

@end

@implementation ResultActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _result_Tableview.delegate=self;
    _result_Tableview.dataSource=self ;
    
    listOfitems=[[NSArray alloc]initWithObjects:@"Percipitation",@"Chance of Rain",@"Wind Speed",@"Dew Point",@"Humidity",@"Visibility",@"Sunrise",@"Sunset",nil];
    
    [self weather_SummaryUpdate];
    _moreDetails.layer.cornerRadius=5.0 ;
    _viewMap.layer.cornerRadius=5.0;
 
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

-(void)weather_SummaryUpdate
{
    NSDictionary *currently = [_jsondata objectForKey:@"currently"];
    NSString *icon ;
    UIImage *icon_image ;
    NSString *timeZone ;

    if (currently)
    {
    
    icon = [currently objectForKey:@"icon"] ;
    
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
    
    _weather_summary.image=icon_image ;
    timeZone = [_jsondata objectForKey:@"timezone"];
    NSArray *areas = [timeZone componentsSeparatedByString:@"/"];
    NSString *current_Summary = [currently objectForKey:@"summary"] ;
    int temperature_value=[[currently objectForKey:@"temperature"]intValue];
    _temperature.text=[NSString stringWithFormat:@"%d",temperature_value];
    if (_isFareh) {
        
        _degree.text=@"F";
    }
    
    else
    {
        _degree.text=@"C" ;
    }
    
    if ([areas count]==2) {
        
           _summary_description.text = [NSString stringWithFormat:@"%@ in %@, %@",current_Summary,[areas objectAtIndex:1],[areas objectAtIndex:0]];
        
    }
    
    NSDictionary *daily=[_jsondata objectForKey:@"daily"];
    NSArray *data=[daily objectForKey:@"data"];
    NSDictionary *contents =[data objectAtIndex:0];
    
    _low_temp.text=[NSString stringWithFormat:@"L:%d",[[contents objectForKey:@"temperatureMin"]intValue]];
    
    _high_temp.text=[NSString stringWithFormat:@"H:%d",[[contents objectForKey:@"temperatureMax"]intValue]];
 
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell" ;
    
    ResultTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ResultTableViewCell" owner:self options:nil];
    // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
    }
    
     cell.topicLabel.text=[listOfitems objectAtIndex:indexPath.row] ;
    int precipitation;
    int perp_probability = 0, humidity=0;
    float windSpeed=0.0,dewPoint=0.0, visibility=0.0 ;
    
    NSDictionary *currently = [_jsondata objectForKey:@"currently"];
    NSString *stringFromDate_rise,*stringFromDate_set;
    if (currently)
    {
       precipitation = [[currently objectForKey:@"precipIntensity"] intValue];
       perp_probability = [[currently objectForKey:@"precipProbability"]intValue]*100 ;
        windSpeed=[[currently objectForKey:@"windSpeed"]floatValue];
         dewPoint=[[currently objectForKey:@"dewPoint"]floatValue];
          humidity = [[currently objectForKey:@"humidity"]intValue]*100 ;
        visibility=[[currently objectForKey:@"visibility"]floatValue];
        NSString *timeZone = [_jsondata objectForKey:@"timezone"];
        
        NSDictionary *daily=[_jsondata objectForKey:@"daily"];
        NSArray *data=[daily objectForKey:@"data"];
        NSDictionary *contents =[data objectAtIndex:0];
        int sunrisetime_string = [[contents objectForKey:@"sunriseTime"]intValue];
        int sunsettime_string = [[contents objectForKey:@"sunsetTime"]intValue];
        
       
        
        NSDate *rise_date = [NSDate dateWithTimeIntervalSince1970:sunrisetime_string];
        NSDate *set_date = [NSDate dateWithTimeIntervalSince1970:sunsettime_string];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
        
        [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:timeZone]];
        
       stringFromDate_rise = [formatter stringFromDate:rise_date];
        stringFromDate_set = [formatter stringFromDate:set_date];

        
        
        
    }
 
    
    
    NSString *percp_Value = [self percValueCheck:precipitation] ;
    
    if (indexPath.row%2==0) {
        cell.contentView.backgroundColor=[UIColor colorWithRed:130/255.0 green:130/255.0 blue:130/255.0 alpha:1.0];
        
    }
    
    else
    {
        cell.contentView.backgroundColor=[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1.0];

    }
  
    
    
    if (indexPath.row==0)
    {
        cell.answerLabel.text=percp_Value ;
    }
    
    if(indexPath.row==1)
    {
        cell.answerLabel.text=[NSString stringWithFormat:@"%d%%",perp_probability];
    }
    
    if (indexPath.row==2) {
        
        cell.answerLabel.text=[NSString stringWithFormat:@"%.2f%%",windSpeed];

        
    }
    
    if (indexPath.row==3) {
        
        cell.answerLabel.text=[NSString stringWithFormat:@"%.2f%%",dewPoint];
        
    }
    
    if (indexPath.row==4) {
        
         cell.answerLabel.text=[NSString stringWithFormat:@"%d%%",humidity];
    }
    
    if (indexPath.row==5) {
        
        cell.answerLabel.text=[NSString stringWithFormat:@"%.2f%%",visibility];
        
    }
    
    if (indexPath.row==6) {
        
        int value = [stringFromDate_rise intValue];
        if(value<12)
        cell.answerLabel.text=[NSString stringWithFormat:@"%@",stringFromDate_rise];
        
        else
        {
            value=value-12 ;
            cell.answerLabel.text=[NSString stringWithFormat:@"%@ ",stringFromDate_rise];
        }

        
    }
    
    if (indexPath.row==7) {
        
        int value = [stringFromDate_set intValue];
        if(value<12)
            cell.answerLabel.text=[NSString stringWithFormat:@"%@ ",stringFromDate_set];
        
        else
        {
            value=value-12 ;
            cell.answerLabel.text=[NSString stringWithFormat:@"%@ ",stringFromDate_set];
        }
    }
    
    
    
    return cell;
    

    
}

-(NSString *)percValueCheck:(int) precipitation
{
    NSString * percp_Value ;
    if(precipitation>=0 && precipitation<0.002)
    {
        percp_Value=@"None" ;
    }
    else if(precipitation>=0.002 && precipitation<0.017)
    {
        percp_Value=@"Very Light" ;
    }
    else if(precipitation>=0.017 && precipitation<0.1)
    {
        percp_Value=@"Light" ;
    }
    else if(precipitation>=0.1 && precipitation<0.4)
    {
        percp_Value=@"Moderate" ;
    }
    else if(precipitation>=0.04)
    {
        percp_Value=@"Heavy" ;
    }

    return percp_Value ;
}
- (IBAction)moreDeatilsButton:(id)sender
{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DeailActivityViewController *resultActivity = [storyBoard instantiateViewControllerWithIdentifier:@"DeailActivityViewController"];
    //Do whatever with the viewcontroller object
    resultActivity.jsondata=[_jsondata mutableCopy];
    resultActivity.isFareh=self.isFareh ;
    [self.navigationController pushViewController:resultActivity animated:YES ];
    
}

- (IBAction)backbuttonPressed:(id)sender
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}
- (IBAction)map_buttonPressed:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MapViewController *resultActivity = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    //Do whatever with the viewcontroller object
   // resultActivity.jsondata=[_jsondata mutableCopy];
   // resultActivity.isFareh=self.isFareh ;
    [self.navigationController pushViewController:resultActivity animated:YES ];
    
    
}

@end
