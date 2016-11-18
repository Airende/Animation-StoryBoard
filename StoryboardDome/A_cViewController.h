//
//  A_cViewController.h
//  StoryboardDome
//
//  Created by airende on 16/8/8.
//  Copyright © 2016年 airende. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(NSString *str);
@interface A_cViewController : UIViewController

- (void)pushInViewControllName:(NSString *)vcName doSomething:(MyBlock)block;

@end
