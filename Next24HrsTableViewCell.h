//
//  Next24HrsTableViewCell.h
//  WeatherForcast
//
//  Created by Benny Dalby on 11/17/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Next24HrsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIImageView *summary_icon;
@property (weak, nonatomic) IBOutlet UILabel *temp;

@end
