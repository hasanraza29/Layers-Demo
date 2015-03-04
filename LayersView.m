//
//  LayersView.m
//  Layers Demo
//
//  Created by Hasan on 04/03/2015.
//  Copyright (c) 2015 Wasi Ahmed. All rights reserved.
//

#import "LayersView.h"


@interface LayersView ()
{
    CGFloat layerDiameter;
}
@end

@implementation LayersView


- (instancetype)initWithFrame:(CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createCirclesWithRows:5 andColumns:3];
    }
    return self;
}

#define topOffset 20

-(void)createCirclesWithRows:(int)rows andColumns:(int)cols;
{
    layerDiameter = 0;
    self.layer.sublayers = nil;
    
    CGFloat layerWidth = self.frame.size.width / cols;
    CGFloat layerHeight = self.frame.size.height / rows;
    
    if(layerWidth < layerHeight)
        layerDiameter = layerWidth;
    else
        layerDiameter = layerHeight;
    
    
    for (int i = 0; i < rows; i++) {
        
        for (int j = 0; j < cols; j++) {
            
            CGRect frame;
            
            frame = CGRectMake(j * layerWidth, i * layerHeight, layerDiameter, layerDiameter);
            
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            CAShapeLayer *maskLayer = [CAShapeLayer layer];
            maskLayer.backgroundColor = [UIColor greenColor].CGColor;
            maskLayer.path = path.CGPath;
            
            
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.backgroundColor = [self randomColor].CGColor;
            layer.frame = frame;
            layer.mask = maskLayer;
            [layer addAnimation:[self transparencyAnimation] forKey:@"flashAnimation"];
            [self.layer addSublayer:layer];
            
        }
        
    }
}


#define ARC4RANDOM_MAX      0x100000000

- (CABasicAnimation *)transparencyAnimation {
    
    double val = ((double)arc4random() / ARC4RANDOM_MAX) + 0.3;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.delegate = self;
    [animation setFromValue:[NSNumber numberWithFloat:1.0f]];
    [animation setToValue:[NSNumber numberWithFloat:0.0f]];
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    [animation setDuration:val];
    return animation;
}

-(void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"started");
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"stopped");
}

- (UIColor *)randomColor
{
    UIColor *color;
    
    float red = (float)(arc4random()%255)/255.0;
    float green = (float)(arc4random()%255)/255;
    float blue = (float)(arc4random()%255)/255;
    
    color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
    return color;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

@end
