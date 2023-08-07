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
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startButtonClicked:(NSButton *)sender {
    [timeLeftField setStringValue:@"Start"];
}
- (IBAction)stopButtonClicked:(NSButton *)sender {
    [timeLeftField setStringValue:@"Stop"];
}
- (IBAction)resetButtonClicked:(NSButton *)sender {
    [timeLeftField setStringValue:@"Reset"];
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

@end
