//
//  LSThirdPickerView.h
//  LSThirdPickerView
//
//  Created by noci on 2017/6/6.
//  Copyright © 2017年 noci. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LSThirdPickerViewDelegate <NSObject>

-(void)onClickTheCoverButton;

-(void)onClickTheCancelButton;

-(void)onClickTheConfirmButtonWithAddress:(NSString *)title;

@end

@interface LSThirdPickerView : UIView

+(instancetype)setupLSThirdPickerView;

@property(nonatomic,weak)id delegate;

@end
