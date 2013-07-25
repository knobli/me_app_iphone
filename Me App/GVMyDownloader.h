//
//  GVMyDownloader.h
//  TableViewDemo2
//
//  Created by Jonathan Engelsma on 5/30/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GVMyDownloader : NSObject
@property (nonatomic, strong, readonly) NSURLConnection* connection;
@property (nonatomic, copy, readonly) NSURLRequest* request;
@property (nonatomic, strong, readonly) NSData* receivedData;
- (id) initWithRequest: (NSURLRequest*) req;
- (void) cancel;
@end
