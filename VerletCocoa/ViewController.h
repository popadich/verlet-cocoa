//
//  ViewController.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import <Cocoa/Cocoa.h>
#import "Timer.h"

@interface ViewController<EggTimerProtocol> : NSViewController

@property (strong) Timer *eggTimer;

@end

