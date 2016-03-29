//
//  DeailActivityViewController.h
//  WeatherForcast
//
//  Created by Benny Dalby on 11/17/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeailActivityViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UIView *next24hrs;
@property (weak, nonatomic) IBOutlet UIView *next7days;
@property (weak, nonatomic) IBOutlet UITableView *hrs_tableView;
@property (weak, nonatomic) IBOutlet UITableView *days_tableView;
@property (nonatomic) NSDictionary *jsondata ;
@property (nonatomic) BOOL isFareh ;

@end
