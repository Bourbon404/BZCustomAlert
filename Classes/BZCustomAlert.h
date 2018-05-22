//
//   BZCustomAlert.h
//  Core
//
//  Created by 郑伟 on 2018/5/22.
//

#i BZort <UIKit/UIKit.h>

@interface  BZCustomAlert : UIView
@property (nonatomic, strong, readonly) UITextField *textField;
/**
 上方标题
 */
@property (nonatomic, copy) NSString *title;
/**
 中间的描述文案
 */
@property (nonatomic, copy) NSString *message;
/**
 背景是否是黑色透明
 */
@property (nonatomic, assign) BOOL isBackgroundClean;
/**
 增加一个文本输入框
 这里单独对placeholder进行了处理，外部只需要传字符串。
 如果textfile需要自定义特殊格式，请在返回的block中添加
 */
- (void)addTextField:(void (^)(UITextField *))textField witPlaceholder:(NSString *)placeholder;
/**
 增加点击事件

 @param buttonTitle 按钮文字
 @param action 点击回调，内部会自己消失
 */
- (void)addButton:(NSString *)buttonTitle action:(void (^)( BZCustomAlert *))action;

/**
 调用展示方法
 */
- (void)show;
@end
