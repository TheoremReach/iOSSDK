//
//  AppDelegate.m
//  TheoremReachiOSExampleApp
//
//  Created by Tom Hammond on 6/14/17.
//  Copyright © 2017 theoremreach. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (@available(iOS 14, *)) {
        [self askForIDFAPermissions];
    } else {
        [self initializeTheoremReachSDK];
    }
    
    return YES;
}

- (void)initializeTheoremReachSDK {
    [TheoremReach initWithApiKey:@"9148c4176f36f5302eb0a56695eb" userId:@"23344342252"];
    
    TheoremReach  *tr = [TheoremReach getInstance];
    [tr setRewardListenerDelegate:self];
    [tr setSurveyListenerDelegate:self];
    [tr setSurveyAvailableDelegate:self];
    
    // Moment Example
    // [tr setMomentDelegate:self];
    // [tr enableMoments:YES];
        
    //customize navigation bar look
    tr.navigationBarTextColor = @"#FFFFFF";
    tr.navigationBarText = @"Demo Title";
    tr.navigationBarColor = @"#211548";
}

- (void)askForIDFAPermissions {
    if (@available(iOS 14, *)) {
#if __has_include(<AppTrackingTransparency/AppTrackingTransparency.h>)
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus authStatus) {
            
            if (authStatus == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSLog(@"You have allowed the example app to retrieve your IDFA.");
            } else {
                NSLog(@"You have denied the example app the right to retrieve your IDFA.");
            }
            
            [self initializeTheoremReachSDK];
        }];
#else
        [self initializeTheoremReachSDK];
#endif
    }
}

- (void)onReward: (NSNumber* )quantity {
    // award user the content!
    NSLog(@"TheoremReach onReward: %@", quantity);
}

- (void)onRewardCenterOpened {
    // reward center opened! Time to take surveys!
    NSLog(@"TheoremReach onRewardCenterOpened");
}

- (void)onRewardCenterClosed {
    // reward center opened! Back to the app to use our coins!
    NSLog(@"TheoremReach onRewardCenterClosed");
}

-(void)theoremreachSurveyAvailable: (BOOL) surveyAvailable {
    if (surveyAvailable) {
        NSLog(@"TheoremReach Survey Available!");
    } else {
        NSLog(@"TheoremReach Survey Not Available!");
    }
}

// Moment Survey Callbacks
//-(void)onMomentSurveyOpened {
//    NSLog(@"TheoremReach onMomentSurveyOpened");
//}
//
//-(void)onMomentSurveyClosed {
//    NSLog(@"TheoremReach onMomentSurveyClosed");
//}
//
//-(void)onMomentSurveyReceived: (NSNumber*) surveyLength {
//    NSLog(@"TheoremReach onMomentSurveyReceived: %@", surveyLength);
//}
//
//-(void)onMomentSurveyCompleted {
//    NSLog(@"TheoremReach onMomentSurveyCompleted");
//}
//
//-(void)onMomentSurveyNotEligible {
//    NSLog(@"TheoremReach onMomentSurveyNotEligible");
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
