//
//  ViewController.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "ViewController.h"

@implementation ViewController {
    
    __weak IBOutlet NSTextField *timeLeftField;
    __weak IBOutlet NSButton *startButton;
    __weak IBOutlet NSButton *stopButton;
    __weak IBOutlet NSButton *resetButton;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.countDownTimer = [[Timer alloc] init];
    [self.countDownTimer setDelegate:self];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startButtonClicked:(NSButton *)sender {
    if (self.countDownTimer.isPaused) {
        [self.countDownTimer resumeTimer];
    } else {
        [self.countDownTimer setDuration:360];
        [self.countDownTimer startTimer];
    }
    [self configureButtonAndMenus];
}

- (IBAction)stopButtonClicked:(NSButton *)sender {
    [self.countDownTimer stopTimer];
    [self configureButtonAndMenus];
}

- (IBAction)resetButtonClicked:(NSButton *)sender {
    [self.countDownTimer resetTimer];
    [self.countDownTimer setDuration:360];
    [self updateDisplayFor:360];
    [self configureButtonAndMenus];
}

// these are called through the first responder
- (IBAction)startTimerMenuItemSelected:(id)sender {
    [self startButtonClicked:sender];
}

- (IBAction)stopTimerMenuItemSelected:(id)sender {
    [self stopButtonClicked:sender];
}

- (IBAction)resetTimerMenuItemSelected:(id)sender {
    [self resetButtonClicked:sender];
}

- (void)updateDisplayFor: (NSTimeInterval)timeRemaining {
    // set defaultLabel here
    timeLeftField.stringValue = [self textToDisplayFor:timeRemaining];
}

- (NSString *)textToDisplayFor:(NSTimeInterval)timeRemaining {
    NSString *timeRemainingDisplay = nil;
    
    if (timeRemaining == 0) {
        return @"Done!";
    }
    
    NSTimeInterval minutesRemaining = floor(timeRemaining / 60);
    NSTimeInterval secondsRemaining = timeRemaining - (minutesRemaining * 60);

    timeRemainingDisplay = [NSString stringWithFormat:@"%d:%02d", (int)minutesRemaining, (int)secondsRemaining];

    return timeRemainingDisplay;
}

- (void)configureButtonAndMenus {
    BOOL enableStart = YES;
    BOOL enableStop = NO;
    BOOL enableReset = NO;
    
    if (self.countDownTimer.isStopped) {
        enableStart = YES;
        enableStop = NO;
        enableReset = NO;
    } else if (self.countDownTimer.isPaused) {
        enableStart = YES;
        enableStop = NO;
        enableReset = YES;
    } else {
        enableStart = NO;
        enableStop = YES;
        enableReset = NO;
    }
    
    [startButton setEnabled:enableStart];
    [stopButton setEnabled:enableStop];
    [resetButton setEnabled:enableReset];
    
}


- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
    SEL action = [menuItem action];
    
    if (action == @selector(startTimerMenuItemSelected:)) {
        if (!(self.countDownTimer.isStopped || self.countDownTimer.isPaused)) {
            return NO;
        }
    }
    if (action == @selector(stopTimerMenuItemSelected:)) {
        if (self.countDownTimer.isPaused || self.countDownTimer.isStopped) {
            return NO;
        }
    }
    if (action == @selector(resetTimerMenuItemSelected:)) {
        if (!self.countDownTimer.isPaused) {
            return NO;
        }
    }
    return YES;
}


// MARK: PROTOCOL METHODS
- (void)timeRemainingOnTimer:(Timer *)timer withInterval:(NSTimeInterval)timeRemaining {
    [self updateDisplayFor:timeRemaining];
}

- (void)timerHasFinished:(Timer *)timer {
    [self updateDisplayFor:0];
}

@end
