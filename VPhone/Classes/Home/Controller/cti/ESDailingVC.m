//
//  ESDailingVC.m
//  VPhone
//
//  Created by 赖长宽 on 2017/9/18.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESDailingVC.h"
#import "ESTimerLabelText.h"
#import <AVFoundation/AVFoundation.h>
#import "ESAlertAction.h"
@interface ESDailingVC ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *zzbhLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (strong,nonatomic) ESSwitchImageview * loginView;
@property (strong,nonatomic) ESSwitchImageview * readyView;

@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) ESTimerLabelText * timerText;
@property (assign, nonatomic) NSInteger  call_Id;
@property (nonatomic,strong) ESAlertAction * alert;


@end


@implementation ESDailingVC
-(ESAlertAction *)alert
{
    if (!_alert) {
        
        _alert=[[ESAlertAction alloc]init];
    }
    return _alert;
}
-(ESTimerLabelText *)timerText
{
    if (!_timerText) {
        _timerText=[[ESTimerLabelText alloc]init];
    }
    return _timerText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(siphandleCallStatusChanged:) name:ESPJPhoneCallStatusChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onMessageHandler:) name:ESPJPhoneOnEventMessageHandler object:nil];
    
    [self setGifView];
    
}
-(void)setGifView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"call" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    //创建一个webView，添加到界面
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_zzbhLabel.frame), CGRectGetMinY(_zzbhLabel.frame), 150, 36)];
    [self.view addSubview:_webView];
    //自动调整尺寸
    _webView.scalesPageToFit = YES;
    //禁止滚动
    _webView.scrollView.scrollEnabled = NO;
    //设置透明效果
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = 0;
    //加载数据
    [_webView loadData:gifData MIMEType:@"image/gif" textEncodingName:NULL baseURL:nil];
}
-(void)onMessageHandler:(NSNotification*)userinfo
{
    ESPMessage *message = [ESPMessage mj_objectWithKeyValues:[userinfo userInfo]];
    int errorcode =[message.errorCode intValue];
    
    
    if ([message.messageName isEqualToString:@"EventReleased"]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.timerText endTimer];
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        //设置为播放和录音状态，以便可以在录制完之后播放录音
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [audioSession setActive:YES error:nil];
        
    }else
        
        if ([message.messageName isEqualToString:@"EventEstablished"]) {
            [_webView removeFromSuperview];
            [self.timerText startTimerLabel:self.timerLabel];
            
        }else if (errorcode>399&&errorcode<600){
            if (errorcode==404) {
                NSLog(@"cuowu");
            }
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
}
-(void)setSwitchview
{
  
    
}

// 呼叫状态
- (void)siphandleCallStatusChanged:(NSNotification *)notification {
    ESPCallStatusMessage *message = [ESPCallStatusMessage mj_objectWithKeyValues:notification.userInfo];
    _call_Id=message.call_id;
    if (message.state == ESPJPhoneCallStatus_DISCONNECTED) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (message.state == ESPJPhoneCallStatus_CONNECTING) {
        NSLog(@"连接中");
    } else if (message.state == ESPJPhoneCallStatus_CONFIRMED) {
        NSLog(@"接听成功！");
    }
}
- (IBAction)hangUpAction:(UIButton *)sender {
    
    [[ESPJPhone sharedESPJPhone]ESClientReleaseCall:[NSString stringWithFormat:@"%ld",(long)_call_Id]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.phoneNumLabel.text=self.phoneNum;
    
}
- (IBAction)onhold:(UIButton*)sender {
    
    static BOOL ishold;
    
    if (!ishold) {
        [[ESPJPhone sharedESPJPhone] ESClientHoldCall:[NSString stringWithFormat:@"%ld",(long)_call_Id]];
        [sender setTitle:@"取回" forState:UIControlStateNormal];
        
    }else
    {
        [[ESPJPhone sharedESPJPhone] ESClientRetriveCall:[NSString stringWithFormat:@"%ld",(long)_call_Id]];
        [sender setTitle:@"保持" forState:UIControlStateNormal];
    }
    ishold=!ishold;
}

- (IBAction)cfeBtn {
    
    [self.alert AlertViewstr:@"会议" call_Id:_call_Id];
}

-(IBAction)transferBtn
{
    [self.alert AlertViewstr:@"转接" call_Id:_call_Id];
    
}

-(void)dealloc
{
    
    [NSNotificationCenter.defaultCenter removeObserver:self];
    
}



@end
