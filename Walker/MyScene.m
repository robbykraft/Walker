//
//  MyScene.m
//  Walker
//
//  Created by Robby Kraft on 10/24/13.
//  Copyright (c) 2013 Robby Kraft. All rights reserved.
//

#import "MyScene.h"
#import "Bug.h"
#import "Dragonfly.h"
#import "Explorer.h"
#import "Adventurer.h"

#define BRIGHT_SPEED .08f

@interface MyScene (){
    NSMutableArray *walkers;
    CGFloat height, width;
    float bright;
    NSTimer *timer;
}
@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        walkers = [NSMutableArray array];
        [self setBackgroundColor:[UIColor blackColor]];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0f/7
                                                 target:self selector:@selector(brightness) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        int random = arc4random()%4;
        Bug *walker;
        if(random == 0)
            walker = [[Bug alloc] init];
        else if (random == 1)
            walker = [[Explorer alloc] init];
        else if(random == 2)
            walker = [[Adventurer alloc] init];
        else
            walker = [[Dragonfly alloc] init];
        [walker setPosition:location];
        [walkers addObject:walker];
        [self addChild:walker];
        [walker initTail];
    }
}

-(void) brightness{
    bright+=BRIGHT_SPEED;
    [[UIScreen mainScreen] setBrightness:(1+cosf(bright))/10*3+.4];
}

-(void)update:(CFTimeInterval)currentTime {
    for(Bug *walker in walkers){
        [walker increment];
    }
}

@end
