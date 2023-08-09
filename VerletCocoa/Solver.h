//
//  Solver.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import <Foundation/Foundation.h>
#import "Particle.h"

NS_ASSUME_NONNULL_BEGIN

struct Constraints {
    NSPoint position;
    CGFloat radius;
};
typedef struct Constraints Constraints;

@interface Solver : NSObject

@property (nonatomic, strong) id delegate;
@property (strong)NSMutableArray *particlesArray;

- (void)startAnimation;
- (void)stopAnimation;
- (void)resetAnimation;

-(Particle *)addParticle:(NSPoint)pos withRadius:(CGFloat)radius;
- (void)setConstraint:(NSPoint)position withRadius:(CGFloat)radius;
- (Constraints)getConstraint;
- (void)setSubStepsCount:(NSInteger)sub_steps;
- (void)setSimulationUpdateRate:(NSInteger)rate;
- (CGFloat)getTime;
- (NSInteger)getObjectsCount;
- (void)setObjectVelocity:(Particle *)object velocity:(NSPoint)v;

@end


@protocol SolverProtocol

- (void)updateAnimationView:(Solver *)solver;
- (void)animationHasFinished:(Solver *)solver;

@end

NS_ASSUME_NONNULL_END
