//
//  AppDelegate.m
//  DeleagteTest
//
//  Created by Ivan Gol on 3/31/14.
//  Copyright (c) 2014 Adsweetcher, LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "Chartboost.h"
#import <RevMobAds/RevMobAds.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[Adsweetcher sharedInstance] setAppToken:@"9d74944e56464b32a8d87df489e5cf33"];
    [[Adsweetcher sharedInstance] setDelegate:self];
    [[Adsweetcher sharedInstance] retrieveAdsNetworkSettings];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) defaultAdNetwork{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test window (DEFAULT)"
                                                    message:@"Default Network Loaded"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [self chartboostBoot];
}

- (void) chartboostBoot{
    [Chartboost startWithAppId:@"66dc82052d42da70a1f8a96f" appSignature:@"gf5ddd6662dc274ef1a09644fcb0c0f9fd02bcc9" delegate:self];
    
    // Show an ad at location "CBLocationHomeScreen"
    [[Chartboost sharedChartboost] showInterstitial:CBLocationHomeScreen];
}

- (void) revmobBoot{
    [RevMobAds startSessionWithAppID:@"52dd75b7a39ee7157200006a"];
    [[RevMobAds session] showFullscreen];
}

- (void) admobBoot{
    // Create a view of the standard size at the top of the screen.
    // Available AdSize constants are explained in GADAdSize.h.
    if (nil == bannerView_){
        bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
        // Specify the ad unit ID.
        bannerView_.adUnitID = @"ca-app-pub-9890962870965050/3542931923";
    
        // Let the runtime know which UIViewController to restore after taking
        // the user wherever the ad goes and add it to the view hierarchy.
        self.viewController = (ViewController*)  self.window.rootViewController;
        bannerView_.rootViewController = self.viewController;
        [self.viewController.view addSubview:bannerView_];
    
        // Initiate a generic request to load it with an ad.
        [bannerView_ loadRequest:[GADRequest request]];
    }
}

@end
