//
//  LSThirdPickerView.m
//  LSThirdPickerView
//
//  Created by noci on 2017/6/6.
//  Copyright © 2017年 noci. All rights reserved.
//

#import "LSThirdPickerView.h"

@interface LSThirdPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIButton * coverButton;

@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)UIPickerView * pickerView;

@property(nonatomic,strong)NSArray * allProvinceArray;

@property(nonatomic,strong)NSArray * allCityArray;

@property(nonatomic,strong)NSArray * chooseArray;


@property(nonatomic,strong)UIButton * cancelButton;

@property(nonatomic,strong)UIButton * confirmButton;

@end

@implementation LSThirdPickerView

+(instancetype)setupLSThirdPickerView
{
    return [[self alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = frame;
        
        [self buildData];
        [self buildUI];
        [self buildCS];
    }
    return self;
}

-(void)buildData
{
    NSArray * allDataArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"TotalArea" ofType:@"plist"]];
    
    self.allProvinceArray = [allDataArray valueForKey:@"ProvinceName"];
    
    self.allCityArray = [allDataArray valueForKey:@"City"];
    
    self.chooseArray = [self.allCityArray firstObject];
    
}

-(void)buildUI
{
    self.coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverButton.backgroundColor = [UIColor blackColor];
    self.coverButton.alpha = 0.7;
    self.coverButton.frame = self.bounds;
    [self addSubview:self.coverButton];
    
    
    self.contentView = [UIView new];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0, self.bounds.size.height - 250, self.bounds.size.width, 250);
    [self addSubview:self.contentView];
    
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    self.pickerView.frame = CGRectMake(0, self.contentView.frame.size.height - 200, self.contentView.frame.size.width, 200);
    
    [self.contentView addSubview:self.pickerView];
    
    //
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.confirmButton.frame = CGRectMake(self.contentView.frame.size.width - 80, 0, 80, 50);
    [self.contentView addSubview:self.confirmButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.cancelButton.frame = CGRectMake(0, 0, 80, 50);
    [self.contentView addSubview:self.cancelButton];
    
    UIView * view = [UIView new];
    view.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:view];
    
    view.frame = CGRectMake(0, 49, self.contentView.frame.size.width, 1);
    
    [self.coverButton addTarget:self action:@selector(coverButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.confirmButton addTarget:self action:@selector(confirmButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - actionDelegate
-(void)coverButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClickTheCoverButton)]) {
        
        [self.delegate onClickTheCoverButton];
    }
}

-(void)confirmButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClickTheConfirmButtonWithAddress:)]) {
        
        NSInteger provinceIndex = [self.pickerView selectedRowInComponent:0];
        NSString * province = self.allProvinceArray[provinceIndex];
        
        NSInteger cityIndex = [self.pickerView selectedRowInComponent:1];
        NSString * city = self.chooseArray[cityIndex][@"CityName"];
        
        NSInteger areaIndex = [self.pickerView selectedRowInComponent:2];
        NSString * area = self.chooseArray[cityIndex][@"District"][areaIndex][@"DistrictName"];
        
        NSString * allAddress = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
        
        [self.delegate onClickTheConfirmButtonWithAddress:allAddress];
    }
}

-(void)cancelButtonAction:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(onClickTheCancelButton)]) {
        
        [self.delegate onClickTheCancelButton];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        
        return self.allProvinceArray.count;
    }
    else if (component == 1)
    {
        return self.chooseArray.count;
    }
    else if (component == 2)
    {
        NSInteger index = [self.pickerView selectedRowInComponent:1];
        
        return [self.chooseArray[index][@"District"] count];
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        
        return self.allProvinceArray[row];
    }
    else if (component == 1)
    {
        return self.chooseArray[row][@"CityName"];
    }
    else if (component == 2)
    {
        NSInteger index = [self.pickerView selectedRowInComponent:1];
        
        return self.chooseArray[index][@"District"] [row][@"DistrictName"];

    }
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0)
    {
        self.chooseArray = self.allCityArray[row];
        
        [self.pickerView reloadComponent:1];
        
        [self.pickerView reloadComponent:2];
        
    }
    else if (component == 1)
    {
        [self.pickerView reloadComponent:2];
    }
    
}

-(void)buildCS
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
