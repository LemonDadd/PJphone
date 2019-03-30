//
//  XFZNavigationController.m
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/9/25.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ESNavigationController.h"

@implementation ESNavigationController


//  当第一次使用这个类的时候会调用一次
+(void)initialize
{
    
    
//    所有的导航条 都会拥有背景 appearance 所有都NavigationBar
    UINavigationBar*na=[UINavigationBar appearance];
    
    [na  setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [na setTitleTextAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20]}];
    
    
 //给所有的导航item设置 appearance
    UIBarButtonItem *barItem=[UIBarButtonItem appearance];
    

    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    
    NSMutableDictionary *dicattrs=[NSMutableDictionary dictionary];
    dicattrs[NSFontAttributeName]=[UIFont systemFontOfSize:16];
    dicattrs[NSForegroundColorAttributeName]=[UIColor lightGrayColor];
    
    [barItem setTitleTextAttributes:dicattrs forState:UIControlStateDisabled];
}


-(void)viewDidLoad
{
 
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate=nil;

}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
    
//    先创建 
    if (self.childViewControllers.count>0) {
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//         自动适应button 大小
//        [button sizeToFit];
        button.bounds=CGRectMake(0, 0, 70, 30);
//        让按钮内部内容作对齐
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
//       设置按钮内边界往左偏移10
        button.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
        
        [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
        
        viewController.hidesBottomBarWhenPushed=YES;
        
    }
//    这句super的Push要放在后面 让viewConttroller 可以覆盖在上面的leftBarButtonItem 写一的话要放在上面 但无法在view didlode 上面覆盖新的leftBarButtonItem
 [super pushViewController:viewController animated:animated];
}
-(void)click
{
    [self popToRootViewControllerAnimated:YES];

}
@end
