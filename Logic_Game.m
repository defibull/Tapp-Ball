//
//  Tap Ball
//
//  Created by Shashank Khanna  on 7/9/15.
//

#import "Game.h"
#import <AudioToolbox/AudioToolbox.h>
@interface Game ()

@end

@implementation Game
- (IBAction)showShare:(id)sender {
    NSString *shareText = @"Just played Tap Ball, try it! https://www.facebook.com/TapBall.v1/timeline  "; 
    NSArray *itemsToShare = @[shareText]; 
    UIActivityViewController *shareVC = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
    shareVC.excludedActivityTypes = @[]; 
    [self presentViewController:shareVC animated:YES completion:nil]; 
}

-(IBAction)StartGame:(id)sender
{
    StartGame.hidden = YES; 
    BallMovement = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(BallMovement) userInfo:nil repeats:YES];
    
    
    BlockMovement = [NSTimer scheduledTimerWithTimeInterval:0.015 target:self selector:@selector(BlockMovement) userInfo:nil repeats:YES]; 
    Level.hidden = YES; 
    [self PlaceBlock4and5];
    [self PlaceOtherBlocks];
    LevelNumber = 1; 
    NSLog(@"Game started");
}

-(void)PlaceBlock4and5
{
    // The numbers are the relative positions of the objects 
    // since this is a small app no const ints have been uysed 
    //Block4.translatesAutoresizingMaskIntoConstraints = YES;
    //Block5.translatesAutoresizingMaskIntoConstraints = YES;
    Block4Position = (arc4random()%228)-125; 
    Block5Position = Block4Position+390-LevelNumber*50;
    Block4.center = CGPointMake(Block4Position, -300);
    Block5.center = CGPointMake(Block5Position, -300);
  
    NSLog(@"Blocks 4 and 5 placed");
    
    
}


-(void)PlaceOtherBlocks
{
   // Block1.translatesAutoresizingMaskIntoConstraints = YES;
    //Block2.translatesAutoresizingMaskIntoConstraints = YES;
    //Block3.translatesAutoresizingMaskIntoConstraints = YES;
    Block1Position = arc4random()%30;
    Block2Position = Block1Position+400-LevelNumber*100; 
    Block3Position = Block2Position+135;
    Block1.center = CGPointMake(Block1Position, -60);
    Block2.center = CGPointMake(Block2Position, -80);
    Block3.center = CGPointMake(Block3Position, -65);
    NSLog(@"Other blocks placed");
}

-(void)BlockMovement
{
    Block1.center = CGPointMake(Block1.center.x, Block1.center.y +LevelNumber+2);
    Block2.center = CGPointMake(Block2.center.x, Block2.center.y +LevelNumber+2);
    Block3.center = CGPointMake(Block3.center.x, Block3.center.y +LevelNumber+2);
    Block4.center = CGPointMake(Block4.center.x, Block4.center.y +LevelNumber+2);
    Block5.center = CGPointMake(Block5.center.x, Block5.center.y +LevelNumber+2);
   
    if (Block2.center.y > 600)
        {
        [self PlaceOtherBlocks];
        }
    
    if (Block5.center.y > 550)
        {
        [self PlaceBlock4and5];
        }
    
    if (Block1.center.y == 420 || Block4.center.y ==420)
        {
        ScoreNumber++; 
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"hitting sound" ofType:@"wav"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
        AudioServicesPlaySystemSound (soundID);

        Score.text = [NSString stringWithFormat:@"Score: %i", ScoreNumber];
        }
   if (CGRectIntersectsRect(Ball.frame, Block4.frame)
        || CGRectIntersectsRect(Ball.frame, Block2.frame)
        || CGRectIntersectsRect(Ball.frame, Block1.frame)
        || CGRectIntersectsRect(Ball.frame, Block5.frame)
        || CGRectIntersectsRect(Ball.frame, Block3.frame)
        || CGRectIntersectsRect(Ball.frame, LeftColumn.frame)
        || CGRectIntersectsRect(Ball.frame, RightColumn.frame))
        {
        NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"explosion1" ofType:@"wav"];
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath: soundPath], &soundID);
        AudioServicesPlaySystemSound (soundID);
        [self GameOver];
        }
    // Adjusting the Levels
    if (ScoreNumber == 10)
        {LevelNumber  = 2; [self LoadNewLevel];}
    else if (ScoreNumber == 20)
        {LevelNumber  = 3; [self LoadNewLevel];}
     else if (ScoreNumber == 30)
        {LevelNumber  = 4; [self LoadNewLevel];}
    else if (ScoreNumber == 40)
        {LevelNumber  = 5; [self LoadNewLevel];}
    
        
    

}


-(void)LoadNewLevel
{
    Level.text  = [NSString stringWithFormat:@"Level %i", LevelNumber];
    Level.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Ball Background.png"]];
    Level.hidden = NO; 
    [self performSelector:@selector(hideLabel) withObject:nil afterDelay:1.0];

    
    // Put in an NS timer and then  set hidden to YES
    
}

-(void)hideLabel{
    Level.hidden = YES; 
}

-(void) GameOver
{
    
   
    if (ScoreNumber > HighScoreNumber)
        {
        [[NSUserDefaults standardUserDefaults] setInteger:ScoreNumber forKey:@"HighScoreSaved"];
        }
    [BallMovement invalidate]; // stop the timers
    [BlockMovement invalidate]; 
    Exit.hidden = NO; 
    Share.hidden = NO; 
    NSLog(@"game over running");
   
}



-(void)BallMovement
{
    Ball.center = CGPointMake(Ball.center.x+BALL_MOTION, Ball.center.y);
    
    BALL_MOTION = BALL_MOTION - 3; 
    if (BALL_MOTION < -15)
        {
        BALL_MOTION = -15; 
        }
    
    
}

// The reason why we dont want to make ball a button is because we move the ball no matter where we
// tap on the screen - we use touches began 


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    BALL_MOTION = 10; 
    NSLog(@"SK touched Ball");
        
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    NSLog(@"initWithNibName: running");
    return self;
}

- (void)viewDidLoad
{
    
    Exit.hidden = YES; 
    Level.hidden = YES; 
    Share.hidden = YES; 
    ScoreNumber = 0; 
    HighScoreNumber = [[NSUserDefaults standardUserDefaults]integerForKey:@"HighScoreSaved"];
    [super viewDidLoad];
    // error messages 
    NSLog(@"view did Load running");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
