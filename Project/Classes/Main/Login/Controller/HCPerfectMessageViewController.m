//
//  HCPerfectMessageViewController.m
//  Project
//
//  Created by 陈福杰 on 15/12/23.
//  Copyright © 2015年 com.xxx. All rights reserved.
//

#import "HCPerfectMessageViewController.h"
#import "HCGradeViewController.h"
#import "HCPerfectMessageApi.h"

@interface HCPerfectMessageViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIButton *womenBtn;
@property (weak, nonatomic) IBOutlet UIButton *menBtn;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;



@end

@implementation HCPerfectMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"完善信息";
    [self setupBackItem];
    _menBtn.selected = YES;
    ViewRadius(_registerBtn, 4);
}
- (IBAction)selectedSexButton:(UIButton *)sender
{
    if (sender.tag)
    {
        _womenBtn.selected = YES;
        _menBtn.selected = NO;
    }else
    {
        _womenBtn.selected = NO;
        _menBtn.selected = YES;
    }
}
- (IBAction)registerButton:(UIButton *)sender
{
    if (IsEmpty(_nameTextField.text))
    {
        [self showHUDText:@"请输入姓名"];
        return;
    }
    if (IsEmpty(_password.text) || IsEmpty(_repassword.text))
    {
        [self showHUDText:@"请输入密码"];
        return;
    }
    if (![_password.text isEqualToString:_repassword.text])
    {
        [self showHUDText:@"输入的密码不一致"];
        return;
    }
    [self requestPerfectMessage];
}

// 服务协议
- (IBAction)serverButton:(UIButton *)sender
{
    [self showHUDText:@"服务协议"];
}

// 隐私政策
- (IBAction)privacyButton:(UIButton *)sender
{
    [self showHUDText:@"隐私政策"];
}

#pragma mark - network 

- (void)requestPerfectMessage
{
    [self showHUDView:nil];
    
    HCPerfectMessageApi *api = [[HCPerfectMessageApi alloc] init];
    api.UserName = self.data[@"phonenumber"];
    api.Token = self.data[@"token"];
    api.TrueName = _nameTextField.text;
    api.UserPWD = _password.text;
    api.Address = [HCAppMgr manager].address;
    NSString *key = @"0";
    if (_womenBtn.selected)
    {
        key = @"1";
    }
    api.Sex = [HCDictionaryMgr getSexStringWithKey:key];
    
    [api startRequest:^(HCRequestStatus requestStatus, NSString *message, NSDictionary *data) {
        if (requestStatus == HCRequestStatusSuccess)
        {
            [self hideHUDView];
            HCGradeViewController *grade = [[HCGradeViewController alloc] init];
            [self.navigationController pushViewController:grade animated:YES];
        }else
        {
            [self showHUDError:message];
        }
    }];
}

@end