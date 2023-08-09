//
//  AnimationView.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "AnimationView.h"

@implementation AnimationView {
    NSColor *backgroundColor;
    NSColor *constraintColor;
}

- (void)awakeFromNib {
    backgroundColor = [NSColor grayColor];
    constraintColor = [NSColor blackColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [backgroundColor setFill];
    NSRectFill(self.bounds);
    
    Constraints constraints = [self.solver getConstraint];
    NSPoint position = constraints.position;
    CGFloat radius = constraints.radius;
    NSRect constraintRect = NSMakeRect(position.x-radius, position.y-radius, radius*2, radius*2);

    [constraintColor setFill];
    NSBezierPath *constraintOval = [NSBezierPath bezierPathWithOvalInRect:constraintRect];
    [constraintOval fill];
    
    for (Particle *p in self.solver.particlesArray) {
        [p.color setFill];
        position = p.position;
        radius = p.radius;
        NSRect pRect = NSMakeRect(position.x - radius, position.y - radius, radius*2, radius*2);
        NSBezierPath *oval = [NSBezierPath bezierPathWithOvalInRect:pRect];
        [oval fill];
    }
}


@end
