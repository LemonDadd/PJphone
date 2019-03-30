//
//  ESSwitchImageview.m
//  VPhone
//
//  Created by 赖长宽 on 2017/10/24.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESSwitchImageview.h"
//#import "SocketRocketUtility.h"

@interface ESSwitchImageview ()
@property (nonatomic,copy) NSString * offimageName;
@property (nonatomic,copy) NSString * onImagename;
@property (nonatomic,assign) BOOL isOn;
@end


@implementation ESSwitchImageview

-(instancetype)initWithOnImageName:(NSString*)onImagename offImageName:(NSString*)offImageName
{
 
    
    if ( self=[super init]) {
        
        
        self.image=[UIImage imageNamed:onImagename];
        
        _offimageName=offImageName;
        _onImagename=onImagename;
        self.width=79;
        self.height=35;
        self.userInteractionEnabled=YES;
        UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(handleTapTapGestureRecognizerEvent:)];
        [self addGestureRecognizer:tapGesture1];

        
    }

    return self;
}

- (void)handleTapTapGestureRecognizerEvent:(UITapGestureRecognizer *)recognizer
{
    
    if (recognizer.view ==self) {
        if (_isOn){
            self.image=[UIImage imageNamed:_onImagename];
            
            if ([_onImagename containsString:@"ready"]) {
                
               // [[SocketRocketUtility instance]ready];
            }else{
                
//                SocketRocketUtility *sru = [SocketRocketUtility instance];
//
//                [sru online];
//                sru.block = ^(id success) {
//
//                    if (success) {
//                        NSDictionary *dict = success;
//
//                        NSInteger  scNum = [dict[@"statusCode"]integerValue];
//                        if (scNum!=0) {
//
//                            self.image=[UIImage imageNamed:_offimageName];
//                            _isOn=NO;
//                        }
//                    }
//
//                };
                
            }
            
        }else{
            
            self.image=[UIImage imageNamed:_offimageName];
            if ([_onImagename containsString:@"ready"]) {
                
                
                //[[SocketRocketUtility instance]notReady];

            }else{
        
                //[[SocketRocketUtility instance]loginOut];

            }
            
        }
        _isOn=!_isOn;
        
    }
    
}

-(void)isLogin:(BOOL)isLogin
{
 
    
    if (isLogin) {
        self.image=[UIImage imageNamed:_onImagename];
        
        _isOn=NO;
    }else{
    
        self.image=[UIImage imageNamed:_offimageName];
        _isOn=YES;

    }

}

-(void)isReady:(BOOL)isReady
{
    
    
    
}

@end
