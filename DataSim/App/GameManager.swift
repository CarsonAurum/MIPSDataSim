//
//  GameManager.swift
//  DataSim
//
//  Created by Carson Rau on 4/26/23.
//

import SwiftUI
import Combine

class GameManager: ObservableObject {
    @Published public var isPaused: Bool = false
    @Published public var timeRemaining: TimeInterval = 15 * 60
}
