//
//  A_📖.h
//  StoryboardDome
//
//  Created by airende on 2016/11/16.
//  Copyright © 2016年 airende. All rights reserved.
//

A_a  主界面

--- 11.16
A_b  Block的使用
    1.storyboard上使用scrollView
        1> 在界面上拖一个UIScrollView做好整屏幕的约束。
        2> 拖一个UIView放在UIScrollView上，并做好上下左右的约束。(红色报错)
        3> 水平滚动添加水平中线约束，竖直滑动添加竖直中线约束。(红色报错)
        4> UIView的高度(或者宽)设置一个固定的值，刷新约束。（无报错）
        5> 设置UIScrollView的其他属性。（根据需要也可以不设置）
        6> 将UIView的高的约束拉出属性。（- (void)updateViewConstraints中更新约束）

    2.自定义视图BlockView
        1> xib上约束的scrollView上面添加子视图frame存在问题！？

    3.自定义视图通过 Delegate 和 Block 传出对比
        - Delegate                           - Block
        1> .h中 以代理的格式书写代理方法。              不需要
        2> .h中 委托方书写代理属性（assign，id<...>）   书写block属性（copy）
        3> .m中 判断并用代理调用代理方法                判断并直接调用block方法
        4> 被代理方 遵守代理 并设置代理为self           不需要
        5> 实现代理方法                              self.block = {}实现block

    4.block 的基本创建和使用

--- 11.XX

    1.block作为入参的使用
    2.block使用注意
    3.使用block的第三方内部代码熟悉





