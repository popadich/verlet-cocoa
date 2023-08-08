//
//  ViewController.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "ViewController.h"
#import "Preferences.h"

@interface ViewController ()
@property (strong) Preferences *prefs;
@end

@implementation ViewController {
    
    __weak IBOutlet NSTextField *timeLeftField;
    __weak IBOutlet NSButton *startButton;
    __weak IBOutlet NSButton *stopButton;
    __weak IBOutlet NSButton *resetButton;
    
    NSInteger max_objects_count;

}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.countDownTimer = [[Timer alloc] init];
    [self.countDownTimer setDelegate:self];
    
    self.prefs = [[Preferences alloc] init];
    [self setupPrefs];
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startButtonClicked:(NSButton *)sender {
    if (self.countDownTimer.isPaused) {
        [self.countDownTimer resumeTimer];
    } else {
        [self.countDownTimer setDuration:self.prefs.selectedTime];
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
    [self.countDownTimer setDuration:self.prefs.selectedTime];
    [self updateDisplayFor:self.prefs.selectedTime];
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

// MARK: PREFERENCES
- (void)setupPrefs {
    [self updateDisplayFor:self.prefs.selectedTime];
    NSNotificationName notificationName = @"PrefsChanged";
    [NSNotificationCenter.defaultCenter addObserverForName:notificationName object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self checkForResetAfterPrefsChange];
    }];
}

- (void)updateFromPrefs {
    [self.countDownTimer setDuration:self.prefs.selectedTime];
    max_objects_count     = [[NSUserDefaults standardUserDefaults] integerForKey:@"maximumNumberOfParticles"];
    [self resetButtonClicked:nil];
}

- (void)checkForResetAfterPrefsChange {
    if (self.countDownTimer.isStopped || self.countDownTimer.isPaused) {
        [self updateFromPrefs];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = @"Reset timer with the new settings?";
        alert.informativeText = @"This will stop your current timer!";
        [alert setAlertStyle:NSAlertStyleWarning];
        
        [alert addButtonWithTitle:@"Reset"];
        [alert addButtonWithTitle:@"Cancel"];
        
        NSInteger response = [alert runModal];
        if (response == NSAlertFirstButtonReturn) {
            [self updateFromPrefs];
        }
    }
}


// MARK: PROTOCOL METHODS
- (void)timeRemainingOnTimer:(Timer *)timer withInterval:(NSTimeInterval)timeRemaining {
    [self updateDisplayFor:timeRemaining];
}

- (void)timerHasFinished:(Timer *)timer {
    [self updateDisplayFor:0];
}

@end
