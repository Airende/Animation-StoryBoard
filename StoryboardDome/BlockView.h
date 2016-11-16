//
//  BlockView.h
//  StoryboardDome
//
//  Created by airende on 2016/11/16.
//  Copyright © 2016年 airende. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BlockViewDelegate <NSObject>

- (void)delegateButton;

@end


@interface BlockView : UIView

@property (nonatomic, assign) id<BlockViewDelegate> delegate;

@property (nonatomic, copy) void(^blockButton)();

@end
