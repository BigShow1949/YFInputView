//
//  YFInputView.h
//  LoginLib
//
//  Created by BigShow on 2021/6/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, YFInputViewType) {
    YFInputViewTypeAccount,  // 账号
    YFInputViewTypePhoneNum, // 手机号
    YFInputViewTypePwd,      // 密码
    YFInputViewTypeCode,     // 验证码
};


@interface YFInputView : UIView
@property (nonatomic, assign) CGFloat leftMargin;
@property (nonatomic, assign) CGFloat rightMargin;

@property (nonatomic, assign) UIImage *leftImage;
@property (nonatomic, assign) UIImage *rightImage;
@property (nonatomic, assign) UIImage *rightSelectedImage;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *bottomLineColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic, strong) UIFont *verifyCodeFont;
@property (nonatomic, strong) UIColor *verifyCodeColor;


@property (nonatomic, assign) YFInputViewType type;

@end

NS_ASSUME_NONNULL_END
