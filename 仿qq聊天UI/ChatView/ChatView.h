//
//  ChatView.h
//  仿qq聊天UI
//
//  Created by pactera on 15/5/20.
//  Copyright (c) 2015年 pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatFrame.h"

@interface ChatView : UIView

@property (retain, nonatomic) ChatFrame      *chatFrame;

@property (retain, nonatomic) UIImageView    *userPhoto;
@property (retain, nonatomic) UILabel        *textLabel;
@end
