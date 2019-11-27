//
//  SynthObjC.m
//  Swift Synth
//
//  Created by Alexey Naumov on 27.11.2019.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

#import "SynthObjC.h"
#import <AVFoundation/AVFoundation.h>

@interface SynthObjC ()

@property (nonatomic, strong) AVAudioEngine *audioEngine;
@property (nonatomic, strong) AVAudioSourceNode *sourceNode;
@property (nonatomic, assign) float time;
@property (nonatomic, assign) double sampleRate;
@property (nonatomic, assign) float deltaTime;

@end

@implementation SynthObjC

- (instancetype)initWithOscillator:(OscillatorObjC *)oscillator {
    if (self = [super init]) {
        self.audioEngine = [AVAudioEngine new];
        AVAudioMixerNode *mainMixer = self.audioEngine.mainMixerNode;
        AVAudioOutputNode *outputNode = self.audioEngine.outputNode;
        AVAudioFormat *format = [outputNode inputFormatForBus: 0];
        self.sampleRate = format.sampleRate;
        self.deltaTime = 1.0 / (float)self.sampleRate;
        
        self.oscillator = oscillator;
        
        AVAudioFormat *inputFormat = [[AVAudioFormat alloc] initWithCommonFormat: format.commonFormat
                                                                      sampleRate: self.sampleRate
                                                                        channels: 1
                                                                     interleaved: format.isInterleaved];
        [self.audioEngine attachNode: self.sourceNode];
        [self.audioEngine connect: self.sourceNode to: mainMixer format: inputFormat];
        [self.audioEngine connect: mainMixer to: outputNode format: nil];
        mainMixer.outputVolume = 0;
        NSError *error;
        if (![self.audioEngine startAndReturnError:&error]) {
            NSLog(@"Could not start audioEngine: %@", error.localizedDescription);
        }
    }
    return self;
}

@end
