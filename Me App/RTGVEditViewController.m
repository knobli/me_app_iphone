//
//  RTGVEditViewController.m
//  Me App
//
//  Created by XCode Developer on 7/23/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVEditViewController.h"

@interface RTGVEditViewController ()

@end

@implementation RTGVEditViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{	
    [super viewWillAppear:animated];
    //int typeInt = *(self.type);
    switch ((int)self.type) {
        case 0:
           // if (self.myData.name.length  != 0) {
           //     self.textfield.text = self.myData.name;
           // }
            break;
        case 1:
            //if (self.myData.address.length  != 0) {
            //    self.textfield.text = self.myData.address;
            //}
            break;
        case 2:
            //if (self.myData.city.length  != 0) {
            //    self.textfield.text = self.myData.city;
            //}
            break;
        case 3:
           // if (self.myData.state.length  != 0) {
            //    self.textfield.text = self.myData.state;
            //}
            break;
        case 4:
            //if (self.myData.zip.length  != 0) {
            //    self.textfield.text = self.myData.zip;
            //}
            break;
            
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        switch ((int)self.type) {
            case 0:
               // self.myData.name = self.textfield.text;
                break;
            case 1:
               // self.myData.address = self.textfield.text;
                break;
            case 2:
               // self.myData.city = self.textfield.text;
                break;
            case 3:
               /// self.myData.state = self.textfield.text;
                break;
            case 4:
               // self.myData.zip = self.textfield.text;
                break;
                
        }
    }
}

@end
