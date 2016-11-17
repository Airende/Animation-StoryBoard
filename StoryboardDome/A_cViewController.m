//
//  A_cViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/8.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "A_cViewController.h"
#import "A_bViewController.h"

@interface A_cViewController ()

@end

@implementation A_cViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    A_bViewController *vc = [[A_bViewController alloc] init];
    
   [vc logStrAfterLogOther:^(NSString *str) {
       NSLog(@"这里拿到的str是 %@ ，在外部",str);
   }];
    
    [vc sumNumber:5.7 andNum2:4.9 tenBefore:^{
        NSLog(@"前面两个值加起来 <= 10");
    } tenAfter:^{
        NSLog(@" > 10 ");
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
