//
//  RTGVTableViewController.h
//  Me App
//
//  Created by XCode Developer on 7/24/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTGVMyData.h"

@interface RTGVTableViewController : UITableViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) RTGVMyData* myData;

@end
