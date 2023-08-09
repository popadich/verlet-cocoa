//
//  AnimationView.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "AnimationView.h"

@implementation AnimationView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSColor *backgroundColor = [NSColor grayColor];
    [backgroundColor setFill];
    NSRectFill(self.bounds);

    Constraints constraints = [self.solver getConstraint];
    
    NSPoint postiion = constraints.constraint;
    CGFloat radius = constraints.radius;
    NSRect constraintRect = NSMakeRect(postiion.x-radius, postiion.y-radius, radius*2, radius*2);
    
    NSColor *constraintColor = [NSColor blackColor];
    [constraintColor setFill];
    NSBezierPath *constraintOval = [NSBezierPath bezierPathWithOvalInRect:constraintRect];
    [constraintOval fill];
    
    for (Particle *p in self.solver.particlesArray) {
        NSColor *particleColor = p.color;
        [particleColor setFill];
        NSPoint pos = p.position;
        CGFloat radius = p.radius;
        NSRect pRect = NSMakeRect(pos.x - radius, pos.y - radius, radius*2, radius*2);
        NSBezierPath *oval = [NSBezierPath bezierPathWithOvalInRect:pRect];
        [oval fill];
    }
}


@end
