//
//  ContactsDetailViewController.h
//  Contacts
//
//  Created by Hackintosh on 2/26/14.
//  Copyright (c) 2014 SRPH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@class ContactsDetailViewController;
@protocol ContactDetailViewControllerDelegate <NSObject>
- (void)contactDetailsViewControllerDidCancel:(ContactsDetailViewController *)controller;
- (void)contactDetailsViewController:(ContactsDetailViewController *)controller didAddPlayer:(Contact *)contact;
@end

@interface ContactsDetailViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;

@property (nonatomic, weak) id <ContactDetailViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
