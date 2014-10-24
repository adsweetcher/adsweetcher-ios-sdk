//
//  AppDelegate.h
//  DeleagteTest
//
//  Created by Ivan Gol on 3/31/14.
//  Copyright (c) 2014 Adsweetcher, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Adsweetcher.h"
#import "ViewController.h"
#import "GADBannerView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, AdsweetcherDelegate>{
  GADBannerView *bannerView_;
}

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) ViewController *viewController;


@end
