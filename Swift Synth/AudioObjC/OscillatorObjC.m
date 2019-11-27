//
//  OscillatorObjC.m
//  Swift Synth
//
//  Created by Alexey Naumov on 27.11.2019.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

#import "OscillatorObjC.h"

@interface OscillatorObjC()

@property (nonatomic, assign) Waveform waveform;

@end

@interface OscillatorObjC (Private)

- (float)sine:(float)time;
- (float)triangle:(float)time;
- (float)sawtooth:(float)time;
- (float)square:(float)time;
- (float)whiteNoise:(float)time;

@end

@implementation OscillatorObjC

- (instancetype)initWithWaveform:(Waveform)waveform {
    if (self = [super init]) {
        self.amplitude = 1;
        self.frequency = 440;
        self.waveform = waveform;
    }
    return self;
}

- (float)valueForTime:(float)time {
    switch (self.waveform) {
        case WaveformSine:
            return [self sine:time];
        case WaveformTriangle:
            return [self triangle:time];
        case WaveformSawtooth:
            return [self sawtooth:time];
        case WaveformSquare:
            return [self square:time];
        case WaveformWhiteNoise:
            return [self whiteNoise:time];
        default:
            NSAssert(NO, @"Not supported waveform");
            return 0;
    }
}

@end

@implementation OscillatorObjC (Private)

- (float)sine:(float)time {
    double frame = self.frequency * time;
    return self.amplitude * sin(frame * 2.0 * M_PI);
}

- (float)triangle:(float)time {
    return 0;
}

- (float)sawtooth:(float)time {
    return 0;
}

- (float)square:(float)time {
    return 0;
}

- (float)whiteNoise:(float)time {
    return 0;
}

@end
