//
//  ChatView.m
//  仿qq聊天UI
//
//  Created by pactera on 15/5/20.
//  Copyright (c) 2015年 pactera. All rights reserved.
//

#import "ChatView.h"
#import "ChatMessage.h"

@implementation ChatView

- (void)dealloc
{
    [_userPhoto release];
    [_textLabel release];
    [_chatFrame release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent
{
    self.userPhoto = [[[UIImageView alloc] init] autorelease];
    self.textLabel = [[[UILabel alloc] init] autorelease];
    
    [self addSubview:self.userPhoto];
    [self addSubview:self.textLabel];
}

- (void)setChatFrame:(ChatFrame *)chatFrame
{
    if (_chatFrame != chatFrame) {
        
        [_chatFrame release];
        _chatFrame = [chatFrame retain];
        
        self.userPhoto.frame = chatFrame.userPhotoFrame;
        self.textLabel.frame = chatFrame.textLabelFrame;
        self.textLabel.numberOfLines = 0;
        self.textLabel.font  = [UIFont systemFontOfSize:15];
        self.textLabel.layer.cornerRadius = 8;
        
        ChatMessage *chatMsg = chatFrame.chatMsg;
        self.userPhoto.image = [UIImage imageNamed:chatMsg.photo];
        self.textLabel.text  = chatMsg.msg;
    }
//    _chatFrame = chatFrame;
//    [_chatFrame release];
//    _chatFrame = [chatFrame retain];
    
    }

@end
