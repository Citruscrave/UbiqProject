//
//  AppDelegate.m
//  UbiqProject
//
//  Created by Joey on 10/2/15.
//  Copyright © 2015 Joey. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "HomeViewController.h"
#import "LoginFormViewController.h"
#import "NSString+APIKeys.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.

    
    [Parse enableLocalDatastore];
    // Initialize Parse.
    [Parse setApplicationId:[NSString getParseApplicationID]
                  clientKey:[NSString getParseClientKey]];

//    [Parse setApplicationId:@"7NzdsvlbKBOT194rGdLXZhqjgcoqiADMCoDPRfNc"
//                  clientKey:@"HwXD4oPh1W2Cqd5etAwVSikNWBkgZsXHM5hRS6LF"];
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    if(![PFUser currentUser]) {
        //login screen
        NSLog(@"going to login screen");
        //[self transitionToLoginViewController];
    }
    else {
        NSLog(@"current user!");
        [self transitionToHomeViewController];
        //   [self transitionToHomeViewController];
    }
    
    
    
    return YES;
}

-(void) transitionToLoginViewController {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ /* put code to execute here */
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginFormViewController *loginFormViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:loginFormViewController animated:YES completion:NULL];
        
    });
}

-(void) transitionToHomeViewController {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ /* put code to execute here */
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeViewController *homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeVC"];
        [self.window makeKeyAndVisible];
        [self.window.rootViewController presentViewController:homeViewController animated:YES completion:NULL];

    });
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
