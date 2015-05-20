//
//  ChatFrame.h
//  仿qq聊天UI
//
//  Created by pactera on 15/5/20.
//  Copyright (c) 2015年 pactera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMessage.h"

@interface ChatFrame : NSObject

@property (retain, nonatomic) ChatMessage        *chatMsg;

@property (assign, nonatomic,readonly) CGRect    userPhotoFrame;
@property (assign, nonatomic,readonly) CGRect    textLabelFrame;

@property (assign,nonatomic) CGFloat    chatViewHeigh;
@end
