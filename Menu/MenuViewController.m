//
//  MenuViewController.m
//  Menu
//
//  Created by TestAccount on 2/25/14.
//  Copyright (c) 2014 TestAccount. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
- (IBAction)exitButton:(id)sender;


@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DefaultContainer.png"]];
//    [self.view addSubview:backgroundImage];
//    [self.view sendSubviewToBack:backgroundImage];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ConDefault.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)exitButton:(id)sender {
    exit(0);
}
@end
