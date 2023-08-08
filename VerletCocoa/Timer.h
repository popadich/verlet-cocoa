//
//  Timer.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Timer : NSObject
@property (nonatomic, strong) id delegate;
@property (nonatomic, weak) NSDate *startTime;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, assign) NSTimeInterval elapsedTime;

- (BOOL)isStopped;
- (BOOL)isPaused;

- (void)startTimer;
- (void)stopTimer;
- (void)resumeTimer;
- (void)resetTimer;
@end


@protocol TimerProtocol

- (void)timeRemainingOnTimer:(Timer *)timer withInterval:(NSTimeInterval)timeRemaining;
- (void)timerHasFinished:(Timer *)timer;

@end

NS_ASSUME_NONNULL_END
