//
//  YFVerifyImgCodeView.m
//  YFInputView
//
//  Created by BigShow on 2021/6/22.
//

#import "YFVerifyImgCodeView.h"

#define CODE_LENGTH 4
#define ARCNUMBER arc4random() % 100 / 100.0
#define ARC_COLOR [UIColor colorWithRed:ARCNUMBER green:ARCNUMBER blue:ARCNUMBER alpha:0.2]

@interface YFVerifyImgCodeView ()
@property (nonatomic,copy) NSArray* codeArr;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation YFVerifyImgCodeView


//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//兼容nib使用
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

//设置默认参数
- (void)setupUI{
    
    UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] init];
    indicatorView.backgroundColor = [UIColor blueColor];
    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    CGAffineTransform transform = CGAffineTransformMakeScale(.7f, .7f);
    indicatorView.transform = transform;
    [self addSubview:indicatorView];
    self.indicatorView = indicatorView;

    self.codeArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    
    UITapGestureRecognizer* changeCode = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCode)];
    [self addGestureRecognizer:changeCode];
    self.backgroundColor = ARC_COLOR;
    
    [self getStrCode];
}

- (NSString *)randomCode {
    NSMutableString* tmpStr = [[NSMutableString alloc] initWithCapacity:5];;
    for (int i = 0; i < CODE_LENGTH; i++) {
        NSInteger index = arc4random() % (self.codeArr.count-1);
        [tmpStr appendString:[self.codeArr objectAtIndex:index]];
    }
    return tmpStr;
}

//随机生成验证码字符串
- (void)getStrCode{
    if (self.type == YFVerifyImgCodeViewTypeLocal) {
        self.codeStr = [self randomCode];
    }
}
- (void)setType:(YFVerifyImgCodeViewType)type {
    _type = type;
    if (type == YFVerifyImgCodeViewTypeLocal) {
        [self getStrCode];
    }
}


//刷新验证码
- (void)changeCode{
    if (self.type == YFVerifyImgCodeViewTypeNetwork && self.isLoading) return;
    if (self.verifyCodeBlock) {
        self.verifyCodeBlock();
    }
    [self getStrCode];
    self.backgroundColor = ARC_COLOR;
    [self setNeedsDisplay];
}

- (void)setCodeStr:(NSString *)codeStr {
    _codeStr = codeStr;
    if (self.type == YFVerifyImgCodeViewTypeLocal) return;
    self.backgroundColor = ARC_COLOR;
    [self setNeedsDisplay];
}

- (void)setLoading:(BOOL)loading {
    _loading = loading;
    if (self.type != YFVerifyImgCodeViewTypeNetwork) return;
    if (loading) {
        [self.indicatorView startAnimating];
    }else {
        [self.indicatorView stopAnimating];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (self.type == YFVerifyImgCodeViewTypeNetwork) {
        //指定加载框中心点
        [self.indicatorView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        if (self.isLoading) return;
    }

    NSLog(@"drawRect");
    CGSize cSize = [@"A" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];//计算单个字所需空间
    int width = rect.size.width / self.codeStr.length - cSize.width;//间距
    int height = rect.size.height - cSize.height;//可浮动高度
    CGPoint point;
    //绘码
    float pX, pY;
    for (int i = 0; i < self.codeStr.length; i++)
    {
        pX = arc4random() % width + rect.size.width / self.codeStr.length * i;
        pY = arc4random() % height;
        point = CGPointMake(pX, pY);
        unichar c = [self.codeStr characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", c];
        [textC drawAtPoint:point withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    }

    //干扰线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    for(int cout = 0; cout < 10; cout++)
    {
        CGContextSetStrokeColorWithColor(context, [ARC_COLOR CGColor]);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextMoveToPoint(context, pX, pY);
        pX = arc4random() % (int)rect.size.width;
        pY = arc4random() % (int)rect.size.height;
        CGContextAddLineToPoint(context, pX, pY);
        CGContextStrokePath(context);
    }
}


@end
