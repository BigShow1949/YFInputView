//
//  UIButton+Position.m
//
//  Created by BigShow on 2021/6/1.
//

#import "UIButton+Position.h"
#import <objc/runtime.h>
@interface UIButton()
/**bool 类型   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;
@end


@implementation UIButton (Position)

#pragma mark - 文字对图片的相对位置
- (void)layoutButtonWithEdgeInsetsStyle:(YFPositionButton)style
                        imageTitleSpace:(CGFloat)space
{
    //    self.backgroundColor = [UIColor cyanColor];
    
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    
    // 1. 得到imageView和titleLabel的宽、高

    
    CGFloat labelWidth  = 0.0;
    CGFloat labelHeight = 0.0;
    CGFloat imageWith   = 0.0;
    CGFloat imageHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
        imageWith = self.imageView.intrinsicContentSize.width;
        imageHeight = self.imageView.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
        imageWith = self.imageView.intrinsicContentSize.width;
        imageHeight = self.imageView.intrinsicContentSize.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case YFPositionButtonTextBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case YFPositionButtonTextBottomFixedText:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight, 0);
        }
            break;
        case YFPositionButtonTextRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case YFPositionButtonTextTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case YFPositionButtonTextLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        case YFPositionButtonTextMiddle:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, 0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end
