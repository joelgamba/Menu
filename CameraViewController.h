//
//  CameraViewController.h
//  Menu
//
//  Created by test on 2/25/14.
//  Copyright (c) 2014 TestAccount. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)selectPhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;

@end
