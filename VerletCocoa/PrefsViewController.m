//
//  PrefsViewController.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "PrefsViewController.h"
#import "Preferences.h"

@interface PrefsViewController ()
@property (weak) IBOutlet NSPopUpButton *presetsPopup;
@property (weak) IBOutlet NSSlider *customSlider;
@property (weak) IBOutlet NSTextField *customTextField;

@property (strong) Preferences *prefs;

@end

@implementation PrefsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.prefs = [[Preferences alloc] init];
    [self showExistingPrefs];
    
}

- (IBAction)popupValueChanged:(NSPopUpButton *)sender {
    if ([sender.title isEqualToString:@"Custom"]) {
        [self.customSlider setEnabled:YES];
        return;
    }
    
    NSInteger newTimerDuration = [sender selectedTag];
    [self.customSlider setIntegerValue:newTimerDuration];
    [self showSliderValueAsText];
    [self.customSlider setEnabled:NO];
}

- (IBAction)sliderValueChanged:(NSSlider *)sender {
    [self showSliderValueAsText];
}

- (IBAction)cancelButtonClicked:(NSButton *)sender {
    [self.view.window close];
}

- (IBAction)okjButtonClicked:(NSButton *)sender {
    [self saveNewPrefs];
    [self.view.window close];
}


- (void)saveNewPrefs {
    self.prefs.selectedTime = self.customSlider.doubleValue * 60;
    
    [NSNotificationCenter.defaultCenter postNotificationName:@"PrefsChanged" object:nil];
}

- (void)showExistingPrefs {
    NSInteger selectedTimeInMinutes = self.prefs.selectedTime / 60;
    
    [self.presetsPopup selectItemWithTitle:@"Custom"];
    [self.customSlider setEnabled:YES];
    
    for (NSMenuItem *item in self.presetsPopup.itemArray) {
        if (item.tag == selectedTimeInMinutes) {
            [self.presetsPopup selectItem:item];
            [self.customSlider setEnabled:NO];
        }
    }
    
    [self.customSlider setIntegerValue:selectedTimeInMinutes];
    [self showSliderValueAsText];
}

- (void)showSliderValueAsText {
    NSInteger newTimerDuration = [self.customSlider integerValue];
    
    NSString *minutesDescription = (newTimerDuration == 1) ? @"minute" : @"minutes";
    NSString *fullDescription = [NSString stringWithFormat:@"%ld %@",(long)newTimerDuration, minutesDescription];
    [self.customTextField setStringValue:fullDescription];
}

@end
