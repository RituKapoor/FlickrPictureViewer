//
//  FPFlickretchManager.m
//  FlickrPictureViewer
//
//  Created by admin on 17/05/14.
//  Copyright (c) 2014 PS. All rights reserved.
//

#import "FPFlickrFetchManager.h"
#import "FPPhoto.h"

@implementation FPFlickrFetchManager

+(instancetype) sharedInstance{
    static FPFlickrFetchManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;

    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FPFlickrFetchManager alloc] init];
    });
    return _sharedInstance;
}

-(id) init{
    self = [super init];
    if (self) {
        //fire the api call
        [self configManager];
    }
    return self;
}

-(void) configManager{
    NSDictionary * configDIC=[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Enviornment" ofType:@"plist"]];
    NSString *resourceURLStr = [configDIC valueForKey:@"DevURL"];
    [self setFetchRequestURL:[NSURL URLWithString:resourceURLStr]];
}

-(void) fetchFlickrPhotos{
    __block NSError *error = nil;
    __block NSArray *flickPhotos;
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:self.fetchRequestURL] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            error = connectionError;
            [self.delegate didFinishFetchingDataWithArray:nil error:&connectionError];
        
        }else{
            __block NSError *localError = nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
            if (localError != nil) {
                [self.delegate didFinishFetchingDataWithArray:nil error:&localError];
            }else{
                flickPhotos = [[parsedObject valueForKey:@"photos"] valueForKey:@"photo"];;
                NSLog(@"dictionary is %@", parsedObject);
                NSArray *photos = [[parsedObject valueForKey:@"photos"] valueForKey:@"photo"];;
                NSLog(@"dictionary is %@", parsedObject);
                NSMutableArray *flickerPhotos = [[NSMutableArray alloc] init];
                for (NSDictionary *flickerPhotoDict in photos) {
                    FPPhoto *aPhoto = [[FPPhoto alloc] init];
                    [aPhoto setIdentifier:[flickerPhotoDict valueForKey:@"id"]];
                    [aPhoto setTitle:[flickerPhotoDict valueForKey:@"title"]];
                    [aPhoto setUrlStr:[NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@_b.jpg", [flickerPhotoDict valueForKey:@"farm"], [flickerPhotoDict valueForKey:@"server"], [flickerPhotoDict valueForKey:@"id"], [flickerPhotoDict valueForKey:@"secret"]]];
                    [flickerPhotos addObject:aPhoto];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.delegate didFinishFetchingDataWithArray:flickerPhotos error:&localError];
                });
            }
        }
    }];
    //return flickPhotos;
}

@end
