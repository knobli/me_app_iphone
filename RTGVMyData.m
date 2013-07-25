//
//  RTGVMyData.m
//  Me App
//
//  Created by XCode Developer on 7/22/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVMyData.h"
#import <Parse/Parse.h>

NSString *const Name = @"Name";
NSString *const Address = @"Address";
NSString *const City = @"City";
NSString *const State = @"State";
NSString *const Zip = @"Zip";
NSString *const Photo = @"Photo";

@interface RTGVMyData()
@property (nonatomic,strong) NSMutableDictionary* parseArray;
@property (nonatomic,strong) PFObject* profil;
@end

@implementation RTGVMyData

static RTGVMyData *sharedSingleton;
static BOOL initialized = NO;

-(id)init
{
    
    if(!initialized){
        self.data = [NSMutableDictionary dictionary];
        self.parseArray = [NSMutableDictionary dictionary];
        [self.parseArray setObject:@"name" forKey:Name];
        [self.parseArray setObject:@"address" forKey:Address];
        [self.parseArray setObject:@"city" forKey:City];
        [self.parseArray setObject:@"state" forKey:State];
        [self.parseArray setObject:@"zip" forKey:Zip];
        [self.parseArray setObject:@"photo" forKey:Photo];

        PFQuery *query = [PFQuery queryWithClassName:@"Profil"];
        self.profil = [query getFirstObject];
        [self setField:[self.profil objectForKey:@"name"] withKey:Name];
        //_myData.name = @"Raffael Santschi";
        [self setField:[self.profil objectForKey:@"address"] withKey:Address];
        //_myData.address = @"1, Campus Dr";
        [self setField:[self.profil objectForKey:@"city"] withKey:City];
        //_myData.city = @"Allendale";
        [self setField:[self.profil objectForKey:@"state"] withKey:State];
        //_myData.state = @"Michigan";
        [self setField:[self.profil objectForKey:@"zip"] withKey:Zip];
        //_myData.zip = @"49401";
        self.photo = [UIImage imageNamed:[self.profil objectForKey:@"photo"]];
        initialized = YES;
        sharedSingleton = self;
        return self;
    } else {
        return sharedSingleton;
    }
}

- (NSString*) getField:(NSString *)key
{
    return [self.data objectForKey:key];
}

- (void) setField:(NSString *)val withKey:(NSString *)key
{
    [self.data setObject:val forKey:key];
    if ([key isEqualToString:Photo]) {
        NSLog(@"Could not write photo to prase");
    } else {
        [self.profil setObject:val forKey:[self.parseArray objectForKey:key]];
        [self.profil saveInBackground];
    }
    
}

@end
