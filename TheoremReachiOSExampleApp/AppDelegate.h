//
//  AppDelegate.h
//  TheoremReachiOSExampleApp
//
//  Created by Tom Hammond on 6/14/17.
//  Copyright © 2017 theoremreach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TheoremReachSDK/TheoremReach.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, TheoremReachRewardDelegate, TheoremReachSurveyDelegate, TheoremReachSurveyAvailableDelegate/*, TheoremReachMomentDelegate */ >

@property (strong, nonatomic) UIWindow *window;
- (void)initializeTheoremReachSDK;
- (void)askForIDFAPermissions;
@end
