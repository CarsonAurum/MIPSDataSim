//
//  GameManager.swift
//  DataSim
//
//  Created by Carson Rau on 4/26/23.
//

import SwiftUI
import Combine
import NovaCore

class GameManager: ObservableObject {
    @Published public var isPaused: Bool = false
    @Published public var timeRemaining: TimeInterval = 15 * 60
    @Published public var currentInstruction: Instruction
    
    private var instructions: [Instruction] = []
    
    public init() {
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            var arr = NSArray(contentsOfFile: path) as! [Dictionary<String,Any>]
            for dict in arr {
                instructions += .init(dict)
            }
        }
        currentInstruction = instructions.randomElement()!
    }
    
    func reset(_ ti: TimeInterval) {
        isPaused = false
        self.timeRemaining = ti
    }
    
    func grade() {
        isPaused = true
        
    }
}
