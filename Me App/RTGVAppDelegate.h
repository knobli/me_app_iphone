//
//  RTGVAppDelegate.h
//  Me App
//
//  Created by XCode Developer on 7/22/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTGVAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,readonly) int networkActivityCounter;
-(void) incrementNetworkActivity;
-(void) decrementNetworkActivity;
-(void) resetNetworkActivity;

@end
