//
//  ESIncommingCallVC.m
//  VPhone
//
//  Created by 赖长宽 on 2017/9/18.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESIncommingVC.h"
#import "ESIncomingCallVC.h"


@interface ESIncommingVC ()<ESManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong,nonatomic) ESSwitchImageview * loginView;
@property (strong,nonatomic) ESSwitchImageview * readyView;

@end

@implementation ESIncommingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(siphandleCallStatusChanged:) name:ESPJPhoneCallStatusChangedNotification object: nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"incoming" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
   
    //自动调整尺寸
    _webView.scalesPageToFit = YES;
    //禁止滚动
    _webView.scrollView.scrollEnabled = NO;
    //设置透明效果
    _webView.backgroundColor = [UIColor clearColor];
    _webView.opaque = 0;
    //加载数据
    [_webView loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    
    [self setSwitchview];

}
-(void)setSwitchview
{

}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    self.phoneNumLabel.text=self.phoneNumber;
}


- (IBAction)hangUpAction:(UIButton *)sender {
    [[ESPJPhone sharedESPJPhone]ESClientReleaseCall:[NSString stringWithFormat:@"%d",_callId]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//状态变化
- (void)siphandleCallStatusChanged:(NSNotification *)notification {
    
    ESPCallStatusMessage *message = [ESPCallStatusMessage mj_objectWithKeyValues:notification.userInfo];
    if (message.call_id != self.callId) {
        return;
    }
    if (message.state == ESPJPhoneCallStatus_DISCONNECTED) {
        
    } else if (message.state == ESPJPhoneCallStatus_CONNECTING) {
        NSLog(@"连接中");
    } else if (message.state == ESPJPhoneCallStatus_CONFIRMED) {
        NSLog(@"接听成功！");
    }
}


- (IBAction)answerAction:(UIButton *)sender {
    
    [[ESPJPhone sharedESPJPhone]ESClientAnswerCall:[NSString stringWithFormat:@"%d",_callId]];
    
   ESIncomingCallVC * incallvc= [[ESIncomingCallVC alloc]init];
    
    incallvc.phoneNumber=self.phoneNumber;
    incallvc.ESManagerDelegate=self;
    incallvc.call_Id=self.callId;
    [self presentViewController:incallvc animated:YES completion:nil];
    
}
-(void)diss
{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)dealloc
{
    
    [NSNotificationCenter.defaultCenter removeObserver:self];
    
}
@end
