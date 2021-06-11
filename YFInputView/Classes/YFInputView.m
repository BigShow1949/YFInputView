//
//  YFInputView.m
//  LoginLib
//
//  Created by BigShow on 2021/6/9.
//

#import "YFInputView.h"
#import "YFVerifyCodeButton.h"

@interface YFInputView ()
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIButton    *rightButtonView;
@property (nonatomic, strong) YFVerifyCodeButton *verifyCodeButton;
@property (nonatomic, strong) UIView      *verifyPaddingView;
@end

@implementation YFInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupData];
        [self setupUI];
    }
    return self;
}

- (void)setupData {
    _leftMargin = 31;
    _rightMargin = 31;
    _bottomLineColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    _textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0];
    _textFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    
    _verifyCodeFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    _verifyCodeColor = [UIColor colorWithRed:24/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
//    self.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)setType:(YFInputViewType)type {
    _type = type;
    switch (type) {
        case YFInputViewTypeAccount:
            NSLog(@"[self imageWithName:account] = %@", [self imageWithName:@"account"]);
            self.leftImage    = [self imageWithName:@"account"];
            self.placeholder  = @"请输入账号";
            break;
        case YFInputViewTypePhoneNum:
            self.leftImage    = [self imageWithName:@"phoneNum"];
            self.placeholder  = @"请输入手机号";
            break;
        case YFInputViewTypePwd:
            self.leftImage       = [self imageWithName:@"pwd"];
            self.rightImage      = [self imageWithName:@"secure_close"];
            self.rightSelectedImage = [self imageWithName:@"secure_open"];
            self.placeholder = @"请输入密码";
            break;
        case YFInputViewTypeCode:
            self.leftImage    = [self imageWithName:@"verifyCode"];
            self.placeholder  = @"请输入验证码";
            break;
        default:
            break;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
 
    CGFloat width   = self.frame.size.width - _leftMargin - _rightMargin;
    CGFloat height  = 0.5;
    CGFloat originX = _leftMargin;
    CGFloat originY = self.frame.size.height - height;
    _bottomLine.frame = CGRectMake(originX, originY, width, height);
    
    width   = 16;
    height  = 16;
    originY = (self.frame.size.height - height)/2;
    _leftImgView.frame = CGRectMake(originX, originY, width, height);
    
    originX = CGRectGetMaxX(_leftImgView.frame) + 15;
    width   = self.frame.size.width - originX - _rightMargin;
    height  = self.frame.size.height;
    originY = 0;
    _rightButtonView.frame = CGRectMake(originX, originY, width, height);
    
    width   = self.type==YFInputViewTypePwd ? 16 : 0;
    height  = 16;
    originX = self.frame.size.width - width - _rightMargin;
    originY = (self.frame.size.height - height)/2;
    _rightButtonView.frame = CGRectMake(originX, originY, width, height);
    
    width   = self.type==YFInputViewTypeCode? 80 : 0;
    height  = self.frame.size.height;
    originX = self.frame.size.width - width - _rightMargin;
    originY = (self.frame.size.height - height)/2;
    _verifyCodeButton.frame = CGRectMake(originX, originY, width, height);
    
    width  = self.type==YFInputViewTypeCode? 0.5 : 0;;
    height = 17;
    originX = CGRectGetMinX(_verifyCodeButton.frame) - 15;
    originY = (_verifyCodeButton.frame.size.height - height)/2;
    _verifyPaddingView.frame = CGRectMake(originX, originY, width, height);
    

    originX = CGRectGetMaxX(_leftImgView.frame) + 15; // 15：图片跟textField的间距
    width   = self.frame.size.width - originX - _rightMargin - _rightButtonView.frame.size.width - _verifyCodeButton.frame.size.width;
    height  = self.frame.size.height;
    originY = 0;
    _textField.frame = CGRectMake(originX, originY, width, height);
}


- (void)setupUI {
    
    NSLog(@"setupUI _verifyCodeFont = %@", _verifyCodeFont);
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = _bottomLineColor;
    [self addSubview:_bottomLine];
    
    _leftImgView = [[UIImageView alloc] init];
//    _leftImgView.backgroundColor = [UIColor blueColor];
    [self addSubview:_leftImgView];
    
    _textField = [[UITextField alloc] init];
//    _textField.backgroundColor = [UIColor redColor];
    _textField.placeholder = @"请输入……";
    _textField.font = _textFont;
    _textField.textColor = _textColor;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _textField.secureTextEntry = NO;
    [self addSubview:_textField];
    
    _rightButtonView = [[UIButton alloc] init];
    [_rightButtonView addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
//    _rightButtonView.backgroundColor = [UIColor redColor];
    [self addSubview:_rightButtonView];
    
    _verifyCodeButton = [[YFVerifyCodeButton alloc] init];
//    _verifyCodeButton.backgroundColor = [UIColor lightGrayColor];
    [_verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyCodeButton.titleLabel.font = _verifyCodeFont;
    [_verifyCodeButton setTitleColor:_verifyCodeColor forState:UIControlStateNormal];
//    [_verifyCodeButton addTarget:self action:@selector(verifyCodeClick:) forControlEvents:UIControlEventTouchUpInside];
    _verifyCodeButton.timeOut = 60;
    [self addSubview:_verifyCodeButton];
    
    _verifyPaddingView = [[UIView alloc] init];
    _verifyPaddingView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:_verifyPaddingView];
}

- (void)rightClick:(UIButton *)button {
    button.selected = !button.selected;
}

#pragma mark - Setter

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _textField.placeholder = placeholder;
}
- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    _leftImgView.image = leftImage;
}

- (void)setRightImage:(UIImage *)rightImage {
    _rightImage = rightImage;
    [_rightButtonView setImage:rightImage forState:UIControlStateNormal];
}

- (void)setRightSelectedImage:(UIImage *)rightSelectedImage {
    [_rightButtonView setImage:rightSelectedImage forState:UIControlStateSelected];
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    _bottomLine.backgroundColor = bottomLineColor;
}

- (void)verifyCodeClick:(UIButton *)button {
    NSLog(@"点击了验证码");
//    [self sentPhoneCodeTimeMethod];
}


- (UIImage *)imageWithName:(NSString *)img {
//    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
//    associateBundleURL = [associateBundleURL URLByAppendingPathComponent:@"YFInputView"];
//    associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
//    NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
//    associateBundleURL = [associateBunle URLForResource:@"YFInputView" withExtension:@"bundle"];
//    NSBundle *bundle = [NSBundle bundleWithURL:associateBundleURL];
//    UIImage *image3  = [UIImage imageNamed:img inBundle: bundle compatibleWithTraitCollection:nil];
//    return image3;
    return [UIImage imageNamed:img];
}

@end
