//
//  StudentIDViewController.m
//  WeatherForcast
//
//  Created by Benny Dalby on 11/16/15.
//  Copyright © 2015 Benny Dalby. All rights reserved.
//

#import "StudentIDViewController.h"

@interface StudentIDViewController ()

@end

@implementation StudentIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (IBAction)CloseButton:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];

}

@end
