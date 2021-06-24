//
//  YFVerifyImgCodeView.h
//  YFInputView
//
//  Created by BigShow on 2021/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, YFVerifyImgCodeViewType) {
    YFVerifyImgCodeViewTypeLocal = 1,     // 前段自己做校验
    YFVerifyImgCodeViewTypeNetwork,     // 获取后端codeStr
};


@interface YFVerifyImgCodeView : UIView


@property (nonatomic,copy) NSString* codeStr;
@property (nonatomic, copy) void(^verifyCodeBlock) (void);
@property (nonatomic, assign) YFVerifyImgCodeViewType type;

@property(nonatomic, getter=isLoading) BOOL loading;


// 过滤多次连续点击
// 网络请求加载框

// 测试用
- (NSString *)randomCode;
@end

NS_ASSUME_NONNULL_END
