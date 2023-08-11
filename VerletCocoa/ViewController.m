//
//  ViewController.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "ViewController.h"
#import "Preferences.h"
#import "Solver.h"
#import "Particle.h"
#import "random_util.h"

@interface ViewController ()
@property (strong) Preferences *prefs;
@end

@implementation ViewController {
    
    __weak IBOutlet NSTextField *timeLeftField;
    __weak IBOutlet NSButton *startButton;
    __weak IBOutlet NSButton *stopButton;
    __weak IBOutlet NSButton *resetButton;
    
    NSInteger max_objects_count;
    CGFloat object_spawn_delay;
    CGFloat object_spawn_speed;
    CGFloat object_min_radius;
    CGFloat object_max_radius;
    CGFloat max_angle;
    NSPoint object_spawn_position;

    Solver *solver;
    NSTimer *eventTimer;

}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.countDownTimer = [[Timer alloc] init];
    [self.countDownTimer setDelegate:self];
    
    self.prefs = [[Preferences alloc] init];
    [self setupPrefs];
    
    solver = [[Solver alloc] init];
    [solver setDelegate:self];
    
    // Solver configuration
    max_objects_count = [[NSUserDefaults standardUserDefaults] integerForKey:@"maximumNumberOfParticles"];
    object_spawn_delay    = 0.125f;
    object_spawn_speed    = -1200.0f;
    object_min_radius     = 4.0f;
    object_max_radius     = 20.0f;
    max_angle             = 1.0f;
    object_spawn_position = NSMakePoint(0.0, 0.0);
    NSInteger frame_rate  = 30;

    [solver setSubStepsCount:8];
    [solver setSimulationUpdateRate:frame_rate];
    [self setConstraints];

 }

- (void) setConstraints {
    CGFloat constraintSize = (self.animationView.bounds.size.height);
    CGFloat constraintRadius = constraintSize / 2.0;
    NSPoint centerPoint = NSMakePoint(constraintSize - constraintRadius, constraintSize - constraintRadius);
    object_spawn_position = NSMakePoint(centerPoint.x, centerPoint.y + constraintRadius - 40.0);
    
    [self.animationView setConstraint:centerPoint withRadius:constraintRadius];
    [solver setConstraint:centerPoint withRadius:constraintRadius];

}

- (void) viewDidLayout {
    [self setConstraints];
    [solver.particlesArray removeAllObjects];
}

- (IBAction)startButtonClicked:(NSButton *)sender {
    if (self.countDownTimer.isPaused) {
        [self.countDownTimer resumeTimer];
        [solver startAnimation];
        [self startParticleEvents];

    } else {
        [self.countDownTimer setDuration:self.prefs.selectedTime];
        [self.countDownTimer startTimer];
        [solver startAnimation];
        [self startParticleEvents];
    }
    [self configureButtonsState];
}

- (IBAction)stopButtonClicked:(NSButton *)sender {
    [self.countDownTimer stopTimer];
    [solver stopAnimation];
    [self stopParticleEvents];
    [self configureButtonsState];
}

- (IBAction)resetButtonClicked:(NSButton *)sender {
    [self.countDownTimer resetTimer];
    [self.countDownTimer setDuration:self.prefs.selectedTime];
    [self updateDisplayFor:self.prefs.selectedTime];
    [self stopParticleEvents];
    [solver resetAnimation];
    [self configureButtonsState];
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

- (void)configureButtonsState {
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


- (BOOL)validateUserInterfaceItem:(id<NSValidatedUserInterfaceItem>)item {
    SEL action = [item action];
    
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
    max_objects_count = [[NSUserDefaults standardUserDefaults] integerForKey:@"maximumNumberOfParticles"];
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

// MARK: Particle Events
- (NSColor *)getRainbow:(CGFloat)t {
    CGFloat r = sin(t);
    CGFloat g = sin(t + 0.33f * 2.0f * M_PI);
    CGFloat b = sin(t + 0.66f * 2.0f * M_PI);
    NSColor *color = [NSColor colorWithRed:r*r green:g*g blue:b*b alpha:1.0];
    return color;
}

- (void)controllerEvent {
    if ([solver getObjectsCount] < max_objects_count) {
      
        Particle *object = [solver addParticle:object_spawn_position withRadius:randomFloatBetweenSmallNumberAndBigNumber(object_min_radius, object_max_radius)];
        CGFloat t = [solver getTime];
        CGFloat angle  = max_angle * sin(t) + M_PI * 0.5f;
        
        NSPoint velocity = NSMakePoint(object_spawn_speed * cos(angle), object_spawn_speed * sin(angle));
        [solver setObjectVelocity:object velocity:velocity];
        [object setColor:[self getRainbow:t]];
    }
}

- (void)startParticleEvents {
    [self.animationView setParticlesArray:solver.particlesArray];    

    eventTimer = [NSTimer scheduledTimerWithTimeInterval:object_spawn_delay repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self controllerEvent];
    }];
}

- (void)stopParticleEvents {
    [eventTimer invalidate];
    eventTimer = nil;
}

- (void)updateAnimationView:(Solver *)solver {
    [self.animationView setNeedsDisplay:YES];
}


// MARK: TIMER PROTOCOL METHODS
- (void)timeRemainingOnTimer:(Timer *)timer withInterval:(NSTimeInterval)timeRemaining {
    [self updateDisplayFor:timeRemaining];
}

- (void)timerHasFinished:(Timer *)timer {
    [self updateDisplayFor:0];
    
    [self stopButtonClicked:nil];
}

@end
