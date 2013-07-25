//
//  RTGVViewController.m
//  Me App
//
//  Created by XCode Developer on 7/22/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVMyData.h"
#import "RTGVViewController.h"
#import "RTGVTableViewController.h"
#import <Parse/Parse.h>

@interface RTGVViewController ()

@property (nonatomic,strong) RTGVMyData* myData;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *zip;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@end

@implementation RTGVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myData = [[RTGVMyData alloc] init];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(print_Message)];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //self.name.text = self.myData.name;
    self.name.text = [self.myData getField:Name];
    //self.address.text = self.myData.address;
    self.address.text = [self.myData getField:Address];
    //self.city.text = self.myData.city;
    self.city.text = [self.myData getField:City];
    //self.state.text = self.myData.state;
    self.state.text = [self.myData getField:State];
    //self.zip.text = self.myData.zip;
    self.zip.text = [self.myData getField:Zip];
    self.photo.image = self.myData.photo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RTGVTableViewController* target = (RTGVTableViewController *)segue.destinationViewController;
    target.myData = self.myData;
}

@end
