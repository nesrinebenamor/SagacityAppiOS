//
//  SignUpViewController.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/29/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "MoodMenu.h"

@interface SignUpViewController ()
@property UIActivityIndicatorView *actInd;

@end

@implementation SignUpViewController


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

- (IBAction)signupAction:(id)sender {
    
    
    
    NSString *email;
    NSString *password;
    NSString *name;
    email=self.emailField.text;
    password=self.passwordField.text;
    name=self.firstnameField.text;
    if(email.length<8 || password.length<5)
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
       PFUser *user = [PFUser user];
        
        NSLog(@"this is an email %@",email);
        NSLog(@"this is your name %@",name);
        
        user.password=password;
        user.email=email;
        user.username=email;
        user[@"firstName"]=name;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            [_actInd stopAnimating];
            if(error != nil)
            {
                NSLog(@"User signup failed");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email adress already taken"
                                                                message:[error localizedFailureReason]
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
   
            }
            else
            {
                [self performSegueWithIdentifier:@"moodmenu" sender:self];

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

@end
