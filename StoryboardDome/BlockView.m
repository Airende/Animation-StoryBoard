//
//  BlockView.m
//  StoryboardDome
//
//  Created by airende on 2016/11/16.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "BlockView.h"

@interface BlockView ()

@property (weak, nonatomic) IBOutlet UIButton *delegateBtn;
@property (weak, nonatomic) IBOutlet UIButton *blockBtn;

@end


@implementation BlockView

/*
//这里没有使用代码创建
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //do something
    }
    return self;
}
*/

//自定义视图被xib中使用时，这个方法会用到
//- (instancetype)initWithCoder:(NSCoder *)aDecoder{
//    self = [super initWithCoder:aDecoder];
//    
//    if (self) {
//        //do something
//    }
//    return self;
//}

//代理吧按钮方法调出
- (IBAction)delegateButton:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(delegateButton)]) {
        
        [self.delegate delegateButton];
    }
}

//block 把按钮方法调出
- (IBAction)blockButton:(id)sender {
    
    if (self.blockButton) {
        _blockButton();
    }
}

//使用xib创建，需要添加其他的布局需写在这个方法里
- (void)awakeFromNib{
    [super awakeFromNib];
    // Initialization code

}
- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"bView layoutSubviews=%@",NSStringFromCGRect(self.frame));
    //self.frame = self.frame;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
