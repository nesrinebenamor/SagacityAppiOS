//
//  QuoteDetailViewController.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 12/6/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "QuoteDetailViewController.h"
#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"
#import <Social/Social.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ESTabBarController/ESTabBarController.h>

#import <UIColor-HexString/UIColor+HexString.h>

BOOL hasRoundedCorners = YES;

BOOL secure1;
BOOL secure2;
BOOL secure3;

BOOL setKey1;
BOOL setKey2;
BOOL setKey3;

int numFields = 0;

CGFloat width;

@interface QuoteDetailViewController ()<PopupDelegate, UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
NSString *titleText;
NSString *subTitleText;
NSString *cancelText;
NSString *successText;

NSString *keyboard1Type;
NSString *keyboard2Type;
NSString *keyboard3Type;

PopupBackGroundBlurType blurType;
PopupIncomingTransitionType incomingType;
PopupOutgoingTransitionType outgoingType;

Popup *popper;

NSArray *keyboardTypes;
NSArray *incomingTypes;
NSArray *outgoingTypes;
    
    float finalRate;
}

@end

@implementation QuoteDetailViewController


-(void) save{
    
    NSString *str = @"I'm selfish";
    
    //[str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    NSString* requete=[NSString stringWithFormat:@"insert into quote values (null,'%@','%@','%@',%d)",str,@"categorie type",@"this is a quote",1];
    
    [_DB executeQuery:requete];
    
}


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



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

   
    _DB=[[DBManager alloc]initWithDatabaseFilename:@"sagacitydb1"];

    
    ESTabBarController *tabBarController = [[ESTabBarController alloc] initWithTabIconNames:@[@"favoris",
                                                                                              @"rate",
                                                                                              @"share",
                                                                                              ]];

    
    width = self.view.frame.size.width;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissEverything)];
    [tap setNumberOfTapsRequired:1];
    [tap setDelegate:self];
    [self.view addGestureRecognizer:tap];
    
    titleText = @"Rating";
    subTitleText = @"jigfdyyy";
    cancelText = @"Not Now";
    successText = @"Submit";
    
    [self moodChoice];
    //NSString *color;
    tabBarController.selectedColor = [UIColor colorWithHexString:_color];
    tabBarController.buttonsBackgroundColor = [UIColor colorWithHexString:_color];

    [self.view addSubview:tabBarController.view];
    
    tabBarController.view.frame =self.view.bounds;
    tabBarController.view.backgroundColor = [UIColor clearColor];
    
    [self addChildViewController:tabBarController];

    [tabBarController didMoveToParentViewController:self];

    

    __weak QuoteDetailViewController *weakself = self;

    [tabBarController setAction:^{
        //[self save];
        [_DB setAsFavorite:_titreString];
        [weakself showAlertViewWithTitle:@"Favoris"
                                 message:@"Added to your favorites"];
    } atIndex:0];
    
    
    [tabBarController setAction:^{
        [self showPopper];
    } atIndex:1];
    
    [tabBarController setAction:^{
        [self popClick];
    } atIndex:2];

    
    

}


-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
  //  NSString *ratingString = [NSString stringWithFormat:@"Rating: %.1f", rating];
    if( [control isEqual:_starRating] )
      //NSLog(@"%@",ratingString);
    finalRate=rating;
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

-(void)viewDidAppear:(BOOL)animated{
    
    _quoteContent.text=_titreString;
  // NSLog(@"quote content%@",_quoteContent.text);
  // _quoteImage.image= [UIImage imageWithData:_imgData];
    _quoteImage.image = _imgQuote;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            sharePhoto.caption = _quoteContent.text;
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
             if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
             SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
             
             [controller addImage:[UIImage imageWithData:_imgData]];
             [controller setInitialText:@"Sagacity Quote .."];
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
                [tweetSheet setInitialText:_titreString];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UIPickerView Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView tag] == 19 || [pickerView tag] == 20 || [pickerView tag] == 21) {
        return [keyboardTypes count];
    }
    else if ([pickerView tag] == 22) {
        return [incomingTypes count];
    }
    else if ([pickerView tag] == 23) {
        return [outgoingTypes count];
    }
    else return 1;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView tag] == 19 || [pickerView tag] == 20 || [pickerView tag] == 21) {
        return keyboardTypes[row];
    }
    else if ([pickerView tag] == 22) {
        return incomingTypes[row];
    }
    else if ([pickerView tag] == 23) {
        return outgoingTypes[row];
    }
    else return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    UIButton *setOneFieldKeyboardBtn = (UIButton *)[self.view viewWithTag:14];
    UIButton *setTwoFieldKeyboardBtn = (UIButton *)[self.view viewWithTag:16];
    UIButton *setThreeFieldKeyboardBtn = (UIButton *)[self.view viewWithTag:18];
    
    UIButton *inBtn = (UIButton *)[self.view viewWithTag:99];
    UIButton *outBtn = (UIButton *)[self.view viewWithTag:100];
    
    if ([pickerView tag] == 19) {
        setKey1 = YES;
        [setOneFieldKeyboardBtn setTitle:keyboardTypes[row] forState:UIControlStateNormal];
    }
    else if ([pickerView tag] == 20) {
        setKey2 = YES;
        [setTwoFieldKeyboardBtn setTitle:keyboardTypes[row] forState:UIControlStateNormal];
    }
    else if ([pickerView tag] == 21) {
        setKey3 = YES;
        [setThreeFieldKeyboardBtn setTitle:keyboardTypes[row] forState:UIControlStateNormal];
    }
    else if ([pickerView tag] == 22) {
        [inBtn setTitle:incomingTypes[row] forState:UIControlStateNormal];
    }
    else if ([pickerView tag] == 23) {
        [outBtn setTitle:outgoingTypes[row] forState:UIControlStateNormal];
    }
    
}

