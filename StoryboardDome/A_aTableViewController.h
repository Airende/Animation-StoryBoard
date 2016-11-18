//
//  A_aTableViewController.h
//  StoryboardDome
//
//  Created by airende on 16/8/8.
//  Copyright © 2016年 airende. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowBlock)(NSDictionary *dic);

@interface A_aTableViewController : UITableViewController

- (void)showInfo:(NSDictionary *)dic inView:(ShowBlock)block;

@end
