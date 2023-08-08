//
//  AppDelegate.m
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import "AppDelegate.h"

@interface AppDelegate ()


@end

static NSDictionary *defaultValues(void) {
    static NSDictionary *userDefaultsDictionary = @{ @"maximumNumberOfParticles" : @10,
                                                     @"selectedTime" : @360
    };
    
    return userDefaultsDictionary;
}



@implementation AppDelegate


+ (void)initialize
{
    if (self == [AppDelegate class]) {
        // Set up default values for preferences managed by NSUserDefaultsController
        // Nothing gets written to the Preferences "file" until its value changes from
        // the original defaults value.
        NSDictionary *userDefaults = defaultValues();
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaults];
        [[NSUserDefaultsController sharedUserDefaultsController] setInitialValues:userDefaults];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (BOOL)applicationSupportsSecureRestorableState:(NSApplication *)app {
    return YES;
}


@end
