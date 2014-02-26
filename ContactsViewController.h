//
//  ContactsViewController.h
//  Contacts
//
//  Created by Hackintosh on 2/25/14.
//  Copyright (c) 2014 SRPH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsDetailViewController.h"

@interface ContactsViewController : UITableViewController<ContactDetailViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end
