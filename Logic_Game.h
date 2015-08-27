//
//  Game.h
//  Tap Ball
//
//  Created by Shashank Khanna  on 7/9/15.
//  Copyright (c) 2015 Khannapps. All rights reserved.
//

#import <UIKit/UIKit.h>

int BALL_MOTION;
int Block1Position;
int Block2Position;
int Block3Position;
int Block4Position;
int Block5Position;
int ScoreNumber;
int LevelNumber; 
NSInteger HighScoreNumber; 
@interface Game : UIViewController
{
    IBOutlet UIImageView *Ball; 
    IBOutlet UIButton *StartGame;
    NSTimer *BallMovement; 
    NSTimer *BlockMovement;
    IBOutlet UIImageView *LeftColumn; 
    IBOutlet UIImageView *RightColumn;
    IBOutlet UIImageView *Block1; 
    IBOutlet UIImageView *Block2;
    IBOutlet UIImageView *Block3;
    IBOutlet UIImageView *Block4;
    IBOutlet UIImageView *Block5;
    // theLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blah"]];
    IBOutlet UIButton *Exit; 
    IBOutlet UILabel *Score; 
    IBOutlet UILabel *Level;
    NSTimer *LevelLabelDisplay; 
    IBOutlet UIButton *Share;
    
}
- (IBAction)showShare:(id)sender;

-(IBAction)StartGame:(id)sender;
-(void)BallMovement;
-(void)BlockMovement; 
-(void)PlaceBlock4and5;
-(void)PlaceOtherBlocks;
-(void)GameOver; 
-(void)LoadNewLevel;
-(void)hideLabel;
@end
