//
//  FPPhotos.m
//  FlickrPictureViewer
//
//  Created by admin on 17/05/14.
//  Copyright (c) 2014 PS. All rights reserved.
//

#import "FPPhoto.h"

@implementation FPPhoto
@synthesize title, identifier;

-(id) init{
    self= [super init];
    if (self) {
        self.title = @"";
        self.identifier = @"";
        self.urlStr = @"";
    }
    
    return self;
}
@end
