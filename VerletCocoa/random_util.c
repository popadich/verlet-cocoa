/*
 *  snow_util.c
 *  VerletCocoa
 *
 *  Created by Alex Popadich on 8/8/23.
 *
 */

#include "stdlib.h"
#include "random_util.h"


float randomFloatBetweenSmallNumberAndBigNumber(float smallNumber,float bigNumber) {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}


// Returns a random floating point number between
// 0.0 and 1.0.
float randomFloatNormal(void)
{
    return randomFloatBetweenSmallNumberAndBigNumber(0.0, 1.0);
}
