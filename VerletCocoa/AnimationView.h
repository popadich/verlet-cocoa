//
//  AnimationView.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import <Cocoa/Cocoa.h>
#import "Particle.h"

NS_ASSUME_NONNULL_BEGIN

struct Constraints {
    NSPoint position;
    CGFloat radius;
};
typedef struct Constraints Constraints;

@interface AnimationView : NSView
{

}

@property (weak) NSArray * particlesArray;

- (void)setConstraint:(NSPoint)position withRadius:(CGFloat)radius;


@end

NS_ASSUME_NONNULL_END
