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

#import "JSQMessagesInputToolbar.h"

#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesComposerTextView.h"

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "UIView+JSQMessages.h"

const CGFloat kJSQMessagesInputToolbarHeightDefault = 44.0f;

static void * kJSQMessagesInputToolbarKeyValueObservingContext = &kJSQMessagesInputToolbarKeyValueObservingContext;


@interface JSQMessagesInputToolbar ()

@property (assign, nonatomic) BOOL jsq_isObserving;

- (void)jsq_leftBarButtonPressed:(UIButton *)sender;
- (void)jsq_rightBarButtonPressed:(UIButton *)sender;
- (void)jsq_additionalRightBarButtonPressed:(UIButton *)sender;

- (void)jsq_addObservers;
- (void)jsq_removeObservers;

@end



@implementation JSQMessagesInputToolbar

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.jsq_isObserving = NO;
    self.sendButtonOnRight = YES;
    
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSQMessagesToolbarContentView class]) owner:nil options:nil];
    JSQMessagesToolbarContentView *toolbarContentView = [nibViews firstObject];
    toolbarContentView.frame = self.frame;
    [self addSubview:toolbarContentView];
    [self jsq_pinAllEdgesOfSubview:toolbarContentView];
    [self setNeedsUpdateConstraints];
    _contentView = toolbarContentView;
    
    [self jsq_addObservers];
    
    self.contentView.leftBarButtonItem = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
    self.contentView.rightBarButtonItem = [JSQMessagesToolbarButtonFactory defaultSendButtonItem];
    self.contentView.additionalRightButtonItem = [JSQMessagesToolbarButtonFactory defaultAdditionalButtonItem];
    
    [self toggleSendButtonEnabled];
}

- (void)dealloc
{
    [self jsq_removeObservers];
    _contentView = nil;
}

#pragma mark - Actions

- (void)jsq_leftBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressLeftBarButton:sender];
}

- (void)jsq_rightBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressRightBarButton:sender];
}

- (void)jsq_additionalRightBarButtonPressed:(UIButton *)sender
{
    [self.delegate messagesInputToolbar:self didPressAdditionalRightBarButton:sender];
}
#pragma mark - Input toolbar

- (void)toggleSendButtonEnabled
{
    BOOL hasText = [self.contentView.textView hasText];
    
    if (self.sendButtonOnRight) {
        self.contentView.rightBarButtonItem.enabled = hasText;
        self.contentView.containerViewForAdditionalButton.hidden = hasText;
    }
    else {
        self.contentView.leftBarButtonItem.enabled = hasText;
    }
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesInputToolbarKeyValueObservingContext) {
        if (object == self.contentView) {
            
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftBarButtonItem))]) {
                
                [self.contentView.leftBarButtonItem removeTarget:self
                                                          action:NULL
                                                forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.leftBarButtonItem addTarget:self
                                                       action:@selector(jsq_leftBarButtonPressed:)
                                             forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem))]) {
                
                [self.contentView.rightBarButtonItem removeTarget:self
                                                           action:NULL
                                                 forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.rightBarButtonItem addTarget:self
                                                        action:@selector(jsq_rightBarButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(additionalRightButtonItem))]) {
                [self.contentView.additionalRightButtonItem removeTarget:self
                                                           action:NULL
                                                 forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.additionalRightButtonItem addTarget:self
                                                        action:@selector(jsq_additionalRightBarButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
                
               

                NSLog(@"surprise me");
            }
        }
    }
}

- (void)jsq_addObservers
{
    if (self.jsq_isObserving) {
        return;
    }
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];

    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(additionalRightButtonItem))
                          options:0
                          context:kJSQMessagesInputToolbarKeyValueObservingContext];
    
    self.jsq_isObserving = YES;
}

- (void)jsq_removeObservers
{
    if (!_jsq_isObserving) {
        return;
    }
    
    @try {
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
        
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                             context:kJSQMessagesInputToolbarKeyValueObservingContext];
        
        [self.contentView removeObserver:self
                           forKeyPath:NSStringFromSelector(@selector(additionalRightButtonItem))
                              context:kJSQMessagesInputToolbarKeyValueObservingContext];
    }
    @catch (NSException *__unused exception) { }
    
    _jsq_isObserving = NO;
}

@end
