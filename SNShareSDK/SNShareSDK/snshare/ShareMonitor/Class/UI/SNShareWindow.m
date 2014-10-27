//
//  SNShareWindow.m
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareWindow.h"

@interface SNShareWindow ()

@property (nonatomic,readwrite) CGRect screenFrame;

@end

@implementation SNShareWindow

static SNShareWindow *instance = nil;
+(SNShareWindow *)sharedSNShareWindow
{
    if (instance == nil) {
        @synchronized(instance){
            if (instance == nil) {
                
                CGRect screenFrame = [UIScreen mainScreen].bounds;
                
                instance = [[SNShareWindow alloc] initWithFrame:screenFrame];
                instance.screenFrame = screenFrame;
                
                instance.windowLevel = UIWindowLevelAlert - 1;
                [instance makeKeyAndVisible];
                
                [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(rotation:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
                
                instance.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.3];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn.frame = CGRectMake(0, 50, 200, 200);
                [btn setTitle:@"Test" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:48];
                [instance addSubview:btn];
            }
        }
    }
    return instance;
}


-(void)showWindowWithDelegate:(id)shareDelegate
{
    _shareDelegate = shareDelegate;
}


-(void)dismissWindow
{
    _shareDelegate = nil;
}


#define degreesToRadians(x) (M_PI*(x)/180.0)
-(void)rotation:(NSNotification *)noti
{
    [UIView beginAnimations:@"rotation" context:nil];
    [UIView setAnimationDuration:0.25];
    if ([[noti.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue] == 4) {
        [UIView setAnimationDuration:0.5];
    }
   
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationPortrait)
    {
        self.transform = CGAffineTransformIdentity;
         self.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
    }else if(orientation == UIInterfaceOrientationLandscapeLeft)
    {
        
        self.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
    }else if(orientation == UIInterfaceOrientationLandscapeRight)
    {
        self.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
    }
    [self layoutSubviews];
    
    [UIView commitAnimations];
}

-(void)layoutSubviews
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        self.bounds = CGRectMake(0, 0, _screenFrame.size.height, _screenFrame.size.width);
        NSLog(@"%@",NSStringFromCGRect(self.frame));
    }else {
        self.bounds = CGRectMake(0, 0, _screenFrame.size.width, _screenFrame.size.height);
    }
}

@end