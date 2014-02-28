//
//  ViewController.m
//  HelloWorld
//
//  Created by Hackintosh on 2/23/14.
//  Copyright (c) 2014 Hackintosh. All rights reserved.
//

#import "FlamesViewController.h"

@interface FlamesViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name1;
@property (weak, nonatomic) IBOutlet UITextField *name2;
@property (weak, nonatomic) IBOutlet UILabel *result;
@property (weak, nonatomic) IBOutlet UIImageView *resultImage;
@property (nonatomic) NSArray *flamesArray;
@property (nonatomic) NSArray *flamesImageArray;
@end

@implementation FlamesViewController

- (IBAction)closeApp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onClickFlames:(UIButton *)sender {
    if (!_flamesArray) {
        _flamesArray =  @[@"SOULMATES",@"FRIENDS",@"LOVERS",@"ANGER",@"MARRIED",@"ENEMIES"];
       
    }
    
    [_name1 resignFirstResponder ];
    [_name2 resignFirstResponder ];
    NSString *name1 = _name1.text;
    NSString *name2 = _name2.text;
    int sumOfName1 = [self getSumOfName:name1];
    NSLog(@"sumOfName1: %d", sumOfName1);
    int sumOfName2 = [self getSumOfName:name2];
    NSLog(@"sumOfName2: %d", sumOfName2);
    
    int index = (sumOfName1 + sumOfName2) % 6;
    [_result setText:[_flamesArray objectAtIndex:index]];

    if(index == 0){
        [self.resultImage setImage:[UIImage imageNamed: @"soulmate.png"]];
    }    if(index == 1){
        [self.resultImage setImage:[UIImage imageNamed: @"friends.png"]];
    }    if(index == 2){
        [self.resultImage setImage:[UIImage imageNamed: @"lovers.png"]];
    }    if(index == 3){
        [self.resultImage setImage:[UIImage imageNamed: @"anger.png"]];
    }    if(index == 4){
        [self.resultImage setImage:[UIImage imageNamed: @"marriage.png"]];
    }    if(index == 5){
        [self.resultImage setImage:[UIImage imageNamed: @"enemies.png"]];
    }
    
}

- (int)getSumOfName:(NSString *)name {
    int sumOfName = 0;
    [name uppercaseString];
    for (int i = 0; i < name.length; i++) {
        if ([name characterAtIndex:i] == ' ') {
            continue;
        }
        NSLog(@"Counter: %d", [name characterAtIndex:i]);
        sumOfName += [name characterAtIndex:i] - 64;
    }
    return sumOfName;
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
