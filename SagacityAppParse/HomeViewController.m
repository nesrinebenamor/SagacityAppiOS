//
//  HomeViewController.m
//  SagacityApp
//
//  Created by Nessrine Ben Amor on 11/22/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "HomeViewController.h"
#import "Quote.h"
#define KCellIdentifier @"identifier"
#import "ShowImageCell.h"
#import "CircleLayout.h"
#import "QuoteDetailViewController.h"
#import <UIColor-HexString/UIColor+HexString.h>

@interface HomeViewController ()


@end

@implementation HomeViewController

- (void)setQuoteSting:(NSString*)quoteSting
{

    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"“’abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-"".!?*@,;/;' "];
    
    
    NSString *firstWord = [[quoteSting componentsSeparatedByString:@" "] objectAtIndex:0];
     
        s = [s invertedSet];
    
    NSLog(@"First Word %@",firstWord);
    NSRange r = [firstWord rangeOfCharacterFromSet:s];
    
    if (r.location != NSNotFound) {
        NSLog(@"the quote is chineese");
        [self showRandomQuote];

    }
    else
    {NSLog(@"the quote is english");
        _quoteSting = quoteSting;
        self.quoteText.text = quoteSting;}
}

- (void)showRandomQuote
{
    Quote *quote = [[Quote alloc] init];
    
    
    [quote getQuote:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.quoteSting = [NSString stringWithFormat:@"“%@ \n ” ― %@",
                           responseObject[@"body"],
                           responseObject[@"author"]];        
       
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UITextView *tv = object;
    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale]) / 2.0;
    topCorrect = (topCorrect < 0.0 ? 0.0 : topCorrect);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



