//
//  YFVerifyCodeButton.m
//  LoginLib
//
//  Created by BigShow on 2021/6/10.
//

#import "YFVerifyCodeButton.h"

@implementation YFVerifyCodeButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.timeOut = 60;
    self.normalColor = [UIColor blueColor];
    [self addTarget:self action:@selector(sentPhoneCodeTimeMethod) forControlEvents:UIControlEventTouchUpInside];
}


- (void)sentPhoneCodeTimeMethod {
    
    if (self.verifyCodeButtonBlock) {
        self.verifyCodeButtonBlock();
    }
    
    //倒计时时间 - 60S
    __block NSInteger timeOut = self.timeOut;
//    self.timeOut = timeOut;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时结束
                [self setTitle:@"重发验证码" forState:UIControlStateNormal];
                [self setTitleColor:self.normalColor forState:UIControlStateNormal];
                self.enabled = YES;
            });
        } else {
            //开始计时
            //剩余秒数 seconds
            NSString *strTime = [NSString stringWithFormat:@"%.1ld后重新获取", timeOut];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                NSString *title = [NSString stringWithFormat:@"%@",strTime];
                [self setTitle:title forState:UIControlStateNormal];
//              [yourButton.titleLabel setTextAlignment:NSTextAlignmentRight];
                // 设置按钮title居中 上面注释的方法无效
                [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
                [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //计时器间不允许点击
                self.enabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

@end
