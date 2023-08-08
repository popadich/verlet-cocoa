//
//  Timer.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "Timer.h"

@implementation Timer {
    NSTimer *timer;

}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.startTime = nil;
        self.duration = 360.0;
        self.elapsedTime = 0.0;
    }
    return self;
}
- (BOOL)isStopped {
    return (timer == nil && _elapsedTime == 0);
}

- (BOOL)isPaused {
    return (timer == nil && _elapsedTime > 0);
}

- (void)timerAction {
    // 1
    NSDate *startTime = self.startTime;
    if (startTime == nil)
        return;
    
    // 2
    self.elapsedTime = -startTime.timeIntervalSinceNow;
    
    // 3
    NSTimeInterval secondsRemaining = ceil(self.duration - self.elapsedTime); // ceil is a library function
    
    // 4
    if (secondsRemaining <= 0) {
        [self resetTimer];
        [self.delegate timerHasFinished:self];
    } else {
        [self.delegate timeRemainingOnTimer:self withInterval:secondsRemaining];
    }
    
}


- (void)startTimer {
    self.startTime = [NSDate date];
    self.elapsedTime = 0.0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self timerAction];
    }];
    
    [self timerAction];
}


- (void)resumeTimer {
    self.startTime = [NSDate dateWithTimeIntervalSinceNow:-self.elapsedTime];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer *timer) {
        [self timerAction];
    }];
    
    [self timerAction];
}


- (void)stopTimer {
    [timer invalidate];
    timer = nil;
    
    [self timerAction];
}


- (void)resetTimer {
    // stop the timer & reset back to start
    [timer invalidate];
    timer = nil;
    
    [self setStartTime:nil];
    
    self.duration = 360.0;
    self.elapsedTime = 0.0;
    
    [self timerAction];
}

@end
