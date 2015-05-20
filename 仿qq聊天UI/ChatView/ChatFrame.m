//
//  ChatFrame.m
//  仿qq聊天UI
//
//  Created by pactera on 15/5/20.
//  Copyright (c) 2015年 pactera. All rights reserved.
//

#import "ChatFrame.h"

#define screen_width [UIScreen mainScreen].bounds.size.width

@implementation ChatFrame

- (void)setChatMsg:(ChatMessage *)chatMsg
{
    if (_chatMsg != chatMsg) {
        [_chatMsg release];
        _chatMsg = [chatMsg retain];
        
        _userPhotoFrame = CGRectMake(10, 10, 39, 39);
        
        CGSize textSize = [self getTextSize:_chatMsg.msg];
        _textLabelFrame = CGRectMake(CGRectGetMaxX(_userPhotoFrame) + 10, CGRectGetMinY(_userPhotoFrame) + (39-textSize.height)/2, textSize.width, textSize.height);
        
        _chatViewHeigh = 39.0f;
    }
    }

- (CGSize)getTextSize:(NSString *)text
{
    CGSize maxSize=CGSizeMake(screen_width - 79, MAXFLOAT);
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    
    CGSize textSize = [text boundingRectWithSize:
                       maxSize options:
                       NSStringDrawingUsesLineFragmentOrigin attributes:
                       attr context:nil].size;
    
    return textSize;
}

- (CGFloat)chatViewHeigh
{
    return _chatViewHeigh;
}

@end
