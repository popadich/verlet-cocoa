//
//  VectorCalculator.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/8/23.
//

#import "VectorCalculator.h"
#include <math.h>

CGFloat radians (CGFloat degrees) {return degrees * M_PI/180;}

NSPoint vectorIdentity(void)
{
    NSPoint identityVector = NSMakePoint(1.0, 1.0);
    return identityVector;
}

NSPoint vectorRotate(NSPoint vector, CGFloat theta)
{
    CGFloat r = vectorMagnitude(vector);
    NSPoint rotateVector = NSMakePoint(r*cos(theta), r*sin(theta));
    return rotateVector;
}


NSPoint vectorScale(NSPoint vector, CGFloat scale)
{
    NSPoint scaledVector = NSMakePoint(vector.x*scale, vector.y*scale);
    return scaledVector;
}

NSPoint vectorScaleByVector(NSPoint vector, NSPoint scale)
{
    NSPoint scaledVector = NSMakePoint(vector.x*scale.x, vector.y*scale.y);
    return scaledVector;
}

NSPoint vectorAdd(NSPoint vector_a, NSPoint vector_b)
{
    NSPoint sumVector = NSMakePoint(vector_a.x + vector_b.x, vector_a.y + vector_b.y);
    return sumVector;
}

NSPoint vectorSubtract(NSPoint vector_a, NSPoint vector_b)
{
    NSPoint sumVector = NSMakePoint(vector_a.x - vector_b.x, vector_a.y - vector_b.y);
    return sumVector;
}

CGFloat vectorDotProduct(NSPoint vector_a, NSPoint vector_b)
{
    CGFloat dotValue = vector_a.x*vector_b.x + vector_a.y*vector_b.y;
    
    return dotValue;
}

/**
 * Calculate the cross product for two 2D vectors by treating them as 3D
 * vectors with zero for the third component. As the direction of the
 * resulting vector is always directly up the z-axis, this returns a scalar
 * equal to |a|*|b|*sin(alpha) where alpha is the angle in the plane between
 * a and b.
 */
CGFloat vectorCrossProduct(NSPoint a, NSPoint b) {
    return a.x*b.y - b.x*a.y;
}

CGFloat vectorMagnitude(NSPoint vector)
{
    return sqrt((vector.x*vector.x) + (vector.y*vector.y));
}


NSPoint vectorNormal(NSPoint vector)
{
    CGFloat magnitude = sqrt((vector.x*vector.x) +(vector.y*vector.y));

    NSPoint normal = NSMakePoint(vector.x/magnitude, vector.y/magnitude);
    return normal;
}


