//
//  YFVerifyCodeButton.h
//  LoginLib
//
//  Created by BigShow on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFVerifyCodeButton : UIButton
/**倒计时时间*/
@property (nonatomic, assign) NSInteger timeOut;
/** 按钮默认颜色 */
@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, copy) void(^verifyCodeButtonBlock) (void);
@end

NS_ASSUME_NONNULL_END
