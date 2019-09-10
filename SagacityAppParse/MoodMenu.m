//

//  MoodMenu.m

//  SagacityAppParse

//

//  Created by Nessrine Ben Amor on 11/28/15.

//  Copyright © 2015 F&N. All rights reserved.

//


#import "MoodMenu.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "HomeViewController.h"
#import <UIColor-HexString/UIColor+HexString.h>


#define angry 100 //id of the button image

#define confused 101

#define happy 102

#define smile 103

#define wondering 104

#define sleepy 105

#define sad 106



@interface MoodMenu ()



@end



@implementation MoodMenu{
    
    AAShareBubbles *shareBubbles; // declaration du animation
    
    float radius; // par rapport au centre
    
    float bubbleRadius; // rayon of the bubble
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    //[[UIView appearance] setTintColor:[UIColor whiteColor]];
    radius = 105;
    
    bubbleRadius = 30;
    
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}






- (IBAction)mood:(id)sender {
    
    
    
    if(shareBubbles) {
        
        shareBubbles = nil;
        
    }
    
    shareBubbles = [[AAShareBubbles alloc] initWithPoint:_moodButton.center radius:radius inView:self.view];
    
    
    
    shareBubbles.delegate = self;
    
    shareBubbles.bubbleRadius = bubbleRadius;
    
    
    
    // initialisation
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"angry"]
     
                          backgroundColor:[UIColor clearColor]
     
                              andButtonId:angry];
    
    
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"confused"]
     
                          backgroundColor:[UIColor clearColor]

     
                              andButtonId:confused];
    
    
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"sad"]
     
                          backgroundColor:[UIColor clearColor]

     
                              andButtonId:sad];
    
    
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"wondering"]
     
                          backgroundColor:[UIColor clearColor]

     
                              andButtonId:wondering];
    
    
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"happy"]
     
                          backgroundColor:[UIColor clearColor]

     
                              andButtonId:happy];
    
    
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"smile"]
     
                          backgroundColor:[UIColor clearColor]

     
                              andButtonId:smile];
    
    
    
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"sleepy"]
     
                          backgroundColor:[UIColor clearColor]

     
                              andButtonId:sleepy];
    
    
    
    
    
    [shareBubbles show]; // affichage
}



#pragma mark -

#pragma mark AAShareBubbles



-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(int)bubbleType

{
    UIImage * buttonImage = [UIImage imageNamed:@"neutral.png"];

    switch (bubbleType) {
            
            
            
        case angry:
            
        { NSLog(@"Custom Button With Type %d", bubbleType);
            
            _mood=@"angry";
            
            self.back.image = [UIImage imageNamed:@"07.jpg"]; // changement de background
            NSLog(@"Custom Button With Type %d", bubbleType);
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FFFF583B"]];
          
            self.view.tintColor = [UIColor colorWithHexString:@"#FFFF583B"]; // change tint
            _mood=@"angry";
            buttonImage = [UIImage imageNamed:@"angry.png"];



        }
            
            break;
            
        case confused:
            
        {
             _mood=@"confused";
            
            NSLog(@"Custom Button With Type %d", bubbleType);
            self.back.image = [UIImage imageNamed:@"01.jpg"];
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FFCE6734"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FFCE6734"]; // change tint
            buttonImage = [UIImage imageNamed:@"confused.png"];


        }
            
            break;
            
        case sad:
            
        {
        _mood=@"sad";
            self.back.image = [UIImage imageNamed:@"04.jpg"];

            NSLog(@"Custom Button With Type %d", bubbleType);
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FF616161"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FF616161"]; // change tint
            buttonImage = [UIImage imageNamed:@"sad.png"];


            
        }
            
            break;
            
        case smile:
            
        {
           _mood=@"love";
            self.back.image = [UIImage imageNamed:@"06.jpg"];

            NSLog(@"Custom Button With Type %d", bubbleType);
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FFCC3232"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FFCC3232"]; // change tint
            buttonImage = [UIImage imageNamed:@"smile.png"];


            
        }
            
            break;
            
        case happy:
            
        {
            _mood=@"happy";
            self.back.image = [UIImage imageNamed:@"02.jpg"];

            NSLog(@"Custom Button With Type %d", bubbleType);
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FFEF1D45"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FFEF1D45"]; // change tint
            buttonImage = [UIImage imageNamed:@"happy.png"];


            
        }
            
            break;
            
        case sleepy:
            
        {
            _mood=@"sleepy";

            self.back.image = [UIImage imageNamed:@"05.jpg"];

            NSLog(@"Custom Button With Type %d", bubbleType);
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FF64909C"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FF64909C"]; // change tint
            buttonImage = [UIImage imageNamed:@"sleepy.png"];


            
        }
            
            break;
            
        case wondering:
            
        {
            _mood=@"wondering";
            self.back.image = [UIImage imageNamed:@"03.jpg"];

            NSLog(@"Custom Button With Type %d", bubbleType);
            
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FFEABA18"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FFEABA18"]; // change tint
            buttonImage = [UIImage imageNamed:@"wondering.png"];


            
        }
            
            break;
            
        default:
        {
            [[UIView appearance] setTintColor:[UIColor colorWithHexString:@"#FFEF1D45"]];
            
            self.view.tintColor = [UIColor colorWithHexString:@"#FFEF1D45"];
        }
            break;
            
    }
    
    _idMood=bubbleType;
    [_moodButton setImage:buttonImage forState:UIControlStateNormal];

    NSUserDefaults *mood = [ NSUserDefaults standardUserDefaults];
    [mood setInteger:_idMood forKey:@"md"];
    [mood synchronize];
    

    
    [self performSegueWithIdentifier:@"home" sender:self];

    
}



-(void)aaShareBubblesDidHide:(AAShareBubbles*)bubbles {
    
    NSLog(@"All Bubbles hidden");
    
}



- (void)viewDidUnload {
    
    [self setMoodButton:nil];
    
    
    [super viewDidUnload];
    
}



- (IBAction)homeAction:(id)sender {

    
   // NSString *mymood = _mood;
    NSUserDefaults *mood = [ NSUserDefaults standardUserDefaults];
    [mood setInteger:_idMood forKey:@"md"];
    [mood synchronize];
    

    
   [self performSegueWithIdentifier:@"home" sender:self];
    
    
}

@end

