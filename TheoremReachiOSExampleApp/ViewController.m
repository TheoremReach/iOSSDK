//
//  ViewController.m
//  TheoremReachiOSExampleApp
//
//  Created by Tom Hammond on 6/14/17.
//  Copyright © 2017 theoremreach. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <TheoremReachSDK/TheoremReach.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self initializeTheoremReachSDK];
    });
}

- (void)initializeTheoremReachSDK {
    AppDelegate* appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    if (!appDelegate.didBecomeActive) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self initializeTheoremReachSDK];
        });
        
        return;
    }
    
    [appDelegate askForIDFAPermissions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)launchTheoremReach:(id)sender {
    AppDelegate* appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    [appDelegate initializeTheoremReachSDK];
}

@end
