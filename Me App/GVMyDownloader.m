//
//  GVMyDownloader.m
//  TableViewDemo2
//
//  Created by Jonathan Engelsma on 5/30/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVMyDownloader.h"
#import "RTGVAppDelegate.h"

@interface GVMyDownloader()
@property (nonatomic,strong,readwrite) NSURLConnection* connection;
@property (nonatomic,copy, readwrite) NSURLRequest* request;
@property (nonatomic, strong, readwrite) NSMutableData* mutableReceivedData;
@end

@implementation GVMyDownloader

- (NSData*) receivedData
{
    return [self.mutableReceivedData copy];
}

- (id) initWithRequest:(NSURLRequest *)req
{
    self = [super init];
    if(self)
    {
        self->_request = [req copy];
        self->_connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:NO];
        self->_mutableReceivedData = [NSMutableData new];
        [(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] incrementNetworkActivity];
    }
    return self;
}

-(void) connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.mutableReceivedData setLength:0];
}

-(void) connection:(NSURLConnection *)connection  didReceiveData:(NSData *)data
{
    [self.mutableReceivedData appendData:data];
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    [(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] decrementNetworkActivity];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionFinished" object:self userInfo:@{@"error" : error}];
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection
{
    [(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] decrementNetworkActivity];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"connectionFinished" object:self];
}

-(void) cancel {
    [self.connection cancel];
    [(RTGVAppDelegate*)[[UIApplication sharedApplication] delegate] decrementNetworkActivity];
    self->_connection = [[NSURLConnection alloc] initWithRequest:self->_request delegate:self startImmediately:NO];
}

@end
