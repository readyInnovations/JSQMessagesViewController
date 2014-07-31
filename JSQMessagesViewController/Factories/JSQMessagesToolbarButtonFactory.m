//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"


@implementation JSQMessagesToolbarButtonFactory

+ (UIButton *)defaultAccessoryButtonItem
{
    UIImage *cameraImage = [UIImage imageNamed:@"camera"];
    UIImage *cameraNormal = [cameraImage jsq_imageMaskedWithColor:[UIColor lightGrayColor]];
    UIImage *cameraHighlighted = [cameraImage jsq_imageMaskedWithColor:[UIColor darkGrayColor]];
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [cameraButton setImage:cameraNormal forState:UIControlStateNormal];
    [cameraButton setImage:cameraHighlighted forState:UIControlStateHighlighted];
    
    cameraButton.contentMode = UIViewContentModeScaleAspectFit;
    cameraButton.backgroundColor = [UIColor clearColor];
    cameraButton.tintColor = [UIColor lightGrayColor];
    
    return cameraButton;
}

+ (UIButton *)defaultSendButtonItem
{
    NSString *sendTitle = NSLocalizedString(@"Send", @"Text for the send button on the messages view toolbar");
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor jsq_messageBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.backgroundColor = [UIColor clearColor];
    sendButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    
    return sendButton;
}

+ (UIButton *)defaultAdditionalButtonItem
{
    NSString *sendTitle = @"QuickReply";
    
    UIButton *additionalRightButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [additionalRightButton setTitle:sendTitle forState:UIControlStateNormal];
    [additionalRightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [additionalRightButton setTitleColor:[[UIColor darkGrayColor] jsq_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [additionalRightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    additionalRightButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    additionalRightButton.contentMode = UIViewContentModeCenter;
    additionalRightButton.backgroundColor = [UIColor clearColor];
    additionalRightButton.tintColor = [UIColor jsq_messageBubbleBlueColor];
    
    return additionalRightButton;
}

@end
