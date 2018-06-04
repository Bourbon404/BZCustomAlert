//
//  UIColor+Category.h
//  BZCustomAlert
//
//  Created by 郑伟 on 2018/6/4.
//  Copyright © 2018年 郑伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)
+ (UIColor *)colorFromHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorFromHexString:(NSString *)color;
@end
