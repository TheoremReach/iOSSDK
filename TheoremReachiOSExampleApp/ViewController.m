//
//  ViewController.m
//  TheoremReachiOSExampleApp
//
//  Created by Tom Hammond on 6/14/17.
//  Copyright © 2017 theoremreach. All rights reserved.
//

#import "ViewController.h"
#import <TheoremReachSDK/TheoremReach.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)launchTheoremReach:(id)sender {
    if ([[TheoremReach getInstance] isSurveyAvailable]) {
        // placement example for additional targeting
        // [TheoremReach showRewardCenter:@"be4aa618-3c11-498a-92f9-43bb01f2a4c9"];
        [TheoremReach showRewardCenter];
    }
    
        // Moment Survey example
//        if ([[TheoremReach getInstance] isSurveyAvailable:[NSNumber numberWithInt:1]]) {
//            [TheoremReach showMomentSurvey];
//        }
}

@end