- (void)viewDidLoad {

    [super viewDidLoad];
    
    
    NSMutableArray *tips2;
    tips2 = [NSMutableArray arrayWithObjects:
             @"Welcome To Sagacity",
             @"Every day in every way I am getting happier and happier.",
             @"I am thankful to everybody who has touched my life and made it worth living. ",
             @"Happiness is contagious. My happiness makes all these people happy, thus making it one big happy world.",
             @"My happy disposition attracts happiness into my life and I only interact with happy people and have only happy experiences.",
             @"I spread happiness to others and absorb happiness from others. I enjoy every moment of the day.",
             @"Be happy is my motto and happiness is not a destination. It’s my way of life.",
             @"I am living my life, feeling motivated and excited about the greatness I am creating, on a daily basis.",
             @"I am going to make the best out of my life. I will appreciate all opportunities which are given to me and follow my way.",
             @"I truly believe that everything that we do and everyone that we meet is put in our path for a purpose. There are no accidents; we're all teachers - if we're willing to pay attention to the lessons we learn, trust our positive instincts and not be afraid to take risks or wait for some miracle to come knocking at our door.",
             @"Keep your face to the sunshine and you cannot see a shadow.",
             @"We can complain because rose bushes have thorns, or rejoice because thorn bushes have roses.",
             @"Get going. Move forward. Aim High. Plan a takeoff. Don't just sit on the runway and hope someone will come along and push the airplane. It simply won't happen. Change your attitude and gain some altitude. Believe me, you'll love it up here.",
             @"Hope for love, pray for love, wish for love, dream for love…but don’t put your life on hold waiting for love.",
             @"You are essentially who you create yourself to be and all that occurs in your life is the result of your own making.",
             @"ife is like a game of chess.To win you have to make a move.Knowing which move to make comes with IN-SIGHT and knowledge, and by learning the lessons that are acculated along the way.We become each and every piece within the game called life!",
             @"When you arise in the moring, think of what a precious privelege it is to be alive-- to breathe, to think, to enjoy, to love",
             @"There is nothing in this world that you cannot do. Every goal is achievable. You just need to focus on your objectives, be persistent in your efforts and work hard to make it happen. There can be no hurdle uncrossable, no obstacle invincible and no stumbling block insurmountable.",
             @"The author, then in the final stage as a candidate for Delta Force, was asked by the unit's foreboding colonel what he thought of the evaluation's Stress Week. He responded that he was waiting for it to begin, reasoning that, used to responsibility for others while leading a platoon, he only had himself to worry about. However hard the trial, he got four meals a day, nobody shot at, him, and the weather was pleasant.",nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    // Break the date up into components
    NSDateComponents *dateComponents =[[NSDateComponents alloc] init] ;
    
    NSDateComponents *timeComponents = [[NSDateComponents alloc] init] ;
    
    
    
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    
    // Set up the fire time
    
    // Notification will fire in one minute
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    for(int i=0;i<[tips2 count];i++)
    {
        [dateComps setDay:[dateComponents day]];
        [dateComps setMonth:[dateComponents month]];
        [dateComps setYear:[dateComponents year]];
        [dateComps setHour:[timeComponents hour]];
        [dateComps setMinute:[timeComponents minute]];
        [dateComps setSecond:[timeComponents second]];
        
        itemDate = [calendar dateByAddingComponents:dateComps toDate:itemDate options:0];
        
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        
        if (localNotif == nil)
            return;
        //localNotif.fireDate = itemDate;
        localNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow: 60*60*(i+1)];
        
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        
        // Notification details
        localNotif.alertBody = [tips2 objectAtIndex:i];
        // Set the action button
        localNotif.alertAction = @"View";
        
        localNotif.soundName = UILocalNotificationDefaultSoundName;
        
        // Specify custom data for the notification
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
        localNotif.userInfo = infoDict;
        
        // Schedule the notification
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }

   // [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.26 green:0.44 blue:0.38 alpha:0.2]];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    _isParsed =false;
    
    NSInteger id=0;
    NSUserDefaults *mood = [ NSUserDefaults standardUserDefaults];
    id =[[mood objectForKey:@"md"] intValue];
    UIImage * buttonImage = [UIImage imageNamed:@"neutral.png"];
    
    
    switch (id) {
        case 100:
        {
        _mood = @"angry";
        self.back.image = [UIImage imageNamed:@"07.jpg"];
        self.test.image=[UIImage imageNamed:@"angrySpeech.jpg"];
        buttonImage = [UIImage imageNamed:@"angry.png"];

            
        }
            break;
        case 101:
        {
            _mood = @"confused";
            self.back.image = [UIImage imageNamed:@"01.jpg"];
            self.test.image=[UIImage imageNamed:@"speechConfuesd.jpg"];
            
            buttonImage = [UIImage imageNamed:@"confused.png"];


            
        }
            break;
        case 102:
        {
            _mood = @"happy";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            self.test.image=[UIImage imageNamed:@"speechNormal.jpg"];
            buttonImage = [UIImage imageNamed:@"happy.png"];


            
        }
            break;
        case 103:
        {
            _mood = @"inlove";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            self.test.image=[UIImage imageNamed:@"inlove.jpg"];
            
            buttonImage = [UIImage imageNamed:@"smile.png"];

            
        }
            break;
        case 104:
        {
            _mood = @"wondering";
            self.back.image = [UIImage imageNamed:@"03.jpg"];
            self.test.image=[UIImage imageNamed:@"sppechWorry.jpg"];
            buttonImage = [UIImage imageNamed:@"wondering.png"];
            
        }
            break;
        case 105:
        {
            _mood = @"sleepy";
            self.back.image = [UIImage imageNamed:@"03.jpg"];

            self.test.image = [UIImage imageNamed:@"sppechSleepy.jpg"];

            buttonImage = [UIImage imageNamed:@"sleepy.png"];

        }
            break;
        case 106:
        {
            _mood = @"sad";
            self.back.image = [UIImage imageNamed:@"04.jpg"];
            self.test.image=[UIImage imageNamed:@"sadSpeech.jpg"];
            buttonImage = [UIImage imageNamed:@"sad.png"];


            
        }
            break;
            
        default:
        {   _mood = @"neutral";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            self.test.image=[UIImage imageNamed:@"speechNormal.jpg"];
            buttonImage = [UIImage imageNamed:@"neutral.png"];

        }


        break;
    }
   
   
    [_moodBtn setImage:buttonImage forState:UIControlStateNormal];

    
    _viewNotification.hidden=YES;
    _notif.text=@"";
    
    self.reachability = [Reachability reachabilityWithHostName:@"www.parse.com"];
    
    NetworkStatus ns = self.reachability.currentReachabilityStatus;
    
    if (ns == NotReachable)
    {
        
         NSString* msg = @"Network problems ";
         UIAlertView* av = [[UIAlertView alloc] initWithTitle:nil
         message:msg
         delegate:self
         cancelButtonTitle:@"Ok"
         otherButtonTitles:nil];
         [av show];
         
 
        
         _notif.text=@"Network Problems";
         _viewNotification.hidden=NO;
         _viewNotification.backgroundColor=[UIColor redColor];
         [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];
         
         }
    else
    {
     [self showRandomQuote];
    }
         
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
         
         
         
         self.reachability = [Reachability reachabilityWithHostName:@"www.parse.com"];
         [self.reachability startNotifier];
         
         
    
    NSString *notif=@"";
    
    notif = [self getNotif];
    
    
    
    
    
    NSString *story;
    
    NSUserDefaults *storyB = [ NSUserDefaults standardUserDefaults];
    story =[storyB objectForKey:@"st"] ;
    
    float start=0.0f;
    
    if([story isEqualToString:@"Main-47"] || [story isEqualToString:@"Main-55"] )
    {
        start=25.0f;
    }
    else
        start =0.0f;
         // Do any additional setup after loading the view.
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    self.quotesCollections = [[UICollectionView alloc] initWithFrame:CGRectMake(start, height/2-100, width, height)
                                             collectionViewLayout:[[CircleLayout alloc] init]];
    [self.quotesCollections registerClass:[ShowImageCell class] forCellWithReuseIdentifier:KCellIdentifier];
    self.quotesCollections.backgroundColor = [UIColor clearColor];
    self.quotesCollections.delegate = self;
    self.quotesCollections.pagingEnabled = YES;
    [self.quotesCollections setContentOffset:CGPointMake(width, 0.0F)];
    self.quotesCollections.dataSource = self;
    [self.view addSubview:self.quotesCollections];
    [self queryParseMethod];
    
}


