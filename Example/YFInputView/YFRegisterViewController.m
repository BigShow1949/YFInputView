//
//  YFRegisterViewController.m
//  LoginLib
//
//  Created by BigShow on 2021/6/10.
//

#import "YFRegisterViewController.h"
#import <YFInputView/YFInputView.h>
#import <Masonry/Masonry.h>

@interface YFRegisterViewController ()

@property (nonatomic, strong) YFInputView *phoneNum;   // 手机号
@property (nonatomic, strong) YFInputView *pwd;        // 密码
@property (nonatomic, strong) YFInputView *pwdAgain;    // 账号
@property (nonatomic, strong) YFInputView *verifyCode; // 验证码

@property (nonatomic, strong) UIButton *registerBtn;

@end

@implementation YFRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self setupUI];
    [self setupConstraint];
}


- (void)setupUI {

    YFInputView *phoneNum = [[YFInputView alloc] init];
    phoneNum.type = YFInputViewTypePhoneNum;
    self.phoneNum = phoneNum;
    [self.view addSubview:phoneNum];
    
    YFInputView *pwd    = [[YFInputView alloc] init];
    pwd.type        = YFInputViewTypePwd;
    self.pwd = pwd;
    [self.view addSubview:pwd];
    
    YFInputView *pwdAgain = [[YFInputView alloc] init];
    pwdAgain.type = YFInputViewTypePwd;
    pwdAgain.placeholder  = @"请再次输入密码";
    self.pwdAgain = pwdAgain;
    [self.view addSubview:pwdAgain];
    
    YFInputView *verifyCode = [[YFInputView alloc] init];
    verifyCode.type = YFInputViewTypeCode;
    self.verifyCode = verifyCode;
    [self.view addSubview:verifyCode];
    
    [self.view addSubview:self.phoneNum];
    [self.view addSubview:self.pwd];
    [self.view addSubview:self.pwdAgain];
    [self.view addSubview:self.verifyCode];
    [self.view addSubview:self.registerBtn];

}

- (void)setupConstraint {

    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNum.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.pwdAgain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwd.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdAgain.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.verifyCode.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(94);
    }];
    
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setBackgroundImage:[UIImage imageNamed:@"gradually"] forState:UIControlStateNormal];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}

- (void)registerBtnClick {
    
}

@end
