//
//  FPFlickretchManager.h
//  FlickrPictureViewer
//
//  Created by admin on 17/05/14.
//  Copyright (c) 2014 PS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FPFlickrFetchManagerDelegate <NSObject>

-(void) didFinishFetchingDataWithArray:(NSArray*)fetchedFlickrPhotos error:(NSError**) error;

@end
@interface FPFlickrFetchManager : NSObject

+(FPFlickrFetchManager*) sharedInstance;
//-(NSArray*) fetchFlickrPhotos;

@property (nonatomic, strong) NSURL *fetchRequestURL;
@property (nonatomic, weak) id<FPFlickrFetchManagerDelegate> delegate;
-(void) fetchFlickrPhotos;
@end