- (void) randomOrderedMutableArray:(NSMutableArray *) array
{
    int count = (int)[array count];
    for (int i = 0; i < count; ++i)
    {
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

-(NSString *)getNotif
{
    __block NSString * notif;
    
    Quote *quote = [[Quote alloc] init];
    
    
    [quote getQuote:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        notif = [NSString stringWithFormat:@"“%@ \n ” ― %@",
                           responseObject[@"body"],
                           responseObject[@"author"]];
        
    }];
    
    return notif;
}
- (void)reachabilityDidChange:(NSNotification *)notification {
    
    
    Reachability* r = [notification object];
    NetworkStatus ns = r.currentReachabilityStatus;
    
    
    if (ns==NotReachable) {
    _notif.text=@"Network Problems";
        _viewNotification.hidden=NO;
        _viewNotification.backgroundColor=[UIColor redColor];
        [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(hideLabel) userInfo:nil repeats:NO];
        
        
    }
    
    
}


-(void)hideLabel{
    _viewNotification.hidden=YES;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showMenu:(id)sender {
    
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
    
}


#pragma mark - UICollectionViewDelegate
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 11;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)cView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // must be dequeueReusableCellWithReuseIdentifier !!!!
    ShowImageCell *cell = (ShowImageCell *)[cView dequeueReusableCellWithReuseIdentifier:KCellIdentifier
                                                                            forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"what ? cell is nil ? It's joke !");
        return nil;
    }
    //NSString *imageName = [NSString stringWithFormat:@"%d.JPG",indexPath.row];
    
   // cell.imageView.image = [UIImage imageNamed:imageName];
    //cell.titleLabel.text = imageName;
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    PFFile * imageFile=[imageObject objectForKey:@"image"];
   // NSString *contentquote=[imageObject objectForKey:@"content"];
    
   
    [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error) {
            //NSLog(@"here is your data %@",data);
            cell.imageView.image = [UIImage imageWithData:data];
            
            

            cell.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];

            //[_authorsCollection reloadData];
            
            
        }
    }];
    
    _q = [[Quotes alloc]initwithid:@"1" withcontent:@"categorie" withcategory:@"categorie" withimage:cell.imageView.image  theauthor:@"test" rated:2.0f withnumberofvote:3];


    return cell;
}



