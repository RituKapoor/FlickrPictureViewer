//
//  FPViewController.m
//  FlickrPictureViewer
//
//  Created by admin on 17/05/14.
//  Copyright (c) 2014 PS. All rights reserved.
//

#import "FPViewController.h"
#import "FPFlickerPhotoTableViewCell.h"

@interface FPViewController ()

@end

@implementation FPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.flickrFetchManager = [FPFlickrFetchManager sharedInstance];
    //self.flickrFetchManager = [[FPFlickrFetchManager alloc] init];
    self.flickrQueue = [[NSOperationQueue alloc] init];
    [self.flickrFetchManager setDelegate:self];
    NSLog(@"called after");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)fetch:(id)sender{
    //
    [self.activityIndicator startAnimating];
    [self.flickrFetchManager fetchFlickrPhotos];
}

#pragma mark - fetch manager delegate
-(void) didFinishFetchingDataWithArray:(NSArray *)fetchedFlickrPhotos error:(NSError *__autoreleasing *)error{
    [self renderFetchedPhotosWithPhotoArray:fetchedFlickrPhotos error:error];
}

-(void) renderFetchedPhotosWithPhotoArray:(NSArray*) photos error:(NSError**) error{
    
    [self.activityIndicator stopAnimating];
    self.allFlickrPhotosArr = [NSArray arrayWithArray:photos];
    [self.photoTableVEW reloadData];
}

#pragma mark - tableview datasource /delegate
//Ritu test commit
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count is  %d", self.allFlickrPhotosArr.count);
    return [self.allFlickrPhotosArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"FPFlickerPhotoTableViewCell";
    
    __block FPFlickerPhotoTableViewCell *cell = (FPFlickerPhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FPFlickerPhotoTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.activityIND startAnimating];
    FPPhoto *aPhoto = [self.allFlickrPhotosArr objectAtIndex:indexPath.row];
    NSOperationQueue *queue;
    if ( queue == nil )
    
        queue = [[NSOperationQueue alloc] init];
    
    }
    
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[aPhoto urlStr]]] queue:queue completionHandler:^(NSURLResponse * resp, NSData     *data, NSError *error)
     {
         
         dispatch_async(dispatch_get_main_queue(),^
                        {
                            if ( error == nil && data )
                            {
                                UIImage *urlImage = [[UIImage alloc] initWithData:data];
                                cell.image.image = urlImage;
                                [cell.activityIND stopAnimating];
                            }
                        });
     }];
    
    cell.title.text = [aPhoto title];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92;
}


@end
