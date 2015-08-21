//
//  Background.m
//  AlexTest7
//
//  Created by alex on 8/15/15.
//  Copyright (c) 2015 alex. All rights reserved.
//

#import "Foreground.h"
#import "AlexButton.h"
#import "Globals.h"


@interface Foreground(){
    UITextField *_textField;
    
}
@end

@implementation Foreground
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    self.backgroundColor=[UIColor clearColor];
     NSLog(@"Slider Value %d",200);
    if(self){
        AlexButton *alexButton = [[AlexButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
        [alexButton addTarget:self action:@selector(alexButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [alexButton addTarget:self action:@selector(alexButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:alexButton];
        
        //[self setNeedsDisplay];
    }
    return self;
}

CAShapeLayer *circleLayer;


float newRadius=200;

/** This function is called when Circular slider value changes **/
-(void)alexButtonTouchDown:(AlexButton*)alexButton{

    gSpinSpeed++;
    
    circleLayer.fillColor = [[UIColor redColor] CGColor];
    CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnimation.fromValue = (id)[[UIColor yellowColor] CGColor];
    fillColorAnimation.toValue = (id)[[UIColor redColor] CGColor];
    
    UIBezierPath *newPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2) radius:(self.frame.size.height/4)+2 startAngle:0 endAngle:(2*M_PI) clockwise:YES];
    [circleLayer setPath:[newPath CGPath]];
    
}

-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"Animation Finished ");
}


-(void)alexButtonTouchUpInside:(AlexButton*)alexButton{
    circleLayer.fillColor = [[UIColor yellowColor] CGColor];
    CABasicAnimation *fillColorAnimation = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    fillColorAnimation.fromValue = (id)[[UIColor redColor] CGColor];
    fillColorAnimation.toValue = (id)[[UIColor yellowColor] CGColor];
    
    UIBezierPath *newPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2) radius:self.frame.size.height/4 startAngle:0 endAngle:(2*M_PI) clockwise:YES];
    
    [circleLayer setPath:[newPath CGPath]];
    }

-(void) drawRect:(CGRect)rect
{
    circleLayer = [CAShapeLayer layer];
    circleLayer.backgroundColor=[ [UIColor clearColor]CGColor];
   
     NSLog(@"Frame Width %f",self.frame.size.width);
     NSLog(@"Frame Height %f",self.frame.size.height);
    
    [circleLayer setBounds:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [circleLayer setPosition:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2,self.frame.size.height/2) radius:self.frame.size.height/4 startAngle:0 endAngle:(2*M_PI) clockwise:YES];
    
    [circleLayer setPath:[path CGPath]];
    circleLayer.strokeColor = [[UIColor blueColor] CGColor];
    circleLayer.lineWidth = 2;
    circleLayer.fillColor = [[UIColor yellowColor] CGColor];
    [self.layer addSublayer:circleLayer];
}



@end