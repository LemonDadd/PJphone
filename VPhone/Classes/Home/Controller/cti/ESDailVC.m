//
//  ESDailVC.m
//  VPhone
//
//  Created by 赖长宽 on 2017/10/16.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "ESDailVC.h"
#import "ESDailingVC.h"
#import <ContactsUI/ContactsUI.h>
#import "SVProgressHUD.h"
@interface ESDailVC ()<CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
@property (weak, nonatomic) IBOutlet UIButton *fiveBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixBtn;
@property (weak, nonatomic) IBOutlet UIButton *sevenBtn;
@property (weak, nonatomic) IBOutlet UIButton *eightBtn;
@property (weak, nonatomic) IBOutlet UIButton *nineBtn;
@property (weak, nonatomic) IBOutlet UIButton *zeroBtn;
@property (weak, nonatomic) IBOutlet UIButton *xingBtn;
@property (weak, nonatomic) IBOutlet UIButton *jingBtn;

@property (weak, nonatomic) IBOutlet UIButton *dailBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;


@property (strong,nonatomic) ESSwitchImageview * loginView;
@property (strong,nonatomic) ESSwitchImageview * readyView;

@end

@implementation ESDailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleCallStatusChanged:) name:@"socketdidReceiveMessage" object:nil];
    
    
}
-(void)setSwitchview
{
    _loginView=[[ESSwitchImageview alloc]initWithOnImageName:@"login.png" offImageName:@"not_logged_in.png"];
    
    _loginView.x=25;
    _loginView.y=22;
    
    [self.view addSubview:_loginView];
    _readyView=[[ESSwitchImageview alloc]initWithOnImageName:@"ready.png" offImageName:@"not_ready.png"];
    
    _readyView.x=CGRectGetMaxX(_loginView.frame)+20;
    _readyView.y=22;
    
    [self.view addSubview:_readyView];
    
}
- (IBAction)oneAction:(UIButton *)sender {
   
    if (sender==_deleteBtn) {
        self.numTF.text=@"";
        return;
    }
    
    if (self.numTF.text) {
        NSString *str = self.numTF.text;
        self.numTF.text = [str stringByAppendingString:sender.titleLabel.text];
    } else {
        self.numTF.text = sender.titleLabel.text;
    }

}
-(void)handleCallStatusChanged:(NSNotification*)userinfo
{
    if ([userinfo.userInfo[@"messageName"]isEqualToString:@"EventError"]){
        
        NSLog(@"电话号码错误了error");
        [SVProgressHUD showErrorWithStatus:@"电话号码错误了"];
        return;
        
    }
    
    NSDictionary * userifodic=userinfo.userInfo[@"data"];
    
    if (userifodic[@"devices"][0][@"userState"][@"state"]) {
        
        NSString * state=userifodic[@"devices"][0][@"userState"][@"state"];
        
        if ([state isEqualToString:@"Ready"]) {
            
            [_readyView isLogin:YES];
   
        }else if ([state isEqualToString:@"NotReady"]){
            [_readyView isLogin:NO];
           
        }else if ([state isEqualToString:@"LoggedOut"]){
          
            [_readyView isLogin:NO];
            [_loginView isLogin:NO];
            [SVProgressHUD dismiss];
        }else if ([state isEqualToString:@"LoggedIn"]){
            
            [_loginView isLogin:YES];

        }
    }

}
- (IBAction)dailAction:(UIButton *)sender {
    
    if (_numTF.hasText) {
        
        if (_numTF.text.length==11) {
            
            _numTF.text=[NSString stringWithFormat:@"90%@",_numTF.text];
        }
      
        
//        if([PJPhone sharedPJPhone].isCTIlogin){
//            [[SocketRocketUtility instance]dialingPhoneNumber:_numTF.text];
//
//            [SVProgressHUD showWithStatus:@"正在呼叫"];
//
//        }else{
            ESDailingVC * dailing=[[ESDailingVC alloc]init];
            dailing.phoneNum=_numTF.text;
            [self presentViewController:dailing animated:YES completion:nil];
            [[ESPJPhone sharedESPJPhone]ESClientMakeCall:_numTF.text];

        //}
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
 
    [self.view endEditing:YES];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if ([PJPhone sharedPJPhone].isCTIlogin) {
//        [self  setSwitchview];
//        SocketRocketUtility * soket= [SocketRocketUtility instance];
//        soket.userName=_userName;
//        soket.CTIserver=_CTIserver;
//        soket.CTIName=_CTIName;
//        soket.CTIpassword=_CTIPswd;
//        [soket socketOpen];
//    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
}

- (IBAction)addressBookBtn:(UIButton *)sender {
    
    CNContactPickerViewController * contactVc = [CNContactPickerViewController new];
    contactVc.delegate = self;
    [self presentViewController:contactVc animated:YES completion:^{
        
    }];
}

#pragma mark - 用户点击联系人获取方法 两个方法都写只调用此方法
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    // 姓氏               名字
    NSLog(@"name:%@%@",contact.familyName,contact.givenName);
    
    //公司名
    NSLog(@"公司: %@",contact.organizationName);
    
    //获取通讯录某个人所有电话并存入数组中 需要哪个取哪个
    for (CNLabeledValue * labValue in contact.phoneNumbers) {
        
        NSString * strPhoneNums = [labValue.value stringValue];
        _numTF.text=strPhoneNums;
    }
    
//    //所有邮件地址数组
//    NSMutableArray * arrMEmails = [NSMutableArray array];
//    for (CNLabeledValue * labValue in contact.emailAddresses) {
//        NSLog(@"email : %@",labValue.value);
//        [arrMEmails addObject:labValue.value];
//    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 用户点进去获取属性调用方法 例如从通讯录选择联系人打电话两个方法都写只调用上面方法
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
    
    //    NSLog(@"contactProperty : %@",contactProperty);
    //    NSLog(@"contact : %@",contactProperty.contact);
    //    NSLog(@"key : %@",contactProperty.key);
    //    [[UIApplication sharedApplication] openURL:url];
    //    NSLog(@"identifier : %@",contactProperty.identifier);
    //    NSLog(@"label : %@",contactProperty.label);
    
    //获得点击的属性,在此进行处理...
    NSLog(@"value : %@",[contactProperty.value stringValue]);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
