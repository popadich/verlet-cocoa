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
    self.eggTimer = [[Timer alloc] init];
    [self.eggTimer setDelegate:self];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startButtonClicked:(NSButton *)sender {
    if (self.eggTimer.isPaused) {
        [self.eggTimer resumeTimer];

    } else {
        [self.eggTimer setDuration:360];
        [self.eggTimer startTimer];
    }
}

- (IBAction)stopButtonClicked:(NSButton *)sender {
    [self.eggTimer stopTimer];
}

- (IBAction)resetButtonClicked:(NSButton *)sender {
    [self.eggTimer resetTimer];
    [self.eggTimer setDuration:360];
    [self updateDisplayFor:360];
}

// these are called because through the first responder
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


// MARK: PROTOCOL METHODS
- (void)timeRemainingOnTimer:(Timer *)timer withInterval:(NSTimeInterval)timeRemaining {
    [self updateDisplayFor:timeRemaining];
}

- (void)timerHasFinished:(Timer *)timer {
    [self updateDisplayFor:0];
}

@end
