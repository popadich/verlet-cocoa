//
//  Preferences.m
//  VerletCocoa
//
//  Created by Alex Popadich on 7/14/23.
//

#import "Preferences.h"

@implementation Preferences

@synthesize selectedTime = _selectedTime;

- (void)setSelectedTime:(NSTimeInterval)newValue {
    [NSUserDefaults.standardUserDefaults setFloat:newValue forKey:@"selectedTime"];
    _selectedTime = newValue;
}

- (NSTimeInterval)selectedTime {
    NSTimeInterval savedTime = [NSUserDefaults.standardUserDefaults floatForKey:@"selectedTime"];
    if (savedTime > 0) {
        return savedTime;
    }
    return 360;
}

@end
