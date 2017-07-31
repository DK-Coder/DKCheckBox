//
//  DKCheckBoxView.h
//  DKCheckBox
//
//  Created by NSLog on 2017/7/29.
//  Copyright © 2017年 DK-Coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKCheckBoxView;
@protocol DKCheckBoxViewDelegate <NSObject>

@optional
- (void)checkboxView:(DKCheckBoxView * _Nonnull)checkbox didClickOnCheckBox:(BOOL)isSelected atIndexPath:(NSIndexPath * __nullable)indexPath;
- (void)didClickOnLabelInCheckboxView:(DKCheckBoxView * _Nonnull)checkbox atIndexPath:(NSIndexPath * __nullable)indexPath;

@end

typedef NS_ENUM(NSUInteger, DKCheckBoxImageType) {
    DKCheckBoxImageTypeCircle,
    DKCheckBoxImageTypeSquareUnfilled,
    DKCheckBoxImageTypeSquareFilled,
    DKCheckBoxImageTypeCustom
};

@interface DKCheckBoxView : UIView

/**
 * 复选框图片的类型
 * 如果想使用自定义的图片，请务必设置为DKCheckBoxImageTypeCustom
 */
@property (nonatomic) DKCheckBoxImageType dk_checkBoxImageType;

/**
 * 复选框未选中状态下显示的图片名称
 */
@property (nonnull, nonatomic, copy) NSString *dk_checkBoxUncheckedImageName;

/**
 * 复选框选中状态下显示的图片名称
 */
@property (nonnull, nonatomic, copy) NSString *dk_checkBoxCheckedImageName;

/**
 * 复选框图片显示的颜色
 */
@property (nonnull, nonatomic, strong) UIColor *dk_checkBoxImageColor;

/**
 * 复选框后显示的文字
 */
@property (nullable, nonatomic, copy) NSString *dk_checkBoxText;

/**
 * 复选框后显示的文字颜色
 */
@property (nonnull, nonatomic, strong) UIColor *dk_checkBoxTextColor;

/**
 * 复选框后显示的文字字体
 */
@property (nonnull, nonatomic, strong) UIFont *dk_checkBoxTextFont;

/**
 * 点击文字后，复选框状态会发生变化，默认是YES
 * 如果为NO，当点击文字后，复选框不会发生变化
 */
@property (nonatomic, getter=isDk_changeCheckboxStatusWhenTextClicked) BOOL dk_changeCheckboxStatusWhenTextClicked;

@property (nonatomic, getter=isCheckboxSelected) BOOL checkboxSelected;

@property (nullable, nonatomic, weak) id<DKCheckBoxViewDelegate> dk_checkBoxDelegate;

/**
 * 如果checkbox用在table的cell中，可以记录这个cell在tableview中具体位置
 */
@property (nullable, nonatomic, strong) NSIndexPath *dk_indexPath;
@end
