//
//  Oscillator.swift
//  Oscillator
//
//  Created by Alexey Naumov on 27.11.2019.
//  Copyright © 2019 Grant Emerson. All rights reserved.
//

import XCTest
@testable import Swift_Synth

class OscillatorTests: XCTestCase {
    
    func testSine() {
        let sut = OscillatorObjC(waveform: .sine)
        let sample = Oscillator.sine
        verify(sut: sut, sample: sample)
    }
    
    func verify(sut: OscillatorObjC, sample: Signal, file: StaticString = #file, line: UInt = #line) {
        for time in stride(from: Float(0), to: 1, by: 0.005) {
            XCTAssertEqual(sut.value(forTime: time), sample(time), accuracy: 0.001, file: file, line: line)
        }
    }
}
