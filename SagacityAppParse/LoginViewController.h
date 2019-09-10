//
//  LoginViewController.h
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/29/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <ParseTwitterUtils/ParseTwitterUtils.h>
#import <ParseUI/ParseUI.h>
#import <Bolts/Bolts.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController
- (IBAction)loginAction:(id)sender;

- (IBAction)signupAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UITextField *passwordFied;

//@property UIActivityIndicatorView *actInd ;

- (IBAction)loginfb:(id)sender;

- (IBAction)loginTwitter:(id)sender;

@end

