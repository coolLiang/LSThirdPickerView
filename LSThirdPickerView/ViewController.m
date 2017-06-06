//
//  ViewController.m
//  LSThirdPickerView
//
//  Created by noci on 2017/6/6.
//  Copyright © 2017年 noci. All rights reserved.
//

#import "ViewController.h"

#import "LSThirdPickerView.h"

@interface ViewController ()<LSThirdPickerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LSThirdPickerView * picker = [[LSThirdPickerView alloc]initWithFrame:self.view.bounds];
    
    picker.delegate = self;
    
    [self.view addSubview:picker];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)onClickTheCancelButton
{
    
}

-(void)onClickTheCoverButton
{
    
}

-(void)onClickTheConfirmButtonWithAddress:(NSString *)title
{
    NSLog(@"%@",title);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
