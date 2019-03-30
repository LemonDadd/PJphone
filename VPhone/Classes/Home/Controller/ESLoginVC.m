//
//  ESLoginVC.m
//  VPhone
//
//  Created by 赖长宽 on 2017/9/18.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESLoginVC.h"
#import "ESCTILoginVC.h"
#import "ESDailVC.h"
#import "ESTabBarConreoller.h"

@interface ESLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *serverTF;
@property (weak, nonatomic) IBOutlet UIView *seatView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@property (nonatomic,copy) NSString * server;
@property (nonatomic,copy) NSString * CTIName;
@property (nonatomic,copy) NSString * CTIPswd;

@end
@implementation ESLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleRegisterStatus:) name:@"ESPJPhoneRegisterStatusNotification" object:nil];
    self.seatView.backgroundColor= [[UIColor whiteColor]colorWithAlphaComponent:0.75f];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *strurl = [defaults objectForKey:@"server_uri"];
    NSString *strUsername = [defaults objectForKey:@"username"];
    NSString *password = [defaults objectForKey:@"password"];
    if (strurl&&strUsername&&password) {
        
        _serverTF.text=strurl;
        _usernameTF.text=strUsername;
        _passwordTF.text=password;
    }
    
}
- (IBAction)isSeatBtn:(UIButton* )sender {
    
   
      __weak  ESCTILoginVC * ctilogin=[ESCTILoginVC viewFromXib];
     ctilogin.satView .backgroundColor= [[UIColor whiteColor]colorWithAlphaComponent:0.75f];

          ctilogin.CTIBlock = ^(BOOL islogin ,NSString * server ,NSString *password , NSString*CTIName ) {
              if (islogin) {
                  
                  [sender setImage:[UIImage imageNamed:@"seleted-2"] forState:UIControlStateNormal];
                  _server=server;
                  _CTIName=CTIName;
                  _CTIPswd=password;
                  //[PJPhone sharedPJPhone].isCTIlogin=islogin;
                  
                  [ ctilogin removeFromSuperview];
              }
          };
    
        ctilogin.frame=self.view.frame;
        [self.view addSubview:ctilogin];
}

- (IBAction)loginAction:(UIButton*)sender {
     
    [[ESPJPhone sharedESPJPhone]ESClientRegister:self.serverTF.text dnNumber:self.usernameTF.text dnPassword:self.passwordTF.text];

    
}
- (void)handleRegisterStatus:(NSNotification *)notification {
    ESPRegisterMessage *model = [ESPRegisterMessage mj_objectWithKeyValues:notification.userInfo];
    int status = (int)model.status;
    NSString *statusText =model.status_text;
    if (status !=200) {
        
        NSLog(@"%@",statusText);
        return;
    }
//    if ([PJPhone sharedPJPhone].isCTIlogin) {
//        ESDailVC *dail=[[ESDailVC alloc]init];
//        dail.CTIName=_CTIName;
//        dail.CTIPswd=_CTIPswd;
//        dail.CTIserver=_server;
//        dail.userName=_usernameTF.text;
//        [self presentViewController:dail animated:YES completion:nil];
//    }
    else{
   
        ESTabBarConreoller * teab=[[ESTabBarConreoller alloc]init];
        self.view.window.rootViewController=teab;
//        [self presentViewController:teab animated:YES completion:nil];

    }
    [[NSUserDefaults standardUserDefaults] setObject:_serverTF.text forKey:@"server_uri"];
    [[NSUserDefaults standardUserDefaults] setObject:_usernameTF.text  forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:_passwordTF.text  forKey:@"password"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *_Nonnull)esClientGetInfoPlistUrl
{
    NSDictionary*infoDic = [[NSBundle mainBundle] infoDictionary];
    
    NSString *ESClientUrl = [infoDic objectForKey:@"SipServer"];
    
    return ESClientUrl;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}


@end
