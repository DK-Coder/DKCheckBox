//
//  ViewController.m
//  DKCheckBox
//
//  Created by NSLog on 2017/7/29.
//  Copyright © 2017年 DK-Coder. All rights reserved.
//

#import "ViewController.h"
#import "DKCheckBoxView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    DKCheckBoxView *checkbox = [[DKCheckBoxView alloc] initWithFrame:CGRectMake(20.f, 100.f, 120.f, 20.f)];
    checkbox.dk_checkBoxImageColor = [UIColor orangeColor];
    checkbox.dk_checkBoxText = @"同意条款";
    checkbox.dk_checkBoxTextColor = [UIColor orangeColor];
    [self.view addSubview:checkbox];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
