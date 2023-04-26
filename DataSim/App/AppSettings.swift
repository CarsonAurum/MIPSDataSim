//
//  AppSettings.swift
//  DataSim
//
//  Created by Carson Rau on 4/25/23.
//

import SwiftUI
import Combine

class AppSettings: ObservableObject {
    @Published public var primaryColor: Color = .black
    @Published public var enableTimer: Bool = true
    @Published public var enableHardMode: Bool = false
    @Published public var difficulty: Difficulty = .easy
    
    
    enum Difficulty: String, CaseIterable, Identifiable {
        case turtle = "Turtle (20min)", easy = "Easy (15min)",
             medium = "Medium (10min)", hard = "Hard (5min)",
             lightning = "Lightning (2min)"
        var id: Self { self }
    }
    
    func getTimeRemaining() -> TimeInterval {
        switch difficulty {
        case .turtle: return 20 * 60
        case .easy: return 15 * 60
        case .medium: return 10 * 60
        case .hard: return 5 * 60
        case .lightning: return 2 * 60
        }
    }
}
