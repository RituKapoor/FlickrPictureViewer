//
//  FPFlickerPhotoTableViewCell.h
//  FlickrPictureViewer
//
//  Created by admin on 17/05/14.
//  Copyright (c) 2014 PS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPFlickerPhotoTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UIImageView* image;
@property (nonatomic, weak) IBOutlet UILabel* title;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIND;
@end
