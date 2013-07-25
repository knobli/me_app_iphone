//
//  RTGVEditOverviewViewController.h
//  Me App
//
//  Created by XCode Developer on 7/23/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTGVMyData.h"

@interface RTGVEditOverviewViewController : UIViewController
@property (nonatomic,strong) RTGVMyData* myData;
@property (weak, nonatomic) IBOutlet UIButton *name;
@property (weak, nonatomic) IBOutlet UIButton *address;
@property (weak, nonatomic) IBOutlet UIButton *city;
@property (weak, nonatomic) IBOutlet UIButton *state;
@property (weak, nonatomic) IBOutlet UIButton *zip;
@end
