//
//  ViewController.m
//  仿qq聊天UI
//
//  Created by pactera on 15/5/20.
//  Copyright (c) 2015年 pactera. All rights reserved.
//

//
//  ViewController.m
//  键盘遮挡
//
//  Created by pactera on 15/5/19.
//  Copyright (c) 2015年 pactera. All rights reserved.
//

#import "ViewController.h"
#import "ChatMessage.h"
#import "ChatFrame.h"
#import "ChatView.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITextFieldDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) UIView          *bottomView;
@property (retain, nonatomic) UITextField     *textFiled;
@property (retain, nonatomic) UIButton        *sendBtn;
@property (retain, nonatomic) UITableView     *myTable;

@property (retain, nonatomic) NSMutableArray  *msgArray;
@property (retain, nonatomic) NSMutableArray  *chatViewArray;
@end

@implementation ViewController

- (void)dealloc
{
    [_bottomView release];
    [_textFiled release];
    [_sendBtn release];
    [_myTable release];
    [_chatViewArray release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _msgArray = [[NSMutableArray alloc] init];
    _chatViewArray = [[NSMutableArray alloc] init];
    
    self.myTable = [[[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height - 64 - 50)] autorelease];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.bottomView = [[[UIView alloc] initWithFrame:
                        CGRectMake(0, screen_height - 50, screen_width, 40)] autorelease];
    self.textFiled = [[[UITextField alloc] initWithFrame:
                       CGRectMake(10, 0, screen_width - 100, 40)] autorelease];
    self.textFiled.borderStyle = UITextBorderStyleRoundedRect;
    //    self.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    self.textFiled.delegate = self;
    self.sendBtn = [[[UIButton alloc] initWithFrame:
                     CGRectMake(screen_width - 100, 0, 100, 40)] autorelease];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.myTable];
    [self.bottomView addSubview:self.textFiled];
    [self.bottomView addSubview:self.sendBtn];
    [self.view addSubview:self.bottomView];
    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBorad)];
    [self.view addGestureRecognizer:tapgesture];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//根据键盘高度调整被遮挡的view高
- (void)keyFrameChange:(NSNotification *)nofification
{
    NSValue *keyBoardValue = [nofification.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
    CGRect rect = [keyBoardValue CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(0, screen_height - 50 - rect.size.height, screen_width, 40);
    }];
}

#pragma mark delegate&datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:
                 UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    
    [cell.contentView addSubview:
                      [_chatViewArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatView *chatView = ((ChatView *)[_chatViewArray objectAtIndex:indexPath.row]);
    ChatFrame *chatFrame = chatView.chatFrame;
    return chatFrame.chatViewHeigh;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self closeBorad];
}

- (void)closeBorad
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(0, screen_height - 50, screen_width, 40);
    }];
}

- (void)buttonClick
{
    NSString *contentStr = self.textFiled.text;
    ChatMessage *chatMsg = [[ChatMessage alloc] init];
    chatMsg.msg = contentStr;
    chatMsg.photo = @"head";
    
    ChatFrame *chatFrame = [[ChatFrame alloc] init];
    chatFrame.chatMsg = chatMsg;
    
    ChatView *chatView = [[ChatView alloc] init];
    chatView.chatFrame = chatFrame;
    
    [_chatViewArray addObject:chatView];
    
    [chatView release];
    [chatMsg release];
    [chatFrame release];
    
    _textFiled.text = @"";
    
    [self.myTable reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_chatViewArray.count - 1 inSection:0];
    [self.myTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [self closeBorad];
}
@end

