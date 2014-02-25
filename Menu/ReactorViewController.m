//
//  ReactorViewController.m
//  Menu
//
//  Created by test on 2/25/14.
//  Copyright (c) 2014 Testccount. All rights reserved.
//

#import "ReactorViewController.h"

@interface ReactorViewController ()
@property (weak, nonatomic) IBOutlet UIButton *player1;
@property (weak, nonatomic) IBOutlet UIButton *player2;
@property (weak, nonatomic) IBOutlet UIButton *player3;
@property (weak, nonatomic) IBOutlet UIButton *player4;
@property (weak, atomic) IBOutlet UILabel *player1Score;
@property (weak, atomic) IBOutlet UILabel *player2Score;
@property (weak, atomic) IBOutlet UILabel *player3Score;
@property (weak, atomic) IBOutlet UILabel *player4Score;
@property (weak, nonatomic) IBOutlet UILabel *colorText;
@property (weak, nonatomic) IBOutlet UILabel *timer1;
@property (weak, nonatomic) IBOutlet UILabel *timer2;
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *titleText2;
@property (weak, nonatomic) IBOutlet UILabel *colorText2;

@property int score1;
@property int score2;
@property int score3;
@property int score4;
@property int indexColor;
@property int indexText;

@property NSTimer *timer;
@property int timerCount;
@end

@implementation ReactorViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self changeLabel];
    
    self.titleText2.transform = CGAffineTransformMakeRotation(M_PI);
    self.colorText2.transform = CGAffineTransformMakeRotation(M_PI);
    self.timer2.transform = CGAffineTransformMakeRotation(M_PI);
    self.player1.transform = CGAffineTransformMakeRotation(M_PI);
    self.player3.transform = CGAffineTransformMakeRotation(M_PI);
    self.player1Score.transform = CGAffineTransformMakeRotation(M_PI);
    self.player3Score.transform = CGAffineTransformMakeRotation(M_PI);
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reactor_bg.png"]];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayWinner {
    NSArray *scores = @[self.player1Score,self.player2Score, self.player3Score, self.player4Score];
    
}

- (IBAction)onPlayerOneClick:(id)sender {
    NSLog(@"Player 1 click");
    if([self isCorrect]){
        self.score1++;
        if (self.score1 == 5) {
            [self declareWinner:1];
        }
    }else{
        self.score1--;
    }
    [self.player1Score setText:[NSString stringWithFormat: @"%d", self.score1]];
}

- (IBAction)onPlayerTwoClick:(id)sender {
    NSLog(@"Player 2 click");
    if([self isCorrect]){
        self.score2++;
        if (self.score2 == 5) {
            [self declareWinner:2];
        }
    }else{
        self.score2--;
    }
    [self.player2Score setText:[NSString stringWithFormat: @"%d", self.score2]];
    
}

- (IBAction)onPlayerThreeClick:(id)sender {
    NSLog(@"Player 3 click");
    if([self isCorrect]){
        self.score3++;
        if (self.score3 == 5) {
            [self declareWinner:3];
        }
    }else{
        self.score3--;
    }
    [self.player3Score setText:[NSString stringWithFormat: @"%d", self.score3]];
    
}

- (IBAction)onPlayerFourClick:(id)sender {
    NSLog(@"Player 4 click");
    [self changeLabel];
    if([self isCorrect]){
        self.score4++;
        if (self.score4 == 5) {
            [self declareWinner:4];
        }
        
    }else{
        self.score4--;
    }
    
    [self.player4Score setText:[NSString stringWithFormat: @"%d", self.score4]];
}


-(void)declareWinner:(int) winner{
    [self.timer invalidate];
    [self.timer1 setText:@" "];
    [self.timer2 setText:@" "];
    [self.player1 setHidden:YES];
    [self.player2 setHidden:YES];
    [self.player3 setHidden:YES];
    [self.player4 setHidden:YES];
    [self.player1Score setHidden:YES];
    [self.player2Score setHidden:YES];
    [self.player3Score setHidden:YES];
    [self.player4Score setHidden:YES];
    [self.timer1 setHidden:YES];
    [self.timer1 setHidden:YES];
    [self.colorText setHidden:YES];
    [self.colorText2 setHidden:YES];
    
    [self.titleText setText:[NSString stringWithFormat:@"The winner is player %d", winner]];
    [self.titleText2 setText:[NSString stringWithFormat:@"The winner is player %d", winner]];
}

- (void)changeLabel{
    self.indexColor = arc4random()%3;
    self.indexText = arc4random() %3;
    
    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor greenColor], nil ];
    NSArray *textArray = [[NSArray alloc] initWithObjects:@"Red",@"Blue",@"Green", nil];
    
    [self.colorText setText:textArray[self.indexText]];
    [self.colorText setTextColor:colorArray[self.indexColor]];
    [self.colorText2 setText:textArray[self.indexText]];
    [self.colorText2 setTextColor:colorArray[self.indexColor]];
}

-(BOOL)isCorrect{
    BOOL toReturn;
    
    
    if (self.indexColor == self.indexText) {
        toReturn=YES;
    }else{
        toReturn=NO;
    }
    [self changeLabel];
    
    self.timerCount = 4;
    
    return toReturn;
}

-(void) updateCounter:(NSTimer *)theTimer{
    if (self.timerCount == 0) {
        [self changeLabel];
        self.timerCount = 3;
    }else{
        self.timerCount--;
    }
    [self.timer1 setText:[NSString stringWithFormat:@"%d", self.timerCount]];
    [self.timer2 setText:[NSString stringWithFormat:@"%d", self.timerCount]];
}

@end
