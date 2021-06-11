//
//  YFViewController.m
//  YFInputView
//
//  Created by BigShow1949 on 06/10/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import "YFViewController.h"
#import "YFRegisterViewController.h"


#import <YFInputView/YFInputView.h>
#import <YFPageMenu/YFPageMenu.h>
#import <Masonry/Masonry.h>
#import <YFPositionButton/UIButton+Position.h>

#define HEXCOLOR(rgbValue) HEXCOLORA(rgbValue,1.0)
#define HEXCOLORA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define kFontRegularSize(font)  [UIFont fontWithName:@"PingFang-SC-Regular" size:font]
#define kFontMediumSize(font)   [UIFont fontWithName:@"PingFang-SC-Medium" size:font]
#define kFontBoldSize(font)     [UIFont fontWithName:@"PingFang-SC-Semibold" size:font]

typedef NS_ENUM(NSUInteger, YFLoginType) {
    YFLoginTypeAccount,
    YFLoginTypeNumberCode,
    YFLoginTypeNumberPwd,
};

@interface YFViewController ()<YFPageMenuDelegate>
@property(nonatomic,strong) YFPageMenu *pageMenu;

@property (nonatomic, strong) YFInputView *account;
@property (nonatomic, strong) YFInputView *pwd;

@property (nonatomic, strong) UIButton *registerBtn;

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *changeCodeBtn;
@property (nonatomic, strong) UIButton *changePwdBtn;
@property (nonatomic, assign) YFLoginType loginType;

@end

@implementation YFViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginType = YFLoginTypeAccount;
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupUI];
    [self setupConstraint];
    
//    self.gk_navTitle = @"123";
//    self.gk_navBarAlpha = 0; // Q:设置为0的时候，GK导航栏会崩溃

}

- (void)changeLoginType {
    switch (self.loginType) {
        case YFLoginTypeAccount:
            self.account.placeholder = @"请输入账号";
            self.account.type = YFInputViewTypeAccount;
            self.pwd.placeholder = @"请输入密码";
            self.pwd.type = YFInputViewTypePwd;
            
            self.changePwdBtn.hidden  = YES;
            self.changeCodeBtn.hidden = YES;
            self.forgetBtn.hidden = NO;

            break;
        case YFLoginTypeNumberCode:
            self.account.placeholder = @"请输入手机号";
            self.account.type = YFInputViewTypePhoneNum;
            self.pwd.placeholder = @"请输入验证码";
            self.pwd.type = YFInputViewTypeCode;

            
            self.changePwdBtn.hidden  = NO;
            self.changeCodeBtn.hidden = YES;
            self.forgetBtn.hidden = YES;

            break;
        case YFLoginTypeNumberPwd:
            self.account.placeholder = @"请输入手机号";
            self.account.type = YFInputViewTypePhoneNum;
            self.pwd.placeholder = @"请输入密码";
            self.pwd.type = YFInputViewTypePwd;

            self.changePwdBtn.hidden  = YES;
            self.changeCodeBtn.hidden = NO;
            self.forgetBtn.hidden = NO;
            
            break;
        default:
            break;
    }
}

#pragma mark - YFPageMenu的代理方法
- (void)pageMenu:(YFPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    if (toIndex == 0) {
        self.loginType = YFLoginTypeAccount;
    }else {
        self.loginType = YFLoginTypeNumberPwd;
    };
    [self changeLoginType];
}

- (void)setupUI {
    YFInputView *account = [[YFInputView alloc] init];
    account.leftImage    = [UIImage imageNamed:@"phoneNum"];
    account.placeholder  = @"请输入账号";
    account.type = YFInputViewTypeAccount;
    self.account = account;
    [self.view addSubview:account];
    
    YFInputView *pwd    = [[YFInputView alloc] init];
    pwd.leftImage       = [UIImage imageNamed:@"pwd"];
    pwd.rightImage      = [UIImage imageNamed:@"secure_close"];
    pwd.rightSelectedImage = [UIImage imageNamed:@"secure_open"];
    pwd.placeholder = @"请输入密码";
    pwd.type        = YFInputViewTypePwd;
    [self.view addSubview:pwd];
    self.pwd = pwd;
    
    [self.view addSubview:self.pageMenu];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.changeCodeBtn];
    [self.view addSubview:self.changePwdBtn];
    [self.view addSubview:self.registerBtn];
}

