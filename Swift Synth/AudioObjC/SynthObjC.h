//
//  SynthObjC.h
//  Swift Synth
//
//  Created by Alexey Naumov on 27.11.2019.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OscillatorObjC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SynthObjC : NSObject

@property (nonatomic, assign) float volume;
@property (nonatomic, strong, nonnull) OscillatorObjC *oscillator;

- (instancetype)initWithOscillator:(OscillatorObjC *)oscillator;

@end

NS_ASSUME_NONNULL_END
