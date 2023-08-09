//
//  VectorCalculator.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import <Foundation/Foundation.h>

CGFloat radians (CGFloat degrees);
NSPoint vectorNormal(NSPoint vector);
CGFloat vectorMagnitude(NSPoint vector);
CGFloat vectorDotProduct(NSPoint vector_a, NSPoint vector_b);
CGFloat vectorCrossProduct(NSPoint a, NSPoint b);
NSPoint vectorSubtract(NSPoint vector_a, NSPoint vector_b);
NSPoint vectorAdd(NSPoint vector_a, NSPoint vector_b);
NSPoint vectorScaleByVector(NSPoint vector, NSPoint scale);
NSPoint vectorScale(NSPoint vector, CGFloat scale);
NSPoint vectorIdentity(void);

