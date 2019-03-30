//
//  XFZTabBarConreoller.m
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/9/24.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ESTabBarConreoller.h"
#import "ESTabBar.h"
#import "ESClientServicVC.h"
#import "ESHelpVC.h"
#import "ESMoreVC.h"
#import "ESNavigationController.h"
@implementation ESTabBarConreoller

//当此类//  当第一次使用这个类的时候会调用一次

+(void)initialize
{
    //    统一设置字体颜色大小
    UITabBarItem *item = [UITabBarItem appearance];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
//    添加子控制器
    [self setupChildVc:[[ESClientServicVC alloc] init] title:@"联系客服" image:@"serverf" selectedImage:@"serverf_hig"];
     [self setupChildVc:[[ESHelpVC alloc] init] title:@"帮助" image:@"help" selectedImage:@"help_hig"];
     [self setupChildVc:[[ESMoreVC alloc] init] title:@"更多" image:@"more" selectedImage:@"more_hig"];

//    [self setValue:[[ESTabBar alloc]init] forKeyPath:@"tabBar"];
    
}

//初始化子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.navigationItem.title=title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
//    ESNavigationController *na=[[ESNavigationController alloc]initWithRootViewController:vc];
    
    [self addChildViewController:vc];
}
-(BOOL)shouldAutorotate
{
    return NO;
}

@end
