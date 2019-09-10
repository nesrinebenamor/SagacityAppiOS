//
//  LoginViewController.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/29/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "LoginViewController.h"
#import "MoodMenu.h"

@interface LoginViewController ()
@property UIActivityIndicatorView *actInd;

@end

@implementation LoginViewController




- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    _actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _actInd.frame=CGRectMake(0, 0, 150, 150);
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}

-(void) viewDidAppear:(BOOL)animated{
    
    if ([PFUser currentUser])
        
    {
        [self presentLoggedInAlert];
        
    }
    else{
        _actInd.center=self.view.center;
        _actInd.hidesWhenStopped=true;
        
        [self.view addSubview:(_actInd)];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(id)sender {
    
    NSString *email;
    NSString *password;
    
    email=self.emailField.text;
    password=self.passwordFied.text;
    
    if(email.length<4 || password.length<5)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid"
                                                        message:@"email wrong or password should be more greater than 5"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
    else{
        [_actInd startAnimating];
        [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
            
            [_actInd stopAnimating];
            
            if (user) {
                // Do stuff after successful login.
                NSLog(@"%@",email);
                NSLog(@"User Logged In");
                [self presentLoggedInAlert];
            } else {
                // The login failed. Check error to see why.
                NSLog(@"User Login failed");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:[error localizedFailureReason]
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                

            }
        }];
    }
}



-(void)presentLoggedInAlert{
    
    NSString *story;
    
    NSUserDefaults *storyB = [ NSUserDefaults standardUserDefaults];
    story =[storyB objectForKey:@"st"] ;

    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:story bundle:nil];
    MoodMenu *vc = [sb instantiateViewControllerWithIdentifier:@"mood"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:NULL];
    
}

- (IBAction)signupAction:(id)sender {
    
    
    [self performSegueWithIdentifier:@"signup" sender:self];
}
- (IBAction)loginfb:(id)sender {
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"public_profile", @"email", @"user_friends"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            [self presentLoggedInAlert];
        } else {
            NSLog(@"User logged in through Facebook!");
            [self presentLoggedInAlert];

        }
    }];
}

- (IBAction)loginTwitter:(id)sender {
    
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
            [self presentLoggedInAlert];

        } else {
            NSLog(@"User logged in with Twitter!");
            [self presentLoggedInAlert];
        }
    }];
}
@end
