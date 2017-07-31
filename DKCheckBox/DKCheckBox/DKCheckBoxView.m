//
//  DKCheckBoxView.m
//  DKCheckBox
//
//  Created by NSLog on 2017/7/29.
//  Copyright © 2017年 DK-Coder. All rights reserved.
//

#import "DKCheckBoxView.h"
#import "UIImage+DKExtension.h"

@interface DKCheckBoxView ()
{
    
}
@property (nonatomic, strong) UIImage *unCheckedImage;
@property (nonatomic, strong) UIImage *checkedImage;
@property (nonatomic, strong) UIButton *checkBoxButton;
@property (nonatomic, strong) UILabel *checkBoxLabel;
@end


@implementation DKCheckBoxView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self sharedInit];
    }
    return self;
}

- (void)sharedInit
{
    self.dk_checkBoxImageType = DKCheckBoxImageTypeCircle;
    self.dk_changeCheckboxStatusWhenTextClicked = YES;
    self.checkboxSelected = NO;
    self.dk_checkBoxTextColor = [UIColor blackColor];
    self.dk_checkBoxTextFont = [UIFont systemFontOfSize:14.f];
    
    [self addSubview:self.checkBoxButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.frame);
    self.checkBoxButton.frame = CGRectMake(0.f, 0.f, height, height);
    
    if (self.dk_checkBoxText && self.dk_checkBoxText.length > 0) {
        CGFloat gapBetweenButtonAndLabel = 5.f;
        _checkBoxLabel.frame = CGRectMake(height + gapBetweenButtonAndLabel, 0.f, CGRectGetWidth(self.frame) - CGRectGetMaxX(self.checkBoxButton.frame) - gapBetweenButtonAndLabel, height);
    } else {
        [self removeGestureOnLabel];
        [self.checkBoxLabel removeFromSuperview];
        self.checkBoxLabel = nil;
    }
}

#pragma mark - 内部方法
- (void)checkBoxButtonPressed
{
    self.checkboxSelected = !self.isCheckboxSelected;
    if (self.dk_checkBoxDelegate && [self.dk_checkBoxDelegate respondsToSelector:@selector(checkboxView:didClickOnCheckBox:atIndexPath:)]) {
        [self.dk_checkBoxDelegate checkboxView:self didClickOnCheckBox:self.checkboxSelected atIndexPath:self.dk_indexPath];
    }
}

- (void)checkBoxLabelPressed
{
    if (self.isDk_changeCheckboxStatusWhenTextClicked) {
        [self checkBoxButtonPressed];
    } else {
        if (self.dk_checkBoxDelegate && [self.dk_checkBoxDelegate respondsToSelector:@selector(didClickOnLabelInCheckboxView:atIndexPath:)]) {
            [self.dk_checkBoxDelegate didClickOnLabelInCheckboxView:self atIndexPath:self.dk_indexPath];
        }
    }
}

- (void)setupImageNameByType
{
    switch (self.dk_checkBoxImageType) {
        case DKCheckBoxImageTypeCircle:
            self.dk_checkBoxUncheckedImageName  = @"Images.bundle/checkbox-circle-unchecked";
            self.dk_checkBoxCheckedImageName    = @"Images.bundle/checkbox-circle-checked";
            break;
        case DKCheckBoxImageTypeSquareUnfilled:
            self.dk_checkBoxUncheckedImageName  = @"Images.bundle/checkbox-square-unfilled-unchecked";
            self.dk_checkBoxCheckedImageName    = @"Images.bundle/checkbox-square-unfilled-checked";
            break;
        case DKCheckBoxImageTypeSquareFilled:
            self.dk_checkBoxUncheckedImageName  = @"Images.bundle/checkbox-square-filled-unchecked";
            self.dk_checkBoxCheckedImageName    = @"Images.bundle/checkbox-square-filled-checked";
            break;
        case DKCheckBoxImageTypeCustom:
            break;
    }
}

- (void)addGestureOnLabelDependsOnWhetherChangeCheckboxStatusWhenTextClicked
{
    [self removeGestureOnLabel];
    
    self.checkBoxLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkBoxLabelPressed)];
    [self.checkBoxLabel addGestureRecognizer:tapGesture];
}

- (void)removeGestureOnLabel
{
    NSArray *gestures = self.checkBoxLabel.gestureRecognizers;
    for (UIGestureRecognizer *gesture in gestures) {
        if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
            return;
        }
    }
}

