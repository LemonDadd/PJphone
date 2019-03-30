//
//  ESIncomingCallVC.m
//  VPhone
//
//  Created by 赖长宽 on 2017/10/23.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESIncomingCallVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ESTimerLabelText.h"
#import "ESAlertAction.h"

@interface ESIncomingCallVC ()<ESPJPhoneDelagate>
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;

@property (strong,nonatomic) ESSwitchImageview * loginView;
@property (strong,nonatomic) ESSwitchImageview * readyView;
@property (weak, nonatomic) IBOutlet UIButton *huiyiBtn;
@property (nonatomic,assign) BOOL isCall;
@property (nonatomic,assign) NSInteger call_id2;
@property (nonatomic,strong) ESPJPhone * pj;
//@property (nonatomic,strong) ESPlayAudio * speaker;
@property (nonatomic,strong) ESTimerLabelText * tiemrText;
@property (nonatomic,strong) ESAlertAction * alert;

@end

@implementation ESIncomingCallVC
-(ESAlertAction *)alert
{
    if (!_alert) {
        
        _alert=[[ESAlertAction alloc]init];
    }
    return _alert;
}

-(ESTimerLabelText *)tiemrText
{
    if (!_tiemrText) {
        _tiemrText=[[ESTimerLabelText alloc]init];
    }
    return _tiemrText;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSwitchview];

    _pj=[ESPJPhone sharedESPJPhone];
    _pj.delegate =self;
}

-(void)onCallStatusChanged:(ESPCallStatusMessage *)callStatus {
    if (!_pj.isConferenceCall) {
        _call_Id=callStatus.call_id;
        
    }else{
        _call_id2=callStatus.call_id;
    }
    if (callStatus.state == ESPJPhoneCallStatus_DISCONNECTED) {
        
    } else if (callStatus.state == ESPJPhoneCallStatus_CONNECTING) {
        NSLog(@"连接中");
    } else if (callStatus.state == ESPJPhoneCallStatus_CONFIRMED) {
        NSLog(@"接听成功！");
    }
}

-(void)onEventMessageHandler:(ESPMessage *)message {
    if ([message.messageName isEqualToString:@"EventEstablished"]) {
        if(_pj.isConferenceCall){
            
        }else{
            
            [self.tiemrText startTimerLabel:self.timerLabel];
        }
        _isCall=YES;
    }else if ([message.messageName isEqualToString:@"EventReleased"]){
        if ([ESPJPhone sharedESPJPhone].isConferenceCall) {
            _pj.isConferenceCall = NO;
            return;
        }
        [self.tiemrText endTimer];
        //[self.speaker setAudioSession];
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
        if (_isCall) {
            if ([_ESManagerDelegate respondsToSelector:@selector(diss)]) {
                _isCall=NO;
                
                [_ESManagerDelegate diss];
                
            }
        }
    }
}

-(void)setSwitchview
{
    self.phoneNumLabel.text=_phoneNumber;
}

- (IBAction)hangup:(id)sender {
    [[ESPJPhone sharedESPJPhone]ESClientHangup:_call_id2 requestMessage:@"BYE"];
}


- (IBAction)Conference:(id)sender {
    
    [self.alert AlertViewstr:@"会议" call_Id:_call_Id];
}

- (IBAction)Transfer:(id)sender {
    [self.alert AlertViewstr:@"转接" call_Id:_call_Id];

}

- (IBAction)holdBtn:(id)sender {
    
    static BOOL ishold;
    
    if (!ishold) {
        [_pj ESClientHoldCall:[NSString stringWithFormat:@"%ld",(long)_call_Id]];
        
    }else
    {
        [_pj ESClientRetriveCall:[NSString stringWithFormat:@"%ld",(long)_call_Id]];
    }
    
    ishold=!ishold;
 }
- (IBAction)speakerBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"speaker-select.png"] forState:UIControlStateNormal];
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        //设置为播放
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
    }else{
        [sender setImage:[UIImage imageNamed:@"speaker.png"] forState:UIControlStateNormal];
        AVAudioSession *audioSession=[AVAudioSession sharedInstance];
        //设置为播放和录音状态，以便可以在录制完之后播放录音
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [audioSession setActive:YES error:nil];
        
    }
}


-(void)dealloc
{
    _timerLabel.text=nil;
    [NSNotificationCenter.defaultCenter removeObserver:self];
    
}
@end
