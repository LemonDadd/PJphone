//
//  ESTimerLabelText.m
//  VPhone
//
//  Created by 赖长宽 on 2017/11/10.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESTimerLabelText.h"


@interface ESTimerLabelText ()

@property (strong,nonatomic) NSTimer * timer;

@property (nonatomic,assign) NSInteger timerNumber;

@property (strong, nonatomic)  UILabel *timerLabel;

@property (nonatomic,assign) NSInteger minutes;

@property (nonatomic,assign) NSInteger hours;

@end


@implementation ESTimerLabelText



-(void)startTimerLabel:(UILabel*)label
{
    NSLog(@"label--%@",label);
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer:) userInfo:nil repeats:YES];
    _timerLabel=label;
    _timerLabel.hidden=NO;

    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    

}

-(void)endTimer
{
    _timerLabel.text=@"";
    [_timer invalidate];
    _timerLabel.hidden=YES;
    _timer=nil;
    _hours=0;
    _minutes=0;
    _timerNumber=0;
}

// 定时器
-(void)scrollTimer:(NSTimer*)timer
{
    _timerLabel.text=[self esGetJishiqiString];
    
    
}
-(NSString *)esGetJishiqiString
{
    _timerNumber ++;

    NSString * ss=nil;
    NSString * mm=@"00";
    
    ss=[NSString stringWithFormat:@"%ld",(long)_timerNumber];
    if (ss.length==1) {
        ss=[NSString stringWithFormat:@"0%ld",(long)_timerNumber];
        
    }
    
    if (_timerNumber==60){
        
        _minutes=_minutes+1;
        
        _timerNumber=0;
        
        
        
    }else if (_minutes==60){
        
        
        _hours=_hours+1;
        _minutes=0;
    }
    
    
    mm=[NSString stringWithFormat:@"%ld",(long)_minutes];
    
    if (mm.length==1) {
        
        mm=[NSString stringWithFormat:@"0%ld",(long)_minutes];
        
    }
    
    return [NSString stringWithFormat:@"%ld:%@:%@",(long)_hours,mm,ss];
    
    
    
}

@end
