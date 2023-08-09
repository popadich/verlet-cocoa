/*
 *  snow_util.h
 *  VerletCocoa
 *
 *  Created by Alex Popadich on 8/8/23.
 *
 */

float randomFloatNormal(void);
float randomFloatBetweenSmallNumberAndBigNumber(float smallNumber,float bigNumber);

#define random_between(smallNumber, bigNumber) ((((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * (bigNumber - smallNumber)) + smallNumber)

