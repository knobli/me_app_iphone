//
//  RTGVEditOverviewViewController.m
//  Me App
//
//  Created by XCode Developer on 7/23/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVEditOverviewViewController.h"
#import "RTGVEditViewController.h"
#import "RTGVMyData.h"

@interface RTGVEditOverviewViewController ()

@end

@implementation RTGVEditOverviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   // NSString *nameButton = [NSString stringWithFormat:@"%@%@",@"Name: ",self.myData.name];
   // [self.name setTitle:nameButton forState:UIControlStateNormal];
    [self.name setTag:0];
    
   // NSString *addressButton = [NSString stringWithFormat:@"%@%@",@"Address: ",self.myData.address];
   // [self.address setTitle:addressButton forState:UIControlStateNormal];
    [self.address setTag:1];
    
   // NSString *cityButton = [NSString stringWithFormat:@"%@%@",@"City: ",self.myData.city];
   // [self.city setTitle:cityButton forState:UIControlStateNormal];
    [self.city setTag:2];
    
   // NSString *stateButton = [NSString stringWithFormat:@"%@%@",@"State: ",self.myData.state];
   // [self.state setTitle:stateButton forState:UIControlStateNormal];
    [self.state setTag:3];
    
   // NSString *zipButton = [NSString stringWithFormat:@"%@%@",@"Zip: ",self.myData.zip];
   // [self.zip setTitle:zipButton forState:UIControlStateNormal];
    [self.zip setTag:4];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   // if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
     //   self.myData = se
  //  }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RTGVEditViewController* target = (RTGVEditViewController *)segue.destinationViewController;
    target.myData = self.myData;
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:
            target.type = 0;
            target.placeholder = @"Set new Name";
            break;
        case 1:
            target.type = 1;
            target.placeholder = @"Set new Address";
            break;
        case 2:
            target.type = 2;
            target.placeholder = @"Set new City";
            break;
        case 3:
            target.type = 3;
            target.placeholder = @"Set new State";
            break;
        case 4:
            target.type = 4;
            target.placeholder = @"Set new Zip";
            break;
    }
}

@end