- (void)setupConstraint {
    CGFloat padding = 31;
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.view).offset(130);
        make.right.equalTo(self.view);
    }];
    
    [self.pageMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view);
        make.top.equalTo(self.registerBtn.mas_bottom).offset(100);
        make.height.mas_equalTo(50);
    }];
    
    [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pageMenu.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.account.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwd.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(94);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(-10);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(44);
    }];
    
    [self.changeCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(self.forgetBtn);
        make.right.equalTo(self.view);
        make.width.mas_equalTo(150);
    }];
    
    [self.changePwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerY.equalTo(self.forgetBtn);
        make.right.equalTo(self.view);
        make.width.mas_equalTo(150);
    }];

}

- (YFPageMenu *)pageMenu {
    if (!_pageMenu) {
        YFPageMenu *pageMenu = [YFPageMenu pageMenuWithFrame:CGRectZero trackerStyle:YFPageMenuTrackerStyleLineAttachment];
        [pageMenu setItems:@[@"账号登录",@"手机号登录"] selectedItemIndex:0];
        pageMenu.permutationWay = YFPageMenuPermutationWayScrollAdaptContent;
        pageMenu.delegate = self;
        pageMenu.selectedItemTitleColor = HEXCOLOR(0x333333);
        pageMenu.unSelectedItemTitleColor = HEXCOLOR(0xBBBBBB);
        pageMenu.tracker.backgroundColor = HEXCOLOR(0x1890FF);
        pageMenu.tracker.trackerWidth = 30;
        pageMenu.selectedItemTitleFont = kFontBoldSize(20);
        pageMenu.unSelectedItemTitleFont = kFontRegularSize(14);
//        pageMenu.bridgeScrollView = _scrollView;
        pageMenu.dividingLine.hidden = YES;
        _pageMenu = pageMenu;
    }
    return  _pageMenu;;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundImage:[UIImage imageNamed:@"gradually"] forState:UIControlStateNormal];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)forgetBtn {
    if (!_forgetBtn) {
        _forgetBtn = [self createButton:@"忘记密码" titleColor:HEXCOLOR(0xBBBBBB) font:kFontRegularSize(14) selector:@selector(forgetBtnClick)];
    }
    return _forgetBtn;
}

- (UIButton *)changeCodeBtn {
    if (!_changeCodeBtn) {
        _changeCodeBtn = [self createButton:@"验证码登录" titleColor:[UIColor blueColor] font:kFontRegularSize(14) selector:@selector(changeCodeBtnClick:)];
        [_changeCodeBtn setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        [_changeCodeBtn layoutButtonWithEdgeInsetsStyle:YFPositionButtonTextLeft imageTitleSpace:0];
    }
    return _changeCodeBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [self createButton:@"新用户注册" titleColor:[UIColor blueColor] font:kFontRegularSize(14) selector:@selector(registerBtnClick)];
    }
    return _registerBtn;
}

- (UIButton *)changePwdBtn {
    if (!_changePwdBtn) {
        _changePwdBtn = [self createButton:@"密码登录" titleColor:[UIColor blueColor] font:kFontRegularSize(14) selector:@selector(changePwdBtnClick:)];
        [_changePwdBtn setImage:[UIImage imageNamed:@"right_arrow"] forState:UIControlStateNormal];
        _changePwdBtn.hidden = YES;
        [_changePwdBtn layoutButtonWithEdgeInsetsStyle:YFPositionButtonTextLeft imageTitleSpace:0];
    }
    return _changePwdBtn;
}

- (void)registerBtnClick {
    NSLog(@"新用户注册");
    YFRegisterViewController *vc = [[YFRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)forgetBtnClick {
    NSLog(@"忘记密码");
}

- (void)loginBtnClick {
    NSLog(@"登录");
}

- (void)changeCodeBtnClick:(UIButton *)button {
    self.loginType = YFLoginTypeNumberCode;
    NSLog(@"验证码登录");
    
    [self changeLoginType];
}

- (void)changePwdBtnClick:(UIButton *)button {
    self.loginType = YFLoginTypeNumberPwd;
    [self changeLoginType];
}


- (UIButton *)createButton:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font selector:(SEL)sel{
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = font;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}


@end
