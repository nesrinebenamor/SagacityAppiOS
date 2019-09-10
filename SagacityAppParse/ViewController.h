//
//  ViewController.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/28/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <ParseTwitterUtils/ParseTwitterUtils.h>
#import <Bolts/Bolts.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>


@end

