//
//  PrefsViewController.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "PrefsViewController.h"

@interface PrefsViewController ()
@property (weak) IBOutlet NSPopUpButton *presetsPopup;
@property (weak) IBOutlet NSSlider *customSlider;
@property (weak) IBOutlet NSTextField *customTextField;

@end

@implementation PrefsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)popupValueChanged:(NSPopUpButton *)sender {
}
- (IBAction)sliderValueChanged:(NSSlider *)sender {
}
- (IBAction)cancelButtonClicked:(NSButton *)sender {
}
- (IBAction)okjButtonClicked:(NSButton *)sender {
    NSLog(@"OK button pressed");
}

@end
