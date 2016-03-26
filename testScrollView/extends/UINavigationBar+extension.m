//
//  UINavigationBar+extension.m
//  testScrollView
//
//  Created by zhuyun on 16/3/14.
//  Copyright © 2016年 codera. All rights reserved.
//

#import "UINavigationBar+extension.h"
#import <objc/runtime.h>
static char overlayKey;
@implementation UINavigationBar (extension)
- (UIView *)overlay{
    return objc_getAssociatedObject(self, &overlayKey);
}
- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
  
    if(self.overlay != nil) {
        self.overlay.backgroundColor = backgroundColor;
    }else {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.shadowImage = [UIImage new];
        UIView* view =[[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height+20)];
        view.userInteractionEnabled = false;
        [self insertSubview:view atIndex:0];
        view.backgroundColor = backgroundColor;
        self.overlay = view;
    }
}
@end
