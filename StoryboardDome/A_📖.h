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
            UIScrollView 约束的问题 X
            通过延迟方法 dispatch_after 加载 √


    3.自定义视图通过 Delegate 和 Block 传出对比
        - Delegate                           - Block
        1> .h中 以代理的格式书写代理方法。              不需要
        2> .h中 委托方书写代理属性（assign，id<...>）   书写block属性（copy）
        3> .m中 判断并用代理调用代理方法                判断并直接调用block方法
        4> 被代理方 遵守代理 并设置代理为self           不需要
        5> 实现代理方法                              self.block = {}实现block

    4.block 的基本创建和使用

--- 11.17
A_c  自写Block参数方法的使用
    1.block作为入参的使用

        首先执行的是方法自身里面的代码，然后执行block作为参数书写在里面的方法。

        [UIView animateWithDuration:1 animation:^{
            //动画代码
            //…
        }];

        1.先执行方法中的 延迟1s操作。
        2.然后执行block动画里面的代码。

        一个方法分两个时段执行。

        例如AFN中请求的方法

        执行步骤
        1.执行到方法时立马发起请求
        2.得到请求结果后，根据情况调用成功的block或者是失败的block。
        3.执行block中的代码

        有点像代理，当某项得到结果后执行block中的代码。

        ⬆️-———以上都是基于 其他写好的 来理解的 ———-
        ⬇️———-如何自己 写个 block参数的方法呢-————

        这里写一个带有2个block参数的方法
        实现功能：计算前两个参数的和通过和的值调用不同的block函数。

        1.将block匿名函数定义一个名字
        typedef void(^TenAfterBlock)();
        typedef void(^TenBeforeBlock)();

        2.在.h中书写方法
        - (void)sumNumber:(CGFloat)num1 andNum2:(CGFloat)num2 tenBefore:(TenBeforeBlock)block1 tenAfter:(TenAfterBlock)block2;

        3.在.m中实现方法
        - (void)sumNumber:(CGFloat)num1 andNum2:(CGFloat)num2 tenBefore:(TenBeforeBlock)block1 tenAfter:(TenAfterBlock)block2{
            
            CGFloat sum = num1 + num2;
            
            if (sum <= 10) {
                block1();
            }else{
                block2();
            }
        }

        4.b_c中调用方法。
        [vc sumNumber:5.7 andNum2:4.9 tenBefore:^{
            NSLog(@"前面两个值加起来 <= 10");
        } tenAfter:^{
            NSLog(@" > 10 ");
        }];

    2.block使用注意
    3.block实现原理：不是现在看的东西





