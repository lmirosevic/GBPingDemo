//
//  GBAppDelegate.h
//  PIngTest
//
//  Created by Luka Mirosevic on 15/11/2012.
//  Copyright (c) 2012 Goonbee. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GBPing.h"

@interface GBAppDelegate : UIResponder <UIApplicationDelegate, GBPingDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GBPing *ping;

@end
