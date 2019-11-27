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
    double period = 1.0 / self.frequency;
    double currentTime = fmod(time, period);
    double value = currentTime / period;
    double result = 0;
    if (value < 0.25) {
        result = value * 4;
    } else if (value < 0.75) {
        result = 2.0 - (value * 4.0);
    } else {
        result = value * 4 - 4.0;
    }
    return self.amplitude * result;
}

- (float)sawtooth:(float)time {
    float period = 1.0 / self.frequency;
    float currentTime = fmod(time, period);
    return (currentTime / period * 2.0 - 1.0) * self.amplitude;
}

- (float)square:(float)time {
    double period = 1.0 / self.frequency;
    double currentTime = fmod(time, period);
    return ((currentTime / period) < 0.5) ? self.amplitude : -self.amplitude;
}

- (float)whiteNoise:(float)time {
    float random01 = (float)arc4random() / UINT32_MAX;
    return self.amplitude * (random01 - 0.5) * 2;
}

@end
