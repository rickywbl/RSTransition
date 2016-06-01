//
//  SecondViewController.m
//  PushAnimaDemo
//
//  Created by 王保霖 on 16/5/31.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    self.musicImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200,200)];
    self.musicImageView.image =[UIImage imageNamed:@"back0"];
    self.musicImageView.layer.cornerRadius = 100;
    self.musicImageView.clipsToBounds = YES;
    self.musicImageView.center = self.view.center;
    [self.view addSubview:self.musicImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2-50, 100, 100, 50);
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(dis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}

-(void)dis{

    [self dismissViewControllerAnimated:YES completion:nil];
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
