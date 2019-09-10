//
//  CollectionViewController.m
//  YSLTransitionAnimatorDemo
//
//  Created by yamaguchi on 2015/05/13.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "CollectionDetailViewController.h"
#import <UIColor-HexString/UIColor+HexString.h>

#import "YSLTransitionAnimator.h"
#import "UIViewController+YSLTransition.h"
#import "REFrostedViewController.h"
#import "FTEntry.h"
#import "Reachability.h"

#define FLICKR_URL  @"https://api.flickr.com/services/feeds/photos_public.gne/?tags=inspirational,quotes"


@interface CollectionViewController () <UICollectionViewDelegateFlowLayout, YSLTransitionAnimatorDataSource ,NSXMLParserDelegate, LoadingViewDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) NSString *currentTag;
@property (nonatomic, strong) NSMutableString *currentString;
@property (nonatomic, strong) FTEntry *currentEntry;
@property (nonatomic, strong) FTEntry *selectedEntry;
@property (atomic, assign) BOOL doLoading;
@property (nonatomic,weak) NSString* titreS;
@property (nonatomic, retain) Reachability* reachability;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"CollectionCell";

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self ysl_removeTransitionDelegate];
}

- (void)viewDidAppear:(BOOL)animated
{
    
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    
    [self ysl_addTransitionDelegate:self];
    [self ysl_pushTransitionAnimationWithToViewControllerImagePointY:statusHeight + navigationHeight
                                                   animationDuration:0.3];
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    
    
    self.reachability = [Reachability reachabilityWithHostName:@"www.parse.com"];
    
     [self.reachability startNotifier];
    
    NetworkStatus ns = self.reachability.currentReachabilityStatus;


    
    if (ns == NotReachable)
    {
        
        NSString* msg = @"You can't use this feature check your network";
        UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Network Problems"
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
        [av show];
        
        
    }
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
    
   
    
    // Do any additional setup after loading the view.
    NSURL *aUrl = [NSURL URLWithString:FLICKR_URL];
    
    self.title = @"Random Quotes";
    self.items = [NSMutableArray array];
    self.currentTag = nil;
    self.currentString = [NSMutableString string];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadingStopped)
                                                 name:@"LoadingStopped"
                                               object:nil];
    
    // *** This is a resuse from another project I used in the past
    [LoadingView showLoadingViewinView:self.view withLabel:@"Loading View..." delegate:self];
    
    
    /* *** This is blocking and locking, good only for a quick test
     NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:aUrl];
     [xmlParser setDelegate:self];
     [xmlParser parse];
     */
    
    // *** Decided for this simple exercise to use synchronous request w/ timeout for simplicity's sake.  Asynchronous request would add a few delegate callbacks.
    NSURLRequest *request = [NSURLRequest requestWithURL:aUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (response == nil) {
        // handle error here
        NSLog(@"error: %@", error);
        [self loadingStopped];
    } else {
        
        // Request successful, start parsing the XML doc
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        [xmlParser setDelegate:self];
        [xmlParser parse];
    }
    
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //UIImage *image = [[UIImage imageNamed:@"House.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *image1= [UIImage imageNamed:@"House.png"];
    
    //UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];

    anotherButton.tintColor=[UIColor colorWithHexString:@"#FF2D55"];
    
    self.navigationItem.leftBarButtonItem = anotherButton;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}


