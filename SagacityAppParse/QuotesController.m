//
//  QuotesController.m
//  SagacityAppParse
//
//  Created by Nessrine Ben Amor on 11/30/15.
//  Copyright © 2015 F&N. All rights reserved.
//

#import "QuotesController.h"
#import "QuoteCell.h"
#import "QueryClass.h"
#import "QuoteDetailViewController.h"
@interface QuotesController ()

@end

@implementation QuotesController


-(void)moodChoice{
    NSInteger id=0;
    NSUserDefaults *mood = [ NSUserDefaults standardUserDefaults];
    id =[[mood objectForKey:@"md"] intValue];
    
    
    
    switch (id) {
        case 100:
        {
        //   _mood = @"angry";
            self.back.image = [UIImage imageNamed:@"07.jpg"];
            
        }
            break;
        case 101:
        {
         //   _mood = @"confused";
            self.back.image = [UIImage imageNamed:@"01.jpg"];
            
            
            
        }
            break;
        case 102:
        {
           // _mood = @"happy";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            
            
            
        }
            break;
        case 103:
        {
           // _mood = @"inlove";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
            
            
            
        }
            break;
        case 104:
        {
         //   _mood = @"wondering";
            self.back.image = [UIImage imageNamed:@"03.jpg"];
            
            
            
        }
            break;
        case 105:
        {
          //  _mood = @"sleepy";
            self.back.image = [UIImage imageNamed:@"02.jpg"];

            
        }
            break;
        case 106:
        {
        //    _mood = @"sad";
            
            self.back.image = [UIImage imageNamed:@"04.jpg"];
            
            
            
        }
            break;
            
        default:
        {  // _mood = @"neutral";
            self.back.image = [UIImage imageNamed:@"02.jpg"];
        }
            
            
            break;
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isParsed = false;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    [_quotesCollections setDataSource:self];
    [_quotesCollections setDelegate:self];
    
    [QueryClass getQuote:^(NSArray *results) {
        imagesFilesArray = results;
        [_quotesCollections reloadData];
    }];
    
    
    [self moodChoice];
    // Do any additional setup after loading the view.
    //[self queryParseMethod];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //[self queryParseMethod];

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

-(void)queryParseMethod{
    
    
    
    PFQuery *query=[PFQuery queryWithClassName:@"Quotes"];
    [query selectKeys:@[@"image",@"content"]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *  objects, NSError *  error)
     {
         if(!error) {
             imagesFilesArray= [[NSArray alloc] initWithArray:objects];
             [_quotesCollections reloadData];
             _isParsed=true;
         }
     }];
    
}

#pragma mark - UICollection DaraSource

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imagesFilesArray count];
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
   // UIProgressView *progressView;
    
    static NSString *cellIdentifier=@"QuoteCell";
    QuoteCell * cell=(QuoteCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    
    PFFile * imageFile=[imageObject objectForKey:@"image"];
    
    cell.loading.hidden=NO;

    [cell.loading startAnimating];
    
    /*
    PFImageView *creature = [[PFImageView alloc] init];
    creature.image = [UIImage imageNamed:@"load.gif"]; // placeholder image
    creature.file = (PFFile *)imageFile;
    [creature loadInBackground];
    
    cell.quoteImage.image=creature.image;
*/
    
    
     [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
     if (!error) {
     cell.quoteImage.image= [UIImage imageWithData:data];
         [cell.loading stopAnimating];
         cell.loading.hidden=YES;
     }
     }];
    
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    QuoteDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"quoteDetail"];
    
    
    //QuoteCell *cell = (QuoteCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"QuoteCell"forIndexPath:indexPath];
    
    
    PFObject *imageObject= [imagesFilesArray objectAtIndex:indexPath.row];
    NSString *contentquote=[imageObject objectForKey:@"content"];
    PFFile * imageFile=[imageObject objectForKey:@"image"];
    
    NSString *idQuote= [imageObject valueForKey:@"objectId"];

    /*
    
     PFImageView *creature = [[PFImageView alloc] init];
     creature.image = [UIImage imageNamed:@"load.gif"]; // placeholder image
     creature.file = (PFFile *)imageFile;
     [creature loadInBackground];
    
      vc.imgQuote= creature.image;
    */
    
    
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error) {
            vc.imgQuote= [UIImage imageWithData:data];
        }
}];
    
    //vc.imgTest= imageFile;
    
    
    
    NSString *content;
    content=contentquote;
    
    vc.titreString=contentquote;
    vc.idObj=idQuote;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
