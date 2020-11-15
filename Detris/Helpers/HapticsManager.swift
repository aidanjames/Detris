//
//  HapticsManager.swift
//  Detris
//
//  Created by Aidan Pendlebury on 15/11/2020.
//

import CoreHaptics
import UIKit

class HapticsManager {
    static let shared = HapticsManager()
    var engine: CHHapticEngine? = nil
    
    private init() {
        prepareHaptics()
    }
    
 
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func playHaptic(withIntensity intensity: Float = 0.5, andSharpness sharpness: Float = 1) {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        events.append(event)
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    func addToBlockPileHaptic() {
        
    }
    
    func lineCompletedHaptic() {
        
    }
    
    func tetrisHaptic() {
        
    }
}
