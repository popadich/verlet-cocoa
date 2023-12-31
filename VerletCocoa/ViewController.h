//
//  ViewController.h
//  VerletCocoa
//
//  Created by Alex Popadich on 8/7/23.
//

#import <Cocoa/Cocoa.h>
#import "Timer.h"
#import "AnimationView.h"

@interface ViewController<TimerProtocol, SolverProtocol> : NSViewController

@property (strong) Timer *countDownTimer;
@property (weak) IBOutlet AnimationView *animationView;

@end

