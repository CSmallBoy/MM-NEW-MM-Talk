//
//  HCNotificationMessageCallCell.h
//  Project
//
//  Created by 朱宗汉 on 16/1/29.
//  Copyright © 2016年 com.xxx. All rights reserved.
//

//---------------------------与我相关 与XXXX通话cell----------------------------------

#import <UIKit/UIKit.h>

@class HCNotifcationMessageInfo;

@interface HCNotificationMessageCallCell : UITableViewCell

@property (nonatomic,strong) HCNotifcationMessageInfo  *messageInfo;

+(instancetype)cellWithTableView:(UITableView *)tableView;
@end