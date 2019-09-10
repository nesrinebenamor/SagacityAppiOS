//
//  AppDelegate.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/28/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <ParseTwitterUtils/ParseTwitterUtils.h>
#import <ParseUI/ParseUI.h>
#import <Bolts/Bolts.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "MTReachabilityManager.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
 
    
 //Notification setting
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    // The following line must only run under iOS 8. This runtime check prevents
    // it from running if it doesn't exist (such as running under iOS 7 or earlier).
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
#endif
    
    // Override point for customization after application launch.
   
    //Parse setApplicationId("pXynpCJEwIDe0GLKpKC3rHINT8QazWFIu3YRSvIq", "5jYthdeLfTTVIn3vqlsBuqpr6iinYfoQqGAWAbJD")
    
    //PFTwitterUtils.initializeWithConsumerKey(“<Your Twitter Consumer Key>", consumerSecret:”<Your Twitter Consumer Secret>")
    //PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions);

    
    [Parse enableLocalDatastore]; // store in database locale
    
    [Parse setApplicationId:@"pXynpCJEwIDe0GLKpKC3rHINT8QazWFIu3YRSvIq"
                  clientKey:@"5jYthdeLfTTVIn3vqlsBuqpr6iinYfoQqGAWAbJD"];
    
    [PFTwitterUtils initializeWithConsumerKey:@"pqIiXwHDvd9KXr04LVPb3H1Gu" consumerSecret:@"mVNZpXXAFdEUhM1jVbw1Tg0JOdhJnj6QvBxEFgcVF8baajsYIM"];
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
 
    
    
    [MTReachabilityManager sharedManager]; // connexion check
    
    // grab correct storyboard depending on screen height
    UIStoryboard *storyboard = [self grabStoryboard];
    
    // display storyboard
    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
    
}


- (UIStoryboard *)grabStoryboard {
    
    // determine screen size
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIStoryboard *storyboard;
    NSString *story;
    switch (screenHeight) {
            
            // iPhone 4s
        case 480:
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main-35" bundle:nil];
            story=@"Main-35";
        }
            break;
            
            // iPhone 5s
        case 568:
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            story=@"Main";

        }
            break;
            
            // iPhone 6
        case 667:
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main-47" bundle:nil];
            story=@"Main-47";

        }
            break;
            
            // iPhone 6 Plus
        case 736:
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main-55" bundle:nil];
            story=@"Main-55";

        }
            break;
            
        default:
        {
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            story=@"Main";

        }
            break;
    }
    
    
    NSUserDefaults *storyB = [ NSUserDefaults standardUserDefaults];
    [storyB setObject:story forKey:@"st"];
    [storyB synchronize];
    
    return storyboard;
}

/*
- (void)createEditableCopyOfDatabaseIfNeeded {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSString *dbPath =[documentsDir stringByAppendingPathComponent:@"SagacityDB1"];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if(!success)
    {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SagacityDB1"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
*/

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
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
    
    [FBSDKAppEvents activateApp];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
  
    
    int numberOfScheduledLocalNotifications = (int)[[[UIApplication sharedApplication] scheduledLocalNotifications] count];
    
    int numberOfEmptyNotificationSlots = 64 - numberOfScheduledLocalNotifications;
    
    
    
    //Sort the scheduledLocalNotifications array by firedate so that the last notification is
    // first in the array.   This way we can find the last notification scheduled and add new notifications after that date.
    //This sorting code was obtained from here.
    
    
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"fireDate" ascending:NO];
    
    NSArray *notifArray = [[[UIApplication sharedApplication] scheduledLocalNotifications] sortedArrayUsingDescriptors:@[sortDes]];
    
    
    //Get the date alert is scheduled for from the local notifications if there are any scheduled, otherwise just use
    //current date
    
    NSDate *fireDate;
    
    if([notifArray count]) {
        UILocalNotification *lastNotif=  [notifArray objectAtIndex:0];
        fireDate = lastNotif.fireDate;
    } else {
        fireDate=[NSDate date];
    }
    
    
    //Create a calendar
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    
    //Create a day component offset, days will be incremented by 1
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init] ;
    [dayComponent setDay:1];
    
    //Configure local notifications, increment day component every time
    for(int i =0;i<numberOfEmptyNotificationSlots;i++) {
        
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        
        //content of the alert message are set from an array of messages set by user, this array can be saved in core
        //data then retrieved here or saved in NSUserDefaults
        localNotif.alertBody = @"testing";
        
        
        localNotif.alertAction = @"Go to App";
        //set the alert schedule date to be a day after the last scheduled notification
        fireDate = [currentCalendar dateByAddingComponents:dayComponent toDate:fireDate options:0];
        
        localNotif.fireDate = fireDate;
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
}
   */
@end