- (void)reachabilityDidChange:(NSNotification *)notification {
    
    
    Reachability* r = [notification object];
    NetworkStatus ns = r.currentReachabilityStatus;
    
    
    if (ns==NotReachable) {
        NSLog(@"Not Rechable Reachable");

        
        
    } else {
        NSLog(@"Reachable");
        
    }
    
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    // Begin of entry tag, allocate the FTEntry object
    if ([elementName isEqualToString:@"entry"]) {
        self.currentEntry = [[FTEntry alloc] init];
        self.currentEntry.loaded = NO;
        self.currentEntry.data = nil;
        self.currentEntry.titleString = nil;
        self.currentEntry.urlString = nil;
        
        // Special treatment for the link tag, we extract the URL info from its attributes
    } else if ([elementName isEqualToString:@"link"]) {
        if ([[attributeDict valueForKey:@"rel"] isEqualToString:@"enclosure"] && [[attributeDict valueForKey:@"type"] rangeOfString:@"image"].location != NSNotFound) {
            
            NSString *imgUri = [attributeDict valueForKey:@"href"];
            self.currentEntry.urlString = imgUri;
            
        }
        
        // Special treatment for the title tag, so we can use the tag string later to save title info
    } else if ([elementName isEqualToString:@"title"]) {
        self.currentTag = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // If current tag is marked, we want to preserve the string for later use when the tag ends
    if (self.currentTag != nil) {
        [self.currentString appendString:string];
    }
    
}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // End of entry tag, add to the entry array
    if ([elementName isEqualToString:@"entry"]) {
        [self.items addObject:self.currentEntry];
        
        // End of title tag, collect title string and save it
    } else if ([self.currentTag isEqualToString:@"title"]) {
        NSLog(@"string = %@", self.currentString);
        self.currentEntry.titleString = self.currentString;
        
        // Reset tag for next occurrence
        self.currentTag = nil;
        self.currentString = [NSMutableString string];
        
    }
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"begin %@", [NSDate date]);
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"end Parsing: %@", [NSDate date]);
    
    // Refresh to show skeleton collection
    [self.collectionView reloadData];
    
    // Now we spawn a separate thread to load image for each collection cell.
    self.doLoading = YES;
    [NSThread detachNewThreadSelector:@selector(loadThumbnails) toTarget:self withObject:nil];
    
}

#pragma mark - worker thread

// Thread to load and store the images.
- (void)loadThumbnails {
    for (FTEntry *curEntry in self.items) {
        if (!self.doLoading) {
            NSLog(@"abort loadThumnails");
            break;
        }
        
        /* *** It's a tradeoff whether to load and store the thumbnail version, and load
         the full version as a cell is selected. Classic memory vs. performance.
         */
#ifdef FT_STORE_THUMBNAIL_ONLY
        NSURL *url = [NSURL URLWithString:[self getThumbnailUrl:curEntry.urlString]];
#else
        NSURL *url = [NSURL URLWithString:curEntry.urlString];
#endif
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (response == nil) {
            // handle error here
            NSLog(@"error: %@", error);
            curEntry.data = nil;
            curEntry.loaded = NO;
        } else {
            curEntry.data = data;
            curEntry.loaded = YES;
        }
    }
    self.doLoading = NO;
    
    // Notify main thread before terminating thread
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoadingStopped"
                                                        object:nil
                                                      userInfo:nil];
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CollectionCell *cell = (CollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
     FTEntry *entry = [self.items objectAtIndex:indexPath.row];
    
    if(entry.loaded){
    cell.itemImage.image = [UIImage imageWithData:entry.data];
        cell.itemLabel.text = entry.titleString;
      
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
     CollectionDetailViewController *vc = [[CollectionDetailViewController alloc]init];
    
    CollectionCell *cell = (CollectionCell *)[self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
      _titreS=cell.itemLabel.text;
    
    vc.titreString=_titreS;
    
    NSData *imData = UIImagePNGRepresentation(cell.itemImage.image);
    //NSLog(@"%@",imData);
    vc.imgData=imData;
    
     [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width / 2) - 9, (self.view.frame.size.width / 2) - 9);
}

#pragma mark -- YSLTransitionAnimatorDataSource
- (UIImageView *)pushTransitionImageView
{
    CollectionCell *cell = (CollectionCell *)[self.collectionView cellForItemAtIndexPath:[[self.collectionView indexPathsForSelectedItems] firstObject]];
    return cell.itemImage;
}

- (UIImageView *)popTransitionImageView
{
    return nil;
}


- (IBAction)showMenu:(id)sender {
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}


#pragma mark - LoadingViewDelegate

- (void)cancelLoadingView
{
    self.doLoading = NO;
    [LoadingView removeLoadingView];
}


#pragma mark - Helper Methods

// Get the thumbnail file URL based on the full res file URL (Kludge)
- (NSString *)getThumbnailUrl:(NSString *)imgUrl
{
    return [imgUrl stringByReplacingOccurrencesOfString:@"_b.jpg" withString:@"_m.jpg"];
}

// Notification callback for when worker thread is done
- (void)loadingStopped
{
    [LoadingView removeLoadingView];
    [self.collectionView reloadData];
}

@end
