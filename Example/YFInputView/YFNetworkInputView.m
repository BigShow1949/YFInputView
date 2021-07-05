//
//  YFNetworkInputView.m
//  LoginLib
//
//  Created by BigShow on 2021/7/2.
//

#import "YFNetworkInputView.h"

@implementation YFNetworkInputView
- (void)setType:(YFInputViewType)type {
    [super setType:type];
    if (self.type == YFInputViewTypeVerifyImgCode) { // 默认自动请求接口
        [self loadVerifyImgCode];
    }
}

- (void)verifyCodeClick {
    if (self.type == YFInputViewTypeVerifyMsgCode) {
        [self loadVerifyMsgCode];
    }else if (self.type == YFInputViewTypeVerifyImgCode) {
        [self loadVerifyImgCode];
    }
}

- (void)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 输入完手机号跟图形验证码，都需要调用接口验证是否正确
    if (self.type == YFInputViewTypePhoneNum && self.inputEnable) {
        [self verifyPhoneNum];
    }else if (self.type == YFInputViewTypeVerifyImgCode && self.inputEnable) {
        [self verifyCode];
    }
}

// 验证手机号是否合法
- (void)verifyPhoneNum {
    NSLog(@"马上验证手机号");
}

// 验证图形验证码是否正确
- (void)verifyCode {
    NSLog(@"马上验证图形验证码");

}

// 获取短信验证码
- (void)loadVerifyMsgCode {
    NSLog(@"马上短信验证码");

}

// 获取图片验证码
- (void)loadVerifyImgCode {
    NSLog(@"马上图片验证码");
   
}

@end
