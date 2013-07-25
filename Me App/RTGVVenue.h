//
//  RTGVVenue.h
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTGVVenue : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *venueUrl;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *city;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *zip;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *categoryImageUrl;
@end
