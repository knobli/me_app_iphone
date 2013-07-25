//
//  RTGVTableViewCell.h
//  Me App
//
//  Created by XCode Developer on 7/25/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTGVTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *categoryImage;
@property (weak, nonatomic) IBOutlet UILabel *venueLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end
