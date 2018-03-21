//
//  ViewController.m
//  Linkage
//
//  Created by 曹世鑫 on 2018/3/20.
//  Copyright © 2018年 曹世鑫. All rights reserved.
//

#import "ViewController.h"
#import "CSLinkageOne.h"
#import "CSLinkageTwo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"联动";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 120, 200, 40);
    [button setTitle:@"tableview与tableview联动" forState:UIControlStateNormal];
    [button setTintColor:[UIColor cyanColor]];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    [button addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    button1.frame = CGRectMake(20, 180, 200, 40);
    [button1 setTitle:@"tableview与collection联动" forState:UIControlStateNormal];
    [button1 setTintColor:[UIColor cyanColor]];
    [button1 setBackgroundColor:[UIColor lightGrayColor]];
    [button1 addTarget:self action:@selector(buttonChoose1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
}
- (void)buttonChoose:(UIButton *)sender{
    [self.navigationController pushViewController:[CSLinkageOne new] animated:YES];
}
- (void)buttonChoose1:(UIButton *)sender{
    [self.navigationController pushViewController:[CSLinkageTwo new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
