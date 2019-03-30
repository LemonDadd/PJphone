//
//  UIView+XFZExtension.h
//  Bird_LOVE_Sheep
//
//  Created by mac on 16/9/24.
//

#import <UIKit/UIKit.h>

@interface UIView (ESExtension)
@property (nonatomic ,assign)CGFloat  width;
@property (nonatomic ,assign)CGFloat  height;
@property (nonatomic ,assign)CGFloat  x;
@property (nonatomic ,assign)CGFloat  y;
@property (nonatomic ,assign)CGSize  size;


@property (nonatomic ,assign)CGFloat  centerX;
@property (nonatomic ,assign)CGFloat  centerY;



+(instancetype)viewFromXib;

- (BOOL)isShowingOnKeyWindow;
@end