#pragma mark - getter
- (UIButton *)checkBoxButton
{
    if (!_checkBoxButton) {
        _checkBoxButton = [[UIButton alloc] init];
        _checkBoxButton.adjustsImageWhenHighlighted = NO;
        [_checkBoxButton addTarget:self action:@selector(checkBoxButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkBoxButton;
}

- (UILabel *)checkBoxLabel
{
    if (!_checkBoxLabel) {
        _checkBoxLabel = [[UILabel alloc] init];
        _checkBoxLabel.text = self.dk_checkBoxText;
        _checkBoxLabel.textColor = self.dk_checkBoxTextColor;
        _checkBoxLabel.font = self.dk_checkBoxTextFont;
        _checkBoxLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:_checkBoxLabel];
    }
    return _checkBoxLabel;
}

#pragma mark - setter
- (void)setDk_checkBoxImageType:(DKCheckBoxImageType)dk_checkBoxImageType
{
    _dk_checkBoxImageType = dk_checkBoxImageType;
    
    [self setupImageNameByType];
}

- (void)setDk_checkBoxUncheckedImageName:(NSString *)dk_checkBoxUncheckedImageName
{
    if (dk_checkBoxUncheckedImageName && dk_checkBoxUncheckedImageName.length > 0) {
        _dk_checkBoxUncheckedImageName = dk_checkBoxUncheckedImageName;
        
        self.unCheckedImage = [UIImage imageNamed:dk_checkBoxUncheckedImageName];
        if (self.dk_checkBoxImageColor) {
            self.unCheckedImage = [self.unCheckedImage changeImageColorTo:self.dk_checkBoxImageColor];
        }
    }
}

- (void)setDk_checkBoxCheckedImageName:(NSString *)dk_checkBoxCheckedImageName
{
    if (dk_checkBoxCheckedImageName && dk_checkBoxCheckedImageName.length > 0) {
        _dk_checkBoxCheckedImageName = dk_checkBoxCheckedImageName;
        
        self.checkedImage = [UIImage imageNamed:dk_checkBoxCheckedImageName];
        if (self.dk_checkBoxImageColor) {
            self.checkedImage = [self.checkedImage changeImageColorTo:self.dk_checkBoxImageColor];
        }
    }
}

- (void)setDk_checkBoxImageColor:(UIColor *)dk_checkBoxImageColor
{
    _dk_checkBoxImageColor = dk_checkBoxImageColor;
    
    self.unCheckedImage = [self.unCheckedImage changeImageColorTo:self.dk_checkBoxImageColor];
    self.checkedImage = [self.checkedImage changeImageColorTo:self.dk_checkBoxImageColor];
}

- (void)setDk_checkBoxText:(NSString *)dk_checkBoxText
{
    _dk_checkBoxText = dk_checkBoxText;
    
    self.checkBoxLabel.text = dk_checkBoxText;
}

- (void)setDk_checkBoxTextColor:(UIColor *)dk_checkBoxTextColor
{
    _dk_checkBoxTextColor = dk_checkBoxTextColor;
    
    self.checkBoxLabel.textColor = dk_checkBoxTextColor;
}

- (void)setDk_checkBoxTextFont:(UIFont *)dk_checkBoxTextFont
{
    _dk_checkBoxTextFont = dk_checkBoxTextFont;
    
    self.checkBoxLabel.font = dk_checkBoxTextFont;
}

- (void)setDk_changeCheckboxStatusWhenTextClicked:(BOOL)dk_changeCheckboxStatusWhenTextClicked
{
    _dk_changeCheckboxStatusWhenTextClicked = dk_changeCheckboxStatusWhenTextClicked;
    
    [self addGestureOnLabelDependsOnWhetherChangeCheckboxStatusWhenTextClicked];
}

- (void)setCheckboxSelected:(BOOL)checkboxSelected
{
    _checkboxSelected = checkboxSelected;
    
    [self.checkBoxButton setImage:(checkboxSelected ? self.checkedImage : self.unCheckedImage) forState:UIControlStateNormal];
}

- (void)setUnCheckedImage:(UIImage *)unCheckedImage
{
    _unCheckedImage = unCheckedImage;
    
    [self.checkBoxButton setImage:self.unCheckedImage forState:UIControlStateNormal];
}
@end
