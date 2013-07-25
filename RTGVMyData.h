//
//  RTGVMyData.h
//  Me App
//
//  Created by XCode Developer on 7/22/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const Name;
FOUNDATION_EXPORT NSString *const Address;
FOUNDATION_EXPORT NSString *const City;
FOUNDATION_EXPORT NSString *const State;
FOUNDATION_EXPORT NSString *const Zip;

@interface RTGVMyData : NSObject

@property (strong,nonatomic) NSMutableDictionary* data;
//@property (nonatomic,strong) NSString *name;
//@property (nonatomic,strong) NSString *address;
//@property (nonatomic,strong) NSString *city;
//@property (nonatomic,strong) NSString *state;
//@property (nonatomic,strong) NSString *zip;
@property (nonatomic,strong) UIImage *photo;

- (NSString*) getField:(NSString*) key;
- (void) setField:(NSString*)val withKey:(NSString*)key;

@end
