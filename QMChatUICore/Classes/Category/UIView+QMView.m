//
//  UIView+Hex.m
//  IMSDK
//
//  Created by lishuijiao on 2020/12/22.
//

#import "UIView+QMView.h"

#define Block_Safe(block) {\
    if (block) {\
        block();\
    }\
}\

@implementation UIView (QMView)

-(void)setQM_top:(CGFloat)QM_top{
    CGRect f = self.frame;
    f.origin.y = QM_top;
    self.frame = f;
}

-(CGFloat)QM_top{
    return self.frame.origin.y;
}

-(void)setQM_left:(CGFloat)QM_left{
    CGRect f = self.frame;
    f.origin.x = QM_left;
    self.frame = f;
}

-(CGFloat)QM_left{
    return self.frame.origin.x;
}

- (void)setQM_width:(CGFloat)QM_width{
    CGRect f = self.frame;
    f.size.width = QM_width;
    self.frame = f;
}

-(CGFloat)QM_width{
    return self.frame.size.width;
}

-(void)setQM_height:(CGFloat)QM_height{
    CGRect f = self.frame;
    f.size.height = QM_height;
    self.frame = f;
}

- (CGFloat)QM_height{
    return self.frame.size.height;
}

-(void)setQM_centerX:(CGFloat)QM_centerX{
    CGPoint c = self.center;
    c.x = QM_centerX;
    self.center = c;
}

-(CGFloat)QM_centerX{
    return self.center.x;
}

-(void)setQM_centerY:(CGFloat)QM_centerY{
    CGPoint c = self.center;
    c.y = QM_centerY;
    self.center = c;
}

- (CGFloat)QM_centerY{
    return self.center.y;
}

-(void)setQM_size:(CGSize)QM_size{
    CGRect f = self.frame;
    f.size = QM_size;
    self.frame = f;
}

-(CGSize)QM_size{
    return self.frame.size;
}

/**
  ** lineView:       需要绘制成虚线的view
  ** lineLength:     虚线的宽度
  ** lineSpacing:    虚线的间距
  ** lineColor:      虚线的颜色
  **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

//边框虚线
+ (void)drawLineForView:(UIView *)view lineColor:(UIColor *)lineColor {
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = lineColor.CGColor;
    border.fillColor = nil;
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    border.frame = view.bounds;
    border.lineWidth = 1.f;
    border.lineCap = @"square";
    border.lineDashPattern = @[@4, @2];
    [view.layer addSublayer:border];
}

- (void)setQMCornerRadius:(CGFloat)QMCornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = QMCornerRadius;
}

- (CGFloat)QMCornerRadius {
    return self.layer.cornerRadius;
}

/**
 绘制圆角
 */
- (void)QM_ClipCorners:(UIRectCorner)corners radius:(CGFloat)radius {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:(CGSize){radius}];
    CAShapeLayer *shapeLayer = self.layer.mask ?: [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}

- (void)QM_ClipCorners:(UIRectCorner)corners radius:(CGFloat)radius border:(CGFloat)width color:(nullable UIColor *)color {
    
    [self QM_ClipCorners:corners radius:radius];
    
    CAShapeLayer *subLayer = [CAShapeLayer layer];
    subLayer.lineWidth = width * 2;
    subLayer.strokeColor = color.CGColor;
    subLayer.fillColor = [UIColor clearColor].CGColor;
    subLayer.path = ((CAShapeLayer *)self.layer.mask).path;
    [self.layer addSublayer:subLayer];
}

- (void)QMBorderWidth:(CGFloat)width color:(nullable UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    
    UIViewController *result = [UIViewController new];
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    //寻找当前显示的window    （若项目只有一个window  可省略）
    if (window.windowLevel != UIWindowLevelNormal)  {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)  {
            
            if (tmpWin.windowLevel == UIWindowLevelNormal)  {
                
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *root = window.rootViewController;
    
    while (root) {
        if ([root isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)root;
            root = tab.selectedViewController;
        }
        else if([root isKindOfClass:[UINavigationController class]]) {
            root = root.childViewControllers.lastObject;
        }
        else if (root.presentedViewController){
            root = root.presentedViewController;
        }
        else{
            result = root;
            root = nil;
        }
    }
    return result;
}

- (void)RockAlertTipTitle:(NSString *)aTitle
                  message:(NSString *)aMessage
              cancelTitle:(NSString *)aCancelTitle
         confirmTitle:(NSString *)aConfirmTitle
             cancelBlock:(void(^)(void))cancelBlock
        confirmBlock:(void(^)(void))confirmBlock{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:aTitle message:aMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:aCancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Block_Safe(cancelBlock);
    }];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:aConfirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        Block_Safe(confirmBlock);
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

@end
