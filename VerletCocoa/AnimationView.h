//
//  AnimationView.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import <Cocoa/Cocoa.h>
#import "Particle.h"
#import "Solver.h"

NS_ASSUME_NONNULL_BEGIN

@interface AnimationView : NSView
{
    
    BOOL running;
}

@property (strong)Solver *solver;


@end

NS_ASSUME_NONNULL_END
