//
//  ContactsDetailViewController.m
//  Contacts
//
//  Created by Hackintosh on 2/26/14.
//  Copyright (c) 2014 SRPH. All rights reserved.
//

#import "ContactsDetailViewController.h"
#import "Contact.h"

@interface ContactsDetailViewController ()

@end

@implementation ContactsDetailViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)cancel:(id)sender {
    [self.delegate contactDetailsViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender {
    Contact *contact = [[Contact alloc] init];
    contact.name = self.nameTextField.text;
    contact.number = self.numberTextField.text;
    [self.delegate contactDetailsViewController:self didAddPlayer:contact];
}

@end
