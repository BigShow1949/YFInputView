//
//  YFInputView.m
//  LoginLib
//
//  Created by BigShow on 2021/6/9.
//

#import "YFInputView.h"


@interface YFInputView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView      *bottomLine;
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIButton    *rightButton;
@property (nonatomic, strong) UIView      *verifyPaddingView;

@end

@implementation YFInputView
#pragma mark - UI
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
    _maxLength = CGFLOAT_MAX;
    _minLength = 0;
    _bottomLineColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    _textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0];
    _textFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    _verifyCodeFont = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
    _verifyCodeColor = [UIColor colorWithRed:24/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
}

- (void)setupUI {
    _bottomLine = [[UIView alloc] init];
    _bottomLine.backgroundColor = _bottomLineColor;
    [self addSubview:_bottomLine];
    
    _leftImgView = [[UIImageView alloc] init];
    [self addSubview:_leftImgView];
    
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"请输入……";
    _textField.font = _textFont;
    _textField.textColor = _textColor;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.delegate = self;
    [self addSubview:_textField];
    
    _rightButton = [[UIButton alloc] init];
//    _rightButton.backgroundColor = [UIColor yellowColor];
    [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
    
    _verifyMsgCodeButton = [[YFVerifyMsgCodeButton alloc] init];
//    _verifyMsgCodeButton.backgroundColor = [UIColor yellowColor];
    [_verifyMsgCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyMsgCodeButton.titleLabel.font = _verifyCodeFont;
    [_verifyMsgCodeButton setTitleColor:_verifyCodeColor forState:UIControlStateNormal];
    _verifyMsgCodeButton.normalColor = _verifyCodeColor;
    _verifyMsgCodeButton.verifyCodeBlock = self.verifyCodeBlock;
    _verifyMsgCodeButton.timeOut = 5;
    [self addSubview:_verifyMsgCodeButton];
    
    _verifyImgCodeView = [[YFVerifyImgCodeView alloc] init];
    _verifyImgCodeView.verifyCodeBlock = self.verifyCodeBlock;
    [self addSubview:_verifyImgCodeView];
    
    _verifyPaddingView = [[UIView alloc] init];
    _verifyPaddingView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:_verifyPaddingView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 15; // 任意两个控件之间的间距
 
    CGFloat width   = self.frame.size.width - _leftMargin - _rightMargin;
    CGFloat height  = 0.5;
    CGFloat originX = _leftMargin;
    CGFloat originY = self.frame.size.height - height;
    _bottomLine.frame = CGRectMake(originX, originY, width, height);
    
    width   = 16;
    height  = 16;
    originY = (self.frame.size.height - height)/2;
    _leftImgView.frame = CGRectMake(originX, originY, width, height);
    
    width   = self.type==YFInputViewTypePwd ? 16 : 0;
    height  = 16;
    originX = self.frame.size.width - width - _rightMargin;
    originY = (self.frame.size.height - height)/2;
    _rightButton.frame = CGRectMake(originX, originY, width, height);
    
    if (self.type==YFInputViewTypeVerifyMsgCode) {
        width   = 80;
        height  = self.frame.size.height;
        originX = self.frame.size.width - width - _rightMargin;
        originY = (self.frame.size.height - height)/2;
        _verifyMsgCodeButton.frame = CGRectMake(originX, originY, width, height);
        
        width  = 0.5;
        height = 17;
        originX = CGRectGetMinX(_verifyMsgCodeButton.frame) - padding;
        originY = (self.frame.size.height - height)/2;
        _verifyPaddingView.frame = CGRectMake(originX, originY, width, height);
        
    }else if (self.type==YFInputViewTypeVerifyImgCode) {
        width   = 80;
        height  = 30;
        originX = self.frame.size.width - width - _rightMargin;
        originY = (self.frame.size.height - height)/2;
        _verifyImgCodeView.frame = CGRectMake(originX, originY, width, height);
        
        width  = 0.5;
        height = 17;
        originX = CGRectGetMinX(_verifyImgCodeView.frame) - padding;
        originY = (self.frame.size.height - height)/2;
        _verifyPaddingView.frame = CGRectMake(originX, originY, width, height);
    }else {
        _verifyMsgCodeButton.frame = CGRectZero;
        _verifyImgCodeView.frame   = CGRectZero;
        _verifyPaddingView.frame   = CGRectZero;
    }
    originX = CGRectGetMaxX(_leftImgView.frame) + padding;
    if (self.type == YFInputViewTypeVerifyMsgCode || self.type==YFInputViewTypeVerifyImgCode) {
        width = CGRectGetMinX(_verifyPaddingView.frame) - originX - padding;
    }else if (self.type == YFInputViewTypePwd){
        width = self.frame.size.width - originX - _rightMargin - _rightButton.frame.size.width - padding;
    }else {
        width = self.frame.size.width - originX - _rightMargin;
    }
    height  = self.frame.size.height;
    originY = 0;
    _textField.frame = CGRectMake(originX, originY, width, height);
}

#pragma mark - Setter
- (void)setType:(YFInputViewType)type {
    _type = type;
    switch (type) {
        case YFInputViewTypeAccount:
            self.leftImage    = [self imgWithName:@"account"];
            self.placeholder  = @"请输入账号";
            self.textField.secureTextEntry = NO;
            self.minLength    = 1;
            break;
        case YFInputViewTypePhoneNum:
            self.leftImage    = [self imgWithName:@"phoneNum"];
            self.placeholder  = @"请输入手机号";
            self.textField.secureTextEntry = YES;
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            self.maxLength    = 11;
            self.minLength    = 11;
            break;
        case YFInputViewTypePwd:
            self.leftImage    = [self imgWithName:@"pwd"];
            self.rightImage   = [self imgWithName:@"secure_close"];
            self.rightSelectedImage = [self imgWithName:@"secure_open"];
            self.placeholder  = @"请输入密码";
            self.textField.secureTextEntry = NO;
            self.maxLength    = 20;
            self.minLength    = 6;
            break;
        case YFInputViewTypeVerifyMsgCode:
            self.leftImage    = [self imgWithName:@"verifyCode"];
            self.placeholder  = @"请输入验证码";
            self.textField.secureTextEntry = NO;
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            self.maxLength    = 4;
            self.minLength    = 4;
            break;
        case YFInputViewTypeVerifyImgCode:
            self.leftImage    = [self imgWithName:@"verifyCode"];
            self.placeholder  = @"请输入图片验证码";
            self.textField.secureTextEntry = NO;
            self.textField.keyboardType = UIKeyboardTypeNumberPad;
            self.maxLength    = 4;
            self.minLength    = 4;
            break;
        default:
            break;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

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
    [_rightButton setImage:rightImage forState:UIControlStateNormal];
}

- (void)setRightSelectedImage:(UIImage *)rightSelectedImage {
    [_rightButton setImage:rightSelectedImage forState:UIControlStateSelected];
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    _bottomLineColor = bottomLineColor;
    _bottomLine.backgroundColor = bottomLineColor;
}

#pragma mark - Private

- (UIImage *)imgWithName:(NSString *)name {
    NSString *bundleName = [@"YFInputView.bundle" stringByAppendingPathComponent:name];
    NSString *frameWorkName = [@"Frameworks/YFInputView.framework/YFInputView.bundle" stringByAppendingPathComponent:name];

    UIImage *image = [UIImage imageNamed:bundleName] ?: [UIImage imageNamed:frameWorkName];
    if (!image)
        image = [UIImage imageNamed:name];
    return image;
}

- (void)rightClick:(UIButton *)button {
    button.selected = !button.selected;
    if (self.type == YFInputViewTypePwd) {
        _textField.secureTextEntry = !button.selected;
    }
}

#pragma mark - UITextFieldDelegate
// return NO to disallow editing.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {    
    if ([self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

// became first responder
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.delegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField; {
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.delegate textFieldDidEndEditing:textField];
    }
}

// if implemented, called in place of textFieldDidEndEditing:
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason API_AVAILABLE(ios(10.0)) {
    if ([self.delegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        [self.delegate textFieldDidEndEditing:textField reason:reason];
    }
}

// return NO to not change text
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.maxLength < CGFLOAT_MAX) {
        NSInteger strLength = textField.text.length - range.length + string.length;
        if (strLength > self.maxLength) return NO;
    }
    
    if (string.length == 0) { // 删除一个
        self.changeingText = [textField.text substringToIndex:textField.text.length -1];
    }else {
        self.changeingText = [textField.text stringByAppendingString:string];
    }
    
    self.inputEnable = self.changeingText.length >= self.minLength;
    
    if ([self.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        return [self.delegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField API_AVAILABLE(ios(13.0), tvos(13.0)) {
    if ([self.delegate respondsToSelector:@selector(textFieldDidChangeSelection:)]) {
        [self.delegate textFieldDidChangeSelection:textField];
    }
}

// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    self.changeingText = @"";
    self.inputEnable = NO;
    if ([self.delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.delegate textFieldShouldClear:textField];
    }
    return YES;
}

// called when 'return' key pressed. return NO to ignore.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.delegate textFieldShouldReturn:textField];
    }
    return YES;
}


@end
