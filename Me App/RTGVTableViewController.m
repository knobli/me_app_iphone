//
//  RTGVTableViewController.m
//  Me App
//
//  Created by XCode Developer on 7/24/13.
//  Copyright (c) 2013 Toni Raffael. All rights reserved.
//

#import "RTGVTableViewController.h"
#import "RTGVMyData.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface RTGVTableViewController ()
@property (nonatomic,strong) NSArray* labels;
@property (nonatomic,strong) NSArray* parseLabels;
@end

@implementation RTGVTableViewController
BOOL newMedia = NO;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.labels = [NSArray arrayWithObjects:Name,Address,City,State,Zip, nil];
    self.parseLabels = [NSArray arrayWithObjects:@"name",@"address",@"city",@"state",@"zip", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
        
        NSArray *cells = self.tableView.visibleCells;
        for(int i = 0; i < cells.count - 1; i++){
            UITableViewCell *cell = [cells objectAtIndex:i];
            UITextField* textField = (UITextField *)[cell viewWithTag:2];
            NSString* value = textField.text;
            [self.myData setField:value withKey:[self.labels objectAtIndex:i]];
            
        }
    }
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.labels count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ((int)[indexPath row] < self.labels.count) {
        static NSString *CellIdentifier = @"myCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        NSString* labelStr = [self.labels objectAtIndex:[indexPath row]];
        
        UILabel* label = (UILabel *)[cell viewWithTag:1];
        UITextField* field = (UITextField *)[cell viewWithTag:2];
        field.delegate = self;
        label.text = [NSString stringWithFormat:@"%@:", labelStr];
        field.placeholder = [NSString stringWithFormat:@"Enter %@", labelStr];
        field.text = [self.myData getField:[self.labels objectAtIndex:[indexPath row]]];
    } else {
        static NSString *CellIdentifier = @"myImageCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        UIButton* photoButton = (UIButton *)[cell viewWithTag:1];
        [photoButton setBackgroundImage:self.myData.photo forState:UIControlStateNormal];
        
        
    }
    //cell.tag = [indexPath row];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Text field delegate

- (BOOL) textFieldShouldReturn:(UITextField *)tf
{
    [tf resignFirstResponder];
    return YES;
}


- (IBAction)changeImage:(id)sender {
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                      message:NSLocalizedString(@"Select a photo for your profile.", @"Camera dialog title")
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"Cancel",@"Cancel button label")
                                            otherButtonTitles:NSLocalizedString(@"Take Photo", @"Take Photo button label"),
                            NSLocalizedString(@"Choose from Library",@"Choose from library button label"),
                            nil];
    [message show];
    
}


#pragma mark -

#pragma mark UIAlertViewDelegate Methods



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex

{   
    if(buttonIndex == 0){
        NSLog(@"Cancel was pressed.");
    } else if(buttonIndex == 1) {
        NSLog(@"Photo was pressed");
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
            imagePicker.allowsEditing = NO;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
            newMedia = YES;
            
        }
        
    } else if(buttonIndex == 2){
        NSLog(@"Library was pressed");
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
            
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage,nil];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker animated:YES completion:nil];
            newMedia = NO;
            
        }
        
    }
    
}

#pragma mark -

#pragma mark UIImagePickerControllerDelegate methods


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    //[self dismissModalViewControllerAnimated:YES];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *scaledImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        //UIImage *scaledImage = [GFSIgniteDefaultSettingsViewController imageWithImage:image scaledToSize:CGSizeMake(150, 150)];

        //[profileImage setImage:scaledImage forState:UIControlStateNormal];
        
        // upload image to server.
        
        //UserDefaultsSingleton *userDefaults = [UserDefaultsSingleton sharedInstance];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        //[GFSIgniteFetcher uploadUserImage:UIImageJPEGRepresentation(scaledImage, 1.0) withUserId:userDefaults.userId withDelegate:self andSelector:@selector(imageUploaded:finishedWithData:error:)];
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(scaledImage,                                          
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
        self.myData.photo = scaledImage;
        
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        
        // Code here to support video if enabled
        
    }
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
