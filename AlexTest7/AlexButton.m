//
//  AlexButton.m
//  BouncingBalls
//
//  Created by alex on 8/7/15.
//  Copyright (c) 2015 alex. All rights reserved.
//

#import "AlexButton.h"



@interface AlexButton(){
    UITextField *_textField;
    int radius;
}
@end

/** Parameters **/
#define TB_SAFEAREA_PADDING 60

@implementation AlexButton

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self){
        self.backgroundColor=[UIColor clearColor];
        radius = self.frame.size.width/2 - TB_SAFEAREA_PADDING;
        self.angle = 20;
        }
    
    return self;
}


#pragma mark - UIControl Override -

/** Tracking is started **/
-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super beginTrackingWithTouch:touch withEvent:event];
    NSLog(@"AlexButton Touched");
    return YES;
}


-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super continueTrackingWithTouch:touch withEvent:event];
    NSLog(@"AlexButton tracked");
    CGPoint lastPoint = [touch locationInView:self];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    return YES;
}

/** Track is finished **/
-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [super endTrackingWithTouch:touch withEvent:event];
     NSLog(@"AlexButton Released");
}


-(void)drawRect:(CGRect)rect{
    
    /**
    self.layer.backgroundColor=[[UIColor clearColor]CGColor];
    
    [super drawRect:rect];
    CGContextRef ctx = UIGraphicsGetCurrentContext();
       //Create the path
    CGContextAddArc(ctx, self.frame.size.width/2, self.frame.size.height/2, radius, 0, M_PI *2, 0);
    //Set the stroke color to black
    [[UIColor orangeColor]setStroke];
    //Define line width and cap
    CGContextSetLineWidth(ctx, 2);
    CGContextSetLineCap(ctx, kCGLineCapButt);
    //draw it!
    CGContextDrawPath(ctx, kCGPathStroke);
    **/

}




@end
