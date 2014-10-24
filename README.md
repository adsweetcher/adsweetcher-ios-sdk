Adsweetcher SDK
===============

Adsweetcher iOS SDK Integration

1. Clone SDK from github.com
       https://github.com/adsweetcher/AdsweetcherSDK.git
2. Drop Adsweetcher SDK into your Xcode project
3. Copy your Application Token   
![alt text](http://adsweetcher.com/assets/img/instructions/ApplicationToken.png)
4. In you AppDelegate.m or other class add:    ```objc   
#import "Adsweetcher.m"   
```
5. Initialize Adsweetcher    
```objc      
- (void)applicationDidBecomeActive:(UIApplication *)application
{  
	//initialization
	[[Adsweetcher sharedInstance]
	setAppToken:@"8116c10f8c544d9faa7919399777de5b"];
	[[Adsweetcher sharedInstance] setDelegate:self];
 
	//retrieve selected Ad Network value
	[Adsweetcher sharedInstance] retrieveAdsNetworkSettings];
 
}    
```  
6. Integrate Ad Network SDKs login in appropriate delegate methods, f.e - (void) chartboostBoot; for Chartboost
7. Integrate - (void) defaultAdNetwork; method to make sure Ad Network from this method will boot if Adsweetcher workspace was not properly configured.   
8. To see a full list of your Ad Networks needed to be integrated click Show in Template column     
 ![alt text](http://adsweetcher.com/assets/img/instructions/Template.png)     
9. Sample application with Chartboost, Revmob and Admob integration
       https://github.com/adsweetcher/iOS_SampleApp.git

For more information please visit [AdSweetcher.com](http://www.adsweetcher.com)
