//
//  AppDelegate.m
//  VPhone
//
//  Created by 赖长宽 on 2017/9/18.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ESLoginVC.h"
#import "ESIncommingVC.h"

@interface AppDelegate ()<ESPJPhoneDelagate>

@end

@implementation AppDelegate

- (void)redirectNSlogToDocumentFolder
{
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];//注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    //先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stderr);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    UIDevice *device = [UIDevice currentDevice];
//    if (![[device model]isEqualToString:@"iPad Simulator"]) {
//        // 开始保存日志文件
//        [self redirectNSlogToDocumentFolder];
//    }
    
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(siphandleCallStatusChanged:) name:@"socketdidReceiveMessage" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(handleIncommingCall:) name:@"SIPIncomingCallNotification" object:nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [[ESLoginVC alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    [[ESPJPhone sharedESPJPhone]startESPJSUA];
    [ESPJPhone sharedESPJPhone].delegate =self;
    
    return YES;
}

-(void)onHandleRegisterStatus:(ESPRegisterMessage *)registerMessage {
    NSDictionary *dic = [registerMessage mj_keyValues];
    [[NSNotificationCenter defaultCenter]postNotificationName:ESPJPhoneRegisterStatusNotification object:nil userInfo:dic];
}

-(void)onEventMessageHandler:(ESPMessage *)message {
   
    if (message.callType ==2) {
        ESIncommingVC *incomingCallVC = [[ESIncommingVC alloc]init];
        incomingCallVC.phoneNumber = message.ANI;
        incomingCallVC.callId = (int)message.connId;
        [[self presentingVC] presentViewController:incomingCallVC animated:YES completion:nil];
    } else {
         NSDictionary *dic = [message mj_keyValues];
        [[NSNotificationCenter defaultCenter]postNotificationName:ESPJPhoneOnEventMessageHandler object:nil userInfo:dic];
    }
}

-(void)onCallStatusChanged:(ESPCallStatusMessage *)callStatus {
     NSDictionary *dic = [callStatus mj_keyValues];
    [[NSNotificationCenter defaultCenter]postNotificationName:ESPJPhoneCallStatusChangedNotification object:nil userInfo:dic];
}


-(UIViewController *)presentingVC{
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        
        
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            
            
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    if ([result isKindOfClass:[UITableViewController class]]) {
        result = [(UITabBarController *)result selectedViewController];
        
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}



- (void)orientationChanged:(NSNotification *)note
{
#if PJSUA_HAS_VIDEO
    const pjmedia_orient pj_ori[4] =
    {
        PJMEDIA_ORIENT_ROTATE_90DEG,  /* UIDeviceOrientationPortrait */
        PJMEDIA_ORIENT_ROTATE_270DEG, /* UIDeviceOrientationPortraitUpsideDown */
        PJMEDIA_ORIENT_ROTATE_180DEG, /* UIDeviceOrientationLandscapeLeft,
                                       home button on the right side */
        PJMEDIA_ORIENT_NATURAL        /* UIDeviceOrientationLandscapeRight,
                                       home button on the left side */
    };
    static pj_thread_desc a_thread_desc;
    static pj_thread_t *a_thread;
    static UIDeviceOrientation prev_ori = 0;
    UIDeviceOrientation dev_ori = [[UIDevice currentDevice] orientation];
    int i;
    
    if (dev_ori == prev_ori) return;
    
    NSLog(@"Device orientation changed: %d", (prev_ori = dev_ori));
    
    if (dev_ori >= UIDeviceOrientationPortrait &&
        dev_ori <= UIDeviceOrientationLandscapeRight)
    {
        if (!pj_thread_is_registered()) {
            pj_thread_register("ipjsua", a_thread_desc, &a_thread);
        }
        
        /* Here we set the orientation for all video devices.
         * This may return failure for renderer devices or for
         * capture devices which do not support orientation setting,
         * we can simply ignore them.
         */
        for (i = pjsua_vid_dev_count()-1; i >= 0; i--) {
            pjsua_vid_dev_set_setting(i, PJMEDIA_VID_DEV_CAP_ORIENTATION,
                                      &pj_ori[dev_ori-1], PJ_TRUE);
        }
    }
#endif
}


-(void)dealloc
{
    
    [NSNotificationCenter.defaultCenter removeObserver:self];
    
}
@end
