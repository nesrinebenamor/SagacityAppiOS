//
//  CollectionDetailViewController.m
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/20.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "CollectionDetailViewController.h"

#import <sqlite3.h>
#import <Social/Social.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ESTabBarController/ESTabBarController.h>
#import <UIColor-HexString/UIColor+HexString.h>


#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"


@interface CollectionDetailViewController () <YSLTransitionAnimatorDataSource>

@property (nonatomic, weak) IBOutlet UIImageView *headerImageView;
//@property (nonatomic, retain) IBOutlet UITabBarController *tcTabBar;
//@property (weak, nonatomic) IBOutlet UITabBar *tabBar;

@end

@implementation CollectionDetailViewController

-(void)moodChoice{
    NSInteger id=0;
    NSUserDefaults *mood = [ NSUserDefaults standardUserDefaults];
    id =[[mood objectForKey:@"md"] intValue];
    
    
    
    switch (id) {
        case 100:
        {
            //   _mood = @"angry";
           // self.back.image = [UIImage imageNamed:@"07.jpg"];
            _color=@"#FFFF583B";
            
            
        }
            break;
        case 101:
        {
            //   _mood = @"confused";
           // self.back.image = [UIImage imageNamed:@"01.jpg"];
            
            _color=@"#FFCE6734";

            
        }
            break;
        case 102:
        {
            // _mood = @"happy";
          //  self.back.image = [UIImage imageNamed:@"02.jpg"];
            _color=@"#FFEF1D45";

            
            
        }
            break;
        case 103:
        {
            // _mood = @"inlove";
           // self.back.image = [UIImage imageNamed:@"02.jpg"];
            _color=@"#FFCC3232";

            
            
        }
            break;
        case 104:
        {
            //   _mood = @"wondering";
          //  self.back.image = [UIImage imageNamed:@"03.jpg"];
            
            _color=@"#FFEABA18";

            
        }
            break;
        case 105:
        {
            //  _mood = @"sleepy";
           // self.back.image = [UIImage imageNamed:@"02.jpg"];
            
            _color=@"#FF64909C";

        }
            break;
        case 106:
        {
            //    _mood = @"sad";
            
            //self.back.image = [UIImage imageNamed:@"04.jpg"];
            _color=@"#FF616161";

            
            
        }
            break;
            
        default:
        {  // _mood = @"neutral";
            //self.back.image = [UIImage imageNamed:@"02.jpg"];
            _color=@"#FF5252";

        }
            
            
            break;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self ysl_removeTransitionDelegate];
    _titre.text=@"";

}

- (void)viewDidAppear:(BOOL)animated
{
    [self ysl_addTransitionDelegate:self];
    [self ysl_popTransitionAnimationWithCurrentScrollView:nil
                                    cancelAnimationPointY:0
                                        animationDuration:0.3
                                  isInteractiveTransition:YES];

    _titre.text=_titreString;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
 
    _DB=[[DBManager alloc]initWithDatabaseFilename:@"sagacitydb1"];

    ESTabBarController *tabBarController = [[ESTabBarController alloc] initWithTabIconNames:@[@"favoris",
                                                                                              @"share",
                                                                                              ]];
  
    
    CGRect rect = [UIScreen mainScreen].bounds;
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    // header
    // If you're using a xib and storyboard. Be sure to specify the frame
    _headerImageView.frame = CGRectMake(0, statusHeight + navigationHeight, rect.size.width, 250);
    
    // custom navigation left item
    __weak CollectionDetailViewController *weakself = self;
    [self ysl_setUpReturnBtnWithColor:[UIColor lightGrayColor]
                      callBackHandler:^{
                          [weakself.navigationController popViewControllerAnimated:YES];
                      }];
    
    
    [self moodChoice];
    tabBarController.selectedColor = [UIColor colorWithHexString:_color];
    tabBarController.buttonsBackgroundColor = [UIColor colorWithHexString:_color];
    
  
    [self addChildViewController:tabBarController];

   [self.view addSubview:tabBarController.view];
    
    
    tabBarController.view.frame =self.view.bounds;
    tabBarController.view.backgroundColor = [UIColor clearColor];
    
    [tabBarController didMoveToParentViewController:self];

    
   // _DB=[[DBManager alloc]initWithDatabaseFilename:@"SagacityDB"];

    _titre.text=@"";

    
    [tabBarController setAction:^{
        //[self save];
       // NSLog(@"this is a test %@",_titreString);
        // NSLog(@"&&&&&&& this is a test %@",_titre.text);
        [_DB setAsFavorite:_titreString];

        [weakself showAlertViewWithTitle:@"Favoris"
                                 message:@"add to your favorites"];
    } atIndex:0];
    
    
    [tabBarController setAction:^{
        [self popClick];
    } atIndex:1];

}


-(void) save{
    NSInteger favor=1;
    
    NSLog(@"%@",_titreString);
    
    NSString * requette = [NSString stringWithFormat:@"insert into Citations ('text','url','fav') values ('%@' , '%@' , %ld) ",_titreString,@"ggg", (long)favor];
    
    [_DB executeQuery:requette];
    
}

#pragma mark - Private methods


- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}


- (void)popClick
{
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:@"Share to"];
    [poplistview show];
}


#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)popTransitionImageView
{
    return self.headerImageView;
}

- (UIImageView *)pushTransitionImageView
{
    return nil;
}


#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
    
 int row = indexPath.row;
    
    if(row == 0){
        cell.textLabel.text = @"Facebook";
        cell.imageView.image = [UIImage imageNamed:@"fb.png"];
    }else if (row == 1){
        cell.textLabel.text = @"Twitter";
        cell.imageView.image = [UIImage imageNamed:@"twitter.png"];
    }
    
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:{
            NSLog(@"facebook");
            
            FBSDKSharePhoto *sharePhoto = [[FBSDKSharePhoto alloc] init];
            sharePhoto.caption = _titre.text;
            sharePhoto.image = [UIImage imageWithData:_imgData];
            
    
           

            FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc] init];
            content.photos = @[sharePhoto];
            
           // [FBSDKShareAPI shareWithContent:content delegate:nil];
            
            
          
            
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fbauth2://"]]){
                
                [FBSDKShareDialog showFromViewController:self
                                             withContent:content
                                                delegate:nil];
            }
            else {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
           
            
            /*
            FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
           // content.contentURL = [NSURL URLWithString:@"https://developers.facebook.com"];
            

           
        
            */
            /*
            if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                
                [controller addImage:[UIImage imageWithData:_imgData]];
                [controller setInitialText:_titre.text];
                [self presentViewController:controller animated:YES completion:Nil];

                //  [self.navigationController pushViewController:controller animated:YES];

            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't post right now, make sure your device has an internet connection and you have at least one facebook account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
            
            */
            
        }
            break;
        case 1:
        {            NSLog(@"twitter");

            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:@"I Hate my life"];
             //   [self presentViewController:tweetSheet animated:YES completion:nil];
                [self.navigationController pushViewController:tweetSheet animated:YES];

            }
        }
        
        default:{
            NSLog(@"Email");
        }
            break;
    }
    // your code here
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}



@end
