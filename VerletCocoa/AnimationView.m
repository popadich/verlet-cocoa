//
//  AnimationView.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "AnimationView.h"

@implementation AnimationView {
    NSRect constraintRect;

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
    constraintRect = NSMakeRect(position.x, position.y, radius*2, radius*2);
    constraintRect = NSOffsetRect(constraintRect, -radius, -radius);

}


@end
