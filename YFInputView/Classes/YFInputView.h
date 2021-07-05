//
//  YFInputView.h
//  LoginLib
//
//  Created by BigShow on 2021/6/9.
//

#import <UIKit/UIKit.h>
#import "YFVerifyMsgCodeButton.h"
#import "YFVerifyImgCodeView.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, YFInputViewType) {
    YFInputViewTypeAccount,       // 账号
    YFInputViewTypePhoneNum,      // 手机号
    YFInputViewTypePwd,           // 密码
    YFInputViewTypeVerifyMsgCode, // 短信验证码
    YFInputViewTypeVerifyImgCode, // 图形验证码
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
/**输入最大长度*/
@property (nonatomic, assign) NSInteger maxLength;
/**输入最小有效长度 （如果有效inputEnable为YES）*/
@property (nonatomic, assign) NSInteger minLength;

@property (nonatomic, strong) YFVerifyImgCodeView *verifyImgCodeView;
@property (nonatomic, strong) YFVerifyMsgCodeButton *verifyMsgCodeButton;

@property (nonatomic, strong) UIImage *imgCode;

@property (nonatomic, copy) void(^verifyCodeBlock) (void);

/* 输入过程text实时改变的值 */
@property (nonatomic, copy) NSString *changeingText;
/* 输入是否有效 changeingText>=minLength ? YES : NO */
@property (nonatomic, assign) BOOL inputEnable;

@property(nullable, nonatomic,weak)   id<UITextFieldDelegate> delegate;

// 供子类重写
- (void)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
- (void)verifyCodeClick;

@end

NS_ASSUME_NONNULL_END
