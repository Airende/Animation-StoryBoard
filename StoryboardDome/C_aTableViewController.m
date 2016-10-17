//
//  C_aTableViewController.m
//  StoryboardDome
//
//  Created by airende on 16/8/24.
//  Copyright © 2016年 airende. All rights reserved.
//

#import "C_aTableViewController.h"

@implementation C_aTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
