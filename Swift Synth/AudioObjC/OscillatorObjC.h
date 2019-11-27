//
//  OscillatorObjC.h
//  Swift Synth
//
//  Created by Alexey Naumov on 27.11.2019.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Waveform) {
    WaveformSine,
    WaveformTriangle,
    WaveformSawtooth,
    WaveformSquare,
    WaveformWhiteNoise
};

NS_ASSUME_NONNULL_BEGIN

@interface OscillatorObjC : NSObject

@property (nonatomic, assign) float amplitude;
@property (nonatomic, assign) float frequency;

- (instancetype)initWithWaveform:(Waveform)waveform;

- (float)valueForTime:(float)time;

@end

NS_ASSUME_NONNULL_END
