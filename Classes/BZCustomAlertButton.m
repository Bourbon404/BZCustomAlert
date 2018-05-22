//
//   BZCustomAlertButton.m
//  Core
//
//  Created by 郑伟 on 2018/5/22.
//

#import " BZCustomAlertButton.h"
#import "UIColor+Category.h"
@implementation  BZCustomAlertButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.showLine) {
        CALayer *lineLayer = [CALayer layer];
        lineLayer.backgroundColor = [UIColor colorFromHexString:@"#D7D9DE"].CGColor;
        lineLayer.frame = CGRectMake(CGRectGetWidth(self.frame), 0, 1/[UIScreen mainScreen].scale, CGRectGetHeight(self.frame));
        [self.layer addSublayer:lineLayer];
    }
}
- (void)setShowLine:(BOOL)showLine {
    if (_showLine != showLine) {
        _showLine = showLine;
        [self setNeedsLayout];
    }
}
@end
