//
//  Particle.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "Particle.h"
#import "VectorCalculator.h"

@implementation Particle

- (instancetype)initWithPosition: (NSPoint)position andRadius:(CGFloat)radius
{
    self = [super init];
    if (self) {
        _position = position;
        _position_last = position;
        _acceleration = NSMakePoint(0.0, 0.0);
        _radius = radius;
        _color = [NSColor whiteColor];
    }
    return self;
}

- (void)update:(CGFloat)dt {
    NSPoint displacement;
    NSPoint pos = self.position;
    NSPoint pos_last = self.position_last;
    
    // Compute how much we moved
    displacement = vectorSubtract(pos, pos_last);
    
    // Update position
    [self setPosition_last:pos];
    NSPoint pos_d = vectorAdd(pos, displacement);
    NSPoint acc = vectorScale(self.acceleration, dt*dt);
    self.position = vectorAdd(pos_d, acc);
    
    // Reset acceleration
    [self setAcceleration:NSZeroPoint];
}

- (void)accelerate:(NSPoint)a {
    self.acceleration = vectorAdd(self.acceleration, a);
}

- (void)setVelocity:(NSPoint)v forDelta:(CGFloat)dt {
    NSPoint dv = vectorScale(v, dt);
    self.position_last = vectorSubtract(self.position, dv);
}

- (void)addVelocity:(NSPoint)v forDelta:(CGFloat)dt {
    NSPoint dv = vectorScale(v, dt);
    self.position_last = vectorSubtract(self.position_last, dv);
}

- (NSPoint)getVelocity:(CGFloat)dt {
    NSPoint velocity = vectorSubtract(self.position, self.position_last);
    velocity = vectorScale(velocity, 1/dt);
    return velocity;
}


@end
