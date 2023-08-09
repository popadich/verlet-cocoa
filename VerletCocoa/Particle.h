//
//  Particle.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import <Cocoa/Cocoa.h>

@interface Particle : NSObject

@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) NSPoint position_last;
@property (nonatomic,assign) NSPoint position;
@property (nonatomic,assign) NSPoint acceleration;
@property (nonatomic,strong) NSColor *color;

- (id)initWithPosition:(NSPoint)startXPos andRadius:(CGFloat)rad;

- (void)setVelocity:(NSPoint)v forDelta:(CGFloat)dt;
- (NSPoint)getVelocity:(CGFloat)dt;
- (void)accelerate:(NSPoint)a;
- (void)update:(CGFloat)dt;

@end
