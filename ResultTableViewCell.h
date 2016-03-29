//
//  ResultTableViewCell.h
//  WeatherForcast
//
//  Created by Benny Dalby on 11/17/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
