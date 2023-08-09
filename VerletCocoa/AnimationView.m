//
//  AnimationView.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "AnimationView.h"

@implementation AnimationView {
    NSPoint constraintCenter;
    CGFloat constraintRadius;

    NSColor *backgroundColor;
    NSColor *constraintColor;
}

- (void)awakeFromNib {
    constraintRadius = 100.0f;

    backgroundColor = [NSColor grayColor];
    constraintColor = [NSColor blackColor];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [backgroundColor setFill];
    NSRectFill(self.bounds);
    
    NSRect constraintRect = NSMakeRect(constraintCenter.x-constraintRadius, constraintCenter.y-constraintRadius, constraintRadius*2, constraintRadius*2);

    [constraintColor setFill];
    NSBezierPath *constraintOval = [NSBezierPath bezierPathWithOvalInRect:constraintRect];
    [constraintOval fill];
    
    for (Particle *p in self.particlesArray) {
        [p.color setFill];
        NSPoint position = p.position;
        CGFloat radius = p.radius;
        NSRect pRect = NSMakeRect(position.x - radius, position.y - radius, radius*2, radius*2);
        NSBezierPath *oval = [NSBezierPath bezierPathWithOvalInRect:pRect];
        [oval fill];
    }
}

- (void)setConstraint:(NSPoint)position withRadius:(CGFloat)radius {
    constraintCenter = position;
    constraintRadius = radius;
}

- (Constraints)getConstraint {
    Constraints constraints;
    constraints.position = constraintCenter;
    constraints.radius = constraintRadius;
    
    return constraints;
}


@end
