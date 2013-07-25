//
//  RTGVMyData.m
//  Me App
//
//  Created by XCode Developer on 7/22/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVMyData.h"

NSString *const Name = @"Name";
NSString *const Address = @"Address";
NSString *const City = @"City";
NSString *const State = @"State";
NSString *const Zip = @"Zip";

@implementation RTGVMyData

- (NSString*) getField:(NSString *)key
{
    return [self.data objectForKey:key];
}

- (void) setField:(NSString *)val withKey:(NSString *)key
{
    [self.data setObject:val forKey:key];
}

@end
