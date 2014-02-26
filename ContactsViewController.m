//
//  ContactsViewController.m
//  Contacts
//
//  Created by Hackintosh on 2/25/14.
//  Copyright (c) 2014 SRPH. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"

@interface ContactsViewController ()

@end

@implementation ContactsViewController
@synthesize contacts = _contacts;

- (void)setContacts:(NSMutableArray *)contacts {
    _contacts = contacts;
}

- (NSMutableArray *)contacts {
    if(!_contacts) {
        _contacts = [[NSMutableArray alloc] init];
        [self addContact:@"John Patrick Enriquez" : @"+639166680021"];
        [self addContact:@"Mister Gamba" : @"+639168956740"];
        [self addContact:@"McKinley Gil" : @"+639167015625"];
    }
    return _contacts;
}

- (void) addContact: (NSString *)name : (NSString *)number {
    Contact *contact = [[Contact alloc] init];
    contact.name = name;
    contact.number = number;
    [_contacts addObject:contact];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (IBAction)onClickClose:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return[self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactCell"];
    
    Contact *contact = (self.contacts)[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.number;
    NSLog(@"%@ %@", contact.name, contact.number);
    return cell;
}

#pragma mark = ContactsDetailViewControllerDelegate

- (void) contactDetailsViewControllerDidCancel:(ContactsDetailViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddContact"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ContactsDetailViewController *contactDetailViewController = [navigationController viewControllers][0];
        contactDetailViewController.delegate = self;
    }
}

- (void)contactDetailsViewController:(ContactsDetailViewController *)controller didAddPlayer:(id)contact{
    [self.contacts addObject:contact];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.contacts count] -1) inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
