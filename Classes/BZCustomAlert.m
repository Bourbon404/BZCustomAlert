//
//   BZCustomAlert.m
//  Core
//
//  Created by 郑伟 on 2018/5/22.
//

#import "BZCustomAlert.h"
#import "UIColor+Category.h"
#import "BZCustomAlertButton.h"
@interface  BZCustomAlert ()
@property (nonatomic, strong, readwrite) UITextField *textField;
@property (nonatomic, strong) UIView *tml;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, assign) CGRect keyboardFrame;
@end
@implementation  BZCustomAlert
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.buttonArray = [NSMutableArray array];
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.2;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillShowNotification object:nil];
    } return self;
}
- (void)configFrame {
    
    CGFloat width = 270;
    CGFloat height = 0;
    
    if (_titleLabel) {
        //包含titleLabel
        CGSize titleSize = [self.titleLabel textRectForBounds:CGRectMake(0, 0, width - 30, CGFLOAT_MAX) limitedToNumberOfLines:0].size;
        self.titleLabel.frame = CGRectMake(15, 18, width - 30, titleSize.height);
        height = 18 + titleSize.height + height;
    }
    
    if (_messageLabel) {
        //包含messageLabel
        CGSize messageSize = [self.messageLabel textRectForBounds:CGRectMake(0, 0, width - 30, CGFLOAT_MAX) limitedToNumberOfLines:0].size;
        self.messageLabel.frame = CGRectMake(15, height + 15, 240, messageSize.height);
        height = 15 + messageSize.height + height;
    }
    
    if (_textField) {
        //包含一个文本输入框
        self.textField.frame = CGRectMake(15, height + 15, width - 30, 36);
        height = 15 + self.textField.frame.size.height + height;
    }
    
    if (self.buttonArray.count) {
        //包含按钮数组
        CALayer *lineLayer = [[CALayer alloc] init];
        lineLayer.frame = CGRectMake(0, height + 15, width, 1 / [UIScreen mainScreen].scale);
        lineLayer.backgroundColor = [UIColor colorFromHexString:@"#D7D9DE"].CGColor;
        [self.layer addSublayer:lineLayer];
        
        CGFloat buttonWidth = width / self.buttonArray.count;
        [self.buttonArray enumerateObjectsUsingBlock:^( BZCustomAlertButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj setFrame:CGRectMake(idx * buttonWidth, height + 15, buttonWidth, 50)];
            if (idx != self.buttonArray.count - 1 && self.buttonArray.count > 1) {
                obj.showLine = YES;
            }
        }];
        height = 15 + 50 + height;
    }
    
    self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - width )/2, ([UIScreen mainScreen].bounds.size.height - height )/2, width, height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = path.CGPath;
    self.layer.cornerRadius = 13;
}
#pragma mark Property
- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = title;
        self.titleLabel.text = _title;
        if (![self.subviews containsObject:self.titleLabel]) {
            [self addSubview:self.titleLabel];
        }
    }
}
- (void)setMessage:(NSString *)message {
    if (![_message isEqualToString:message]) {
        _message = message;
        self.messageLabel.text = _message;
        if (![self.subviews containsObject:self.messageLabel]) {
            [self addSubview:self.messageLabel];
        }
    }
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor colorFromHexString:@"#333333"];
        _titleLabel.numberOfLines = 0;
    } return _titleLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textColor = [UIColor colorFromHexString:@"#9B9B9B"];
    } return _messageLabel;
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor colorFromHexString:@"#F1F2F6"];
        _textField.font = [UIFont systemFontOfSize:12];
        _textField.layer.cornerRadius = 8;
        _textField.layer.masksToBounds = YES;
        _textField.textColor = [UIColor blackColor];
        _textField.textAlignment = NSTextAlignmentLeft;
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 11, 36)];
        spaceView.backgroundColor = [UIColor clearColor];
        _textField.leftView = spaceView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightView = spaceView;
        _textField.rightViewMode = UITextFieldViewModeAlways;
    } return _textField;
}
- (UIWindow *)alertWindow {
    if (!_alertWindow) {
        _alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.windowLevel = UIWindowLevelAlert + 1;
        if (!self.isBackgroundClean) {
            _alertWindow.backgroundColor = [UIColor colorFromHexString:@"#000000" alpha:0.4];
        }
    } return _alertWindow;
}
#pragma mark Method
- (void)addTextField:(void (^)(UITextField *))textField witPlaceholder:(NSString *)placeholder {
    
    if (textField) {
        textField(self.textField);
    }
    
    if (placeholder.length > 0) {
        NSDictionary *attributeDict = @{NSForegroundColorAttributeName:[UIColor colorFromHexString:@"#9B9B9B"], NSFontAttributeName:[UIFont systemFontOfSize:12]};
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:placeholder attributes:attributeDict];
        self.textField.attributedPlaceholder = attributeStr;
    }

    
    if (![self.subviews containsObject:self.textField]) {
        [self addSubview:self.textField];
    }
}
- (void)addButton:(NSString *)buttonTitle action:(void (^)( BZCustomAlert *))action {
     BZCustomAlertButton *button = [self createButtonWithTitle:buttonTitle];
    button.block = action;
    [self addSubview:button];
    [self.buttonArray addObject:button];
}
- ( BZCustomAlertButton *)createButtonWithTitle:(NSString *)buttonTitle {
     BZCustomAlertButton *button = [ BZCustomAlertButton buttonWithType:(UIButtonTypeCustom)];
    [button setTitle:buttonTitle forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor colorFromHexString:@"#2F92FF"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(didClickButton:) forControlEvents:(UIControlEventTouchUpInside)];
    return button;
}
- (void)didClickButton:( BZCustomAlertButton *)button {
    self.alertWindow = nil;
    if (button.block) {
        button.block(self);
    }
}
- (void)show {
    [self configFrame];
    [self.alertWindow makeKeyAndVisible];
    [self.alertWindow addSubview:self];
    self.alpha = 0;
    [self.textField becomeFirstResponder];
    CGPoint alertCenter = self.center;
    if (CGRectGetMinY(self.keyboardFrame) - CGRectGetMaxY(self.frame) < 50) {
        alertCenter.y = alertCenter.y - 50;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.center = alertCenter;
    }];
}
#pragma mark Notification
- (void)keyboardFrameWillChange:(NSNotification *)notify {
    NSDictionary *userInfo = [notify userInfo];
    NSValue *keyboardFrameValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [keyboardFrameValue CGRectValue];
}
@end
