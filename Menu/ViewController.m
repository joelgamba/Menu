//
//  ViewController.m
//  Menu
//
//  Created by TestAccount on 2/25/14.
//  Copyright (c) 2014 TestAccount. All rights reserved.
//

#import "ViewController.h"
#import "MenuViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic) NSDictionary *users;
@end

@implementation ViewController

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if(!self.users) {
        self.users = @{@"user": @"pass", @"superuser": @"superpass"};
    }
    NSString *user = [self.userName text];
    NSString *pass = [self.password text];
    
    if(self.users[user]) {
        NSLog(@"ALLOWED");
        if([pass isEqualToString:self.users[user]]) {
            NSLog(@"LOGIN SUCCESS");
            [self performSegueWithIdentifier:@"login" sender:self];
            return YES;
        }
    }
    [self alertStatus :@"LOGIN FAILED" :1];
    return NO;
}

- (void) alertStatus: (NSString *)title : (int)tag {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
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

@end
