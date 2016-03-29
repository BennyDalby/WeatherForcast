//
//  ResultActivityViewController.h
//  WeatherForcast
//
//  Created by Benny Dalby on 11/17/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultTableViewCell.h"

@interface ResultActivityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *listOfitems ;
}

@property (weak, nonatomic) IBOutlet UIButton *moreDetails;
@property (weak, nonatomic) IBOutlet UIButton *viewMap;
@property (weak, nonatomic) IBOutlet UIButton *fb_button;
@property (weak, nonatomic) IBOutlet UIImageView *weather_summary;
@property (weak, nonatomic) IBOutlet UILabel *summary_description;
@property (weak, nonatomic) IBOutlet UILabel *temperature;
@property (weak, nonatomic) IBOutlet UILabel *low_temp;
@property (weak, nonatomic) IBOutlet UILabel *high_temp;
@property (weak, nonatomic) IBOutlet UITableView *result_Tableview;
@property (nonatomic) NSDictionary *jsondata ;
@property (strong, nonatomic) IBOutlet UIView *bg_view;
@property (nonatomic) BOOL isFareh ;
@property (weak, nonatomic) IBOutlet UILabel *degree;

@end
