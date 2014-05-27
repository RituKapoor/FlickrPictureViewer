//
//  FPViewController.h
//  FlickrPictureViewer
//
//  Created by admin on 17/05/14.
//  Copyright (c) 2014 PS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPFlickrFetchManager.h"
#import "FPPhoto.h"

@interface FPViewController : UIViewController<FPFlickrFetchManagerDelegate>
@property (nonatomic, strong) FPFlickrFetchManager *flickrFetchManager;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSOperationQueue *flickrQueue;

@property (nonatomic, weak) IBOutlet UITableView *photoTableVEW;
@property (nonatomic, strong) NSArray *allFlickrPhotosArr;

-(IBAction)fetch:(id)sender;
@end
