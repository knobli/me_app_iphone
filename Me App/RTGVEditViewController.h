//
//  RTGVEditViewController.h
//  Me App
//
//  Created by XCode Developer on 7/23/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTGVMyData.h"


@interface RTGVEditViewController : UIViewController
@property (nonatomic,strong) RTGVMyData* myData;
@property (assign) NSInteger type;
@property (nonatomic,strong) NSString* placeholder;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end