-(void)queryParseMethod{
    
    
    //NSLog(@"start method....");
    
    NetworkStatus ns = self.reachability.currentReachabilityStatus;

    if(ns==NotReachable)
    {
    
    }
    else
    {
    PFQuery *query=[PFQuery queryWithClassName:@"Quotes"];
    //[query fromLocalDatastore];
    [query addDescendingOrder:@"rate"];
    [query selectKeys:@[@"image",@"content"]];
    
    //query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    query.limit = 11;
    
    
    
        NSArray *objects = [query findObjects];
        [PFObject pinAllInBackground:objects];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error)
     {
         if(!error) {
             imagesFilesArray= [[NSArray alloc] initWithArray:objects];
             // imagesFilesArray=objects;
             //NSLog(@"%@",imagesFilesArray);
             [_quotesCollections reloadData];
             _isParsed=true;
             //[PFObject pinAllInBackground:objects];
         }
     }];
    }
    
    /*
     PFQuery *query1=[PFQuery queryWithClassName:@"Quotes"];
     [query1 addDescendingOrder:@"rate"];
     [query1 selectKeys:@[@"content"]];
     query.limit = 11;
     
     NSLog(@"This is the query result = %@", query);
     
     [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
     if (!error) {
     // The find succeeded.
     NSLog(@"Successfully retrieved %d rows.", objects.count);
     
     //Do something with the found objects
     
     for (PFObject *object in objects) {
     NSLog(@"%@", object.objectId);
     NSLog(@"Unique object is %@",[objects objectAtIndex:position]);
     position=position+1;
     }
     
     //Testing
     //int position = (arc4random_uniform(objects.count));
     
     
     } else {
     // Log details of the failure
     NSLog(@"Error: %@ %@", error, [error userInfo]);
     }
     }];
     
     */
  
}


-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //QuoteDetailViewController *vc = [[QuoteDetailViewController alloc]init];
    
    QuoteDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"quoteDetail"];
//ShowImageCell *cell = (ShowImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier
  //                                                                                   //forIndexPath:indexPath];
    
   // Quotes *q;
    
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    
    
    
    NSString *contentquote=[imageObject objectForKey:@"content"];
    PFFile * imageFile=[imageObject objectForKey:@"image"];
    
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error) {
            //NSLog(@"data from image file: %@",data);
            
            vc.imgQuote= [UIImage imageWithData:data];
            _datatotestwith=data;
        }
    }];
    
  //  UIImage *im=[UIImage imageWithData:_datatotestwith];
    
    
    // _quoteImage.image= [UIImage imageWithData:_imgData];
 

    
    //NSString *content;
    //content=contentquote;
    
 //   NSLog(@"content : %@",contentquote);
    vc.titreString=contentquote;
//    NSLog(@"COntent destination %@",vc.titreString);
    
    
   // NSData *imData = UIImagePNGRepresentation(cell.imageView.image);
//    NSLog(@"data : %@",imData);
    
  //  NSData *imData2 = UIImageJPEGRepresentation(cell.imageView.image, 0.9f);
//    NSLog(@"data JPG : %@",imData2);
    
    
    //vc.imgData=imData;
    
    [self.navigationController pushViewController:vc animated:YES];
    //[self presentViewController:vc animated:YES completion:NULL];
    
    
    //self.navigationController.viewControllers = @[vc];
  
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
   
    float targetX = _scrollView.contentOffset.x;
    int numCount = [self.quotesCollections numberOfItemsInSection:0];
    float ITEM_WIDTH = _scrollView.frame.size.width;
    
    if (numCount>=3)
    {
        if (targetX < ITEM_WIDTH/2) {
            [_scrollView setContentOffset:CGPointMake(targetX+ITEM_WIDTH *numCount, 0)];
        }
        else if (targetX >ITEM_WIDTH/2+ITEM_WIDTH *numCount)
        {
            [_scrollView setContentOffset:CGPointMake(targetX-ITEM_WIDTH *numCount, 0)];
        }
    }
    
}

@end