#pragma mark UITextField Methods


- (void)dismissEverything {
    [self.view endEditing:YES];
    
    UIPickerView *picker19 = (UIPickerView *)[self.view viewWithTag:19];
    UIPickerView *picker20 = (UIPickerView *)[self.view viewWithTag:20];
    UIPickerView *picker21 = (UIPickerView *)[self.view viewWithTag:21];
    UIPickerView *picker22 = (UIPickerView *)[self.view viewWithTag:22];
    UIPickerView *picker23 = (UIPickerView *)[self.view viewWithTag:23];
    
    [picker19 setAlpha:0.0];
    [picker20 setAlpha:0.0];
    [picker21 setAlpha:0.0];
    [picker22 setAlpha:0.0];
    [picker23 setAlpha:0.0];
    
}

#pragma mark Popup Methods

- (void)showPopper {
    
    if (numFields == 0) {
        popper = [[Popup alloc] initWithTitle:titleText subTitle:subTitleText cancelTitle:cancelText successTitle:successText];
        popper= [[Popup alloc] initWithTitle:titleText subTitle:subTitleText cancelTitle:cancelText successTitle:successText color:_color];
        
       CGRect rect = CGRectMake(self.view.bounds.size.width/2 - (180/2), self.view.bounds.size.height/2 - (60/2), 180, 60);
        
        
        _starRating = [[EDStarRating alloc] initWithFrame:rect];
        
        _starRating.userInteractionEnabled=true;
        
        _starRating.backgroundColor  = [UIColor clearColor];
        _starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _starRating.maxRating = 5.0;
        _starRating.delegate = self;
        _starRating.horizontalMargin = 15.0;
        _starRating.editable=YES;
        _starRating.rating= 2.5;
        _starRating.displayMode=EDStarRatingDisplayHalf;
        [_starRating  setNeedsDisplay];
        _starRating.tintColor = [UIColor colorWithHexString:_color];
        [self starsSelectionChanged:_starRating rating:2.5];
        
        [popper addSubview:_starRating];
    }
    
    
    [popper setDelegate:self];
    [popper setBackgroundBlurType:blurType];
    [popper setIncomingTransition:incomingType];
    [popper setOutgoingTransition:outgoingType];
    [popper setRoundedCorners:hasRoundedCorners];
    [popper showPopup];
    
}



- (void)popupWillAppear:(Popup *)popup {
}

- (void)popupDidAppear:(Popup *)popup {
    //self.view.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];


}

- (void)popupWilldisappear:(Popup *)popup buttonType:(PopupButtonType)buttonType {
}

- (void)popupDidDisappear:(Popup *)popup buttonType:(PopupButtonType)buttonType {
//    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)popupPressButton:(Popup *)popup buttonType:(PopupButtonType)buttonType {
    
    if (buttonType == PopupButtonCancel) {
       // NSLog(@"popupPressButton - PopupButtonCancel");
        [_starRating removeFromSuperview];
    }
    else if (buttonType == PopupButtonSuccess) {
        //NSLog(@" idQuote : %@",_idObj);
        
        //NSString *ratingString = [NSString stringWithFormat:@"final Rating: %.1f", finalRate];
        //NSLog(@"%@",ratingString);
        [self updateRate];
        [_starRating removeFromSuperview];

    }
    
}
-(void) updateRate{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Quotes"];
    
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:_idObj
                                 block:^(PFObject *quote, NSError *error) {
                                     
                                     float rate = [[quote objectForKey:@"rate"] floatValue];
                                     int nb = [[quote objectForKey:@"nbVote"] intValue];
                                     
                                     quote[@"nbVote"] = @(nb+1);
                                     quote[@"rate"] = @((float)(rate+finalRate)/(nb+1));
                                     [quote saveInBackground];
                                 }];

}

- (void)dictionary:(NSMutableDictionary *)dictionary forpopup:(Popup *)popup stringsFromTextFields:(NSArray *)stringArray {
    
    NSLog(@"Dictionary from textfields: %@", dictionary);
    NSLog(@"Array from textfields: %@", stringArray);
    
    
}


@end
