//
//  AddressAnnotation.m
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate, titletext, subtitletext;  

- (NSString *)subtitle{
    return subtitletext;
}
- (NSString *)title{
    return titletext;
}

-(void)setTitle:(NSString*)strTitle {
    self.titletext = strTitle;
}

-(void)setSubTitle:(NSString*)strSubTitle {
    self.subtitletext = strSubTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
    coordinate=c;
    return self;
}

@end
