//
//   BZCustomAlertButton.h
//  Core
//
//  Created by 郑伟 on 2018/5/22.
//

#i BZort <UIKit/UIKit.h>
@class BZCustomAlert;
@interface  BZCustomAlertButton : UIButton
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, copy) void (^ block)( BZCustomAlert *);
@end
