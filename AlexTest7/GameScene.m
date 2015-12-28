//
//  GameScene.m
//  AlexTest7
//
//  Created by alex on 8/14/15.
//  Copyright (c) 2015 alex. All rights reserved.
//

#import "GameScene.h"
#import "Globals.h"

@interface GameScene ()
@property (nonatomic) SKSpriteNode *giraffe;


@end

@implementation GameScene





UILabel *speedField;
UILabel *spinField;

-(void)didMoveToView:(SKView *)view {
    self.backgroundColor = [SKColor whiteColor];
    self.view.allowsTransparency=YES;
    self.backgroundColor=[UIColor yellowColor];
    
    speedField =[[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.frame.size.width, 30)];
    speedField.text = [NSString stringWithFormat:@"%s","0"];
    speedField.font=[UIFont fontWithName:@"MarkerFelt-Thin" size:20];
    speedField.textAlignment=NSTextAlignmentCenter;
   // [self.view addSubview:speedField];
    
    
    spinField =[[UILabel alloc] initWithFrame:CGRectMake(0, 105, self.frame.size.width, 100)];
    spinField.text = [NSString stringWithFormat:@"%05d",levelCount];
    spinField.font=[UIFont fontWithName:@"MarkerFelt-Thin" size:35];
    spinField.textAlignment=NSTextAlignmentCenter;
    spinField.textColor=[UIColor redColor];
    spinField.textColor =[UIColor colorWithRed:25.0/255.0 green:86.0/255.0 blue:23.0/255.0 alpha:0.9];
    NSLog(@"Yes it comes");
    [self.view addSubview:spinField];
    
    
    
}





float alexMaxSpeed=100;
float alexSpeed=0;
float alexDecrement=5;

-(id)initWithSize:(CGSize)size {
    NSLog(@"oh Yes it comes");
    
    if (self = [super initWithSize:size]) {
        SKSpriteNode *background=[SKSpriteNode spriteNodeWithImageNamed:@"jungle_bg4"];
        background.position=CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.giraffe = [SKSpriteNode spriteNodeWithImageNamed:@"giraffe"];
        self.giraffe.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addChild:self.giraffe];
        float radius=(self.frame.size.width/2)-(self.giraffe.size.width);
        
        UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,(self.frame.size.height-radius)-self.giraffe.size.width+30) radius:radius startAngle:0 endAngle:(2*M_PI) clockwise:YES];
        
        SKAction *followCircle = [SKAction followPath:circle.CGPath asOffset:NO orientToPath:YES speed:2];
        [self.giraffe  runAction:[SKAction repeatAction:followCircle count:10000] withKey:@"followCircle"];
        
    }
    return self;
}

Boolean increasing=false;

float previousSpinSpeed=0;
float spinDifference=0;



int spinCount=0;
int spinReferencePoint=640;
bool alreadyIncremented=false;
int level=1;
int levelCount=1;

-(void)update:(CFTimeInterval)currentTime {
    spinDifference=gSpinSpeed-previousSpinSpeed;
    previousSpinSpeed=gSpinSpeed;
    alexSpeed=alexSpeed+(spinDifference*100);
    
    if(alexSpeed<1 && spinDifference >0.5)
    {
        alexSpeed=alexSpeed+10;
    }
    
    if(alexSpeed>0)
    {
        if(alexSpeed<=alexDecrement)
        {
            alexSpeed=0;
        }
        else
        {
            alexSpeed=alexSpeed-(alexSpeed*0.01);
        }
    }
    
    
    //Check if the giraffe has dropped below a certian point in iorder to count spins
    NSLog(@"%f",self.giraffe.position.y);
    if(!alreadyIncremented && self.giraffe.position.y>spinReferencePoint )
    {
        spinCount++;
        levelCount--;
        if(levelCount<0)
        {
            level++;
            levelCount=level;
            [self runAction:[SKAction playSoundFileNamed:@"Tada Sound Effect.mp3" waitForCompletion:NO]];
             spinField.transform = CGAffineTransformMakeScale(1.8, 1.8);
            [UIView setAnimationDuration:0.5];
        }
        else
        {
            [self runAction:[SKAction playSoundFileNamed:@"Ding - Sound Effect1.mp3" waitForCompletion:NO]];
             spinField.transform = CGAffineTransformMakeScale(1.2, 1.2);
            [UIView setAnimationDuration:0.2];
        }
        
        alreadyIncremented=true;
        spinField.text = [NSString stringWithFormat:@"%05d",levelCount];
        
        
        
        [UIView beginAnimations:nil context:nil/*contextPoint*/];
        spinField.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDelay:0];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView commitAnimations];
        
        
        
    }
    if(self.giraffe.position.y<spinReferencePoint)
    {
        alreadyIncremented=false;
    }
    
    
    
    
    [self changeActionSpeedTo:alexSpeed onNode:self.giraffe];
}

-(void) changeActionSpeedTo: (CGFloat)newSpeed onNode:(SKSpriteNode *)node
{
    SKAction *action=[node actionForKey:@"followCircle"];
    if(action)
    {
        action.speed=newSpeed;
        speedField.text = [NSString stringWithFormat:@"%05.0f",newSpeed];
    }
}





@end
