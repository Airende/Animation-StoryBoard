//
//  A_bViewController.h
//  StoryboardDome
//
//  Created by airende on 16/8/8.
//  Copyright © 2016年 airende. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LogBlock)(NSString* str);

typedef void(^TenAfterBlock)();
typedef void(^TenBeforeBlock)();

@interface A_bViewController : UIViewController


- (void)logStrAfterLogOther:(LogBlock)block;

- (void)sumNumber:(CGFloat)num1 andNum2:(CGFloat)num2 tenBefore:(TenBeforeBlock)block1 tenAfter:(TenAfterBlock)block2;

@end
