//
//  Solver.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "Solver.h"
#import "VectorCalculator.h"

@implementation Solver {
    NSTimer *simulationTimer;
    CGFloat frame_interval;
    NSPoint m_constraint_center;
    CGFloat m_constraint_radius;
    NSInteger m_sub_steps;
    NSPoint m_gravity;
    CGFloat m_time;
    CGFloat m_frame_dt;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.particlesArray = [[NSMutableArray alloc] initWithCapacity:400];
        
        m_sub_steps = 1;
        m_gravity = NSMakePoint(0.0, -1000.0);
        m_time = 0.0;
        m_frame_dt = 0.0;
    }
    return self;
}

- (NSColor *)getRainbow:(CGFloat)t {
    CGFloat r = sin(t);
    CGFloat g = sin(t + 0.33f * 2.0f * M_PI);
    CGFloat b = sin(t + 0.66f * 2.0f * M_PI);
    NSColor *color = [NSColor colorWithRed:r*r green:g*g blue:b*b alpha:1.0];
    return color;
}

-(Particle *)addParticle:(NSPoint)pos withRadius:(CGFloat)radius {
    // add a particle to the internal particles array
    Particle *aParticle = [[Particle alloc] initWithPosition:pos andRadius:radius];
    [self.particlesArray addObject:aParticle];
    
    [aParticle setColor:[self getRainbow:self.getTime]];
    
    return aParticle;
}

- (void)update {
    m_time += m_frame_dt;
    
    CGFloat step_dt = [self getStepDt];
    for (NSInteger i=m_sub_steps; i>0; i--) {
        [self applyGravity];
        [self checkCollisions:step_dt];
        [self applyConstraint];
        [self updateObjects:step_dt];
    }
    [self.delegate updateAnimationView:self];
}

- (void)setSimulationUpdateRate:(NSInteger)rate {
    m_frame_dt = 1.0f / rate;
}

- (void)setSubStepsCount:(NSInteger)sub_steps {
    m_sub_steps = sub_steps;
}


- (void)setObjectVelocity:(Particle *)object velocity:(NSPoint)v {
    [object setVelocity:v forDelta:[self getStepDt]];
}

- (void)setConstraint:(NSPoint)position withRadius:(CGFloat)radius {
    m_constraint_center = position;
    m_constraint_radius = radius;
}

- (NSInteger)getObjectsCount{
    return self.particlesArray.count;
}

- (CGFloat)getTime {
    return m_time;
}

- (CGFloat)getStepDt {
    return (m_frame_dt / (CGFloat)m_sub_steps);
}

- (void)applyGravity {
    for (Particle *p in _particlesArray) {
        [p accelerate:m_gravity];
    }
}

- (void)checkCollisions:(CGFloat)dt {
    CGFloat response_coef = 0.75f;
    NSInteger objects_count = _particlesArray.count;

    for(NSInteger i=0; i<objects_count; ++i) {
        Particle *object_1 = _particlesArray[i];
        
        for(NSInteger k=i+1; k<objects_count; ++k) {
            Particle *object_2 = _particlesArray[k];
            
            NSPoint v = vectorSubtract(object_1.position, object_2.position);
            CGFloat dist2 = v.x * v.x + v.y * v.y;
            CGFloat min_dist = object_1.radius + object_2.radius;
            // Check overlapping
            if (dist2 < min_dist * min_dist) {
                CGFloat dist = sqrt(dist2);
                NSPoint n = NSMakePoint(v.x/dist, v.y/dist);
                CGFloat mass_ratio_1 = object_1.radius / (object_1.radius + object_2.radius);
                CGFloat mass_ratio_2 = object_2.radius / (object_1.radius + object_2.radius);
                CGFloat delta        = 0.5f * response_coef * (dist - min_dist);
                // Update positions
                NSPoint p1 = object_1.position;
                NSPoint p2 = object_2.position;
                object_1.position = NSMakePoint(p1.x - n.x * (mass_ratio_2 * delta),
                                                p1.y - n.y * (mass_ratio_2 * delta));
                object_2.position = NSMakePoint(p2.x + n.x * (mass_ratio_1 * delta),
                                                p2.y + n.y * (mass_ratio_1 * delta));
            }
        }
    }
}

- (void)applyConstraint {
    for (Particle *p in self.particlesArray) {
        NSPoint v = NSMakePoint(m_constraint_center.x - p.position.x, m_constraint_center.y - p.position.y);
        CGFloat dist = sqrt(v.x * v.x + v.y * v.y);
        if (dist > (m_constraint_radius - p.radius)) {
            NSPoint n = NSMakePoint(v.x / dist, v.y / dist);
            p.position = NSMakePoint (m_constraint_center.x - n.x * (m_constraint_radius - p.radius),
                                        m_constraint_center.y - n.y * (m_constraint_radius - p.radius));
        }
    }
}

- (void)updateObjects:(CGFloat)dt {
    for (Particle *p in self.particlesArray) {
        [p update:dt];
    }
}

// MARK: ACTIVITY METHODS

- (void)startAnimation {
    simulationTimer = [NSTimer scheduledTimerWithTimeInterval:m_frame_dt repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self update];
    }];
}

- (void)stopAnimation {
    [simulationTimer invalidate];
    simulationTimer = nil;
    [self.delegate animationHasFinished:self];
}

- (void)resetAnimation {
    [self.particlesArray removeAllObjects];
    m_time = 0.0;
    [self update];
}


@end
