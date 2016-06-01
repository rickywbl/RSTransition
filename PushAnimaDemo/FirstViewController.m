//
//  FirstViewController.m
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/30.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "FirstViewController.h"
#import "PushAnimationTest.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *iv =[[UIImageView alloc]initWithFrame:self.view.bounds];
    
    [iv setImage:[UIImage imageNamed:@"34fae6cd7b899e5172586cfd47a7d933c9950d00"]];
    [self.view addSubview:iv];
    
    
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

@end
