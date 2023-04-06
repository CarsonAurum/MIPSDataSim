//
//  Adder.swift
//  DataSim
//
//  Created by Carson Rau on 4/6/23.
//

import Foundation

class Adder: DatapathElement, ObservableObject {
    
    static func == (lhs: Adder, rhs: Adder) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID = .init()
    
    let componentType: DatapathComponent = .adder
    
    @Published var inputA: DatapathComponent? = nil
    @Published var inputB: DatapathComponent? = nil
    @Published var outputA: DatapathComponent? = nil
    @Published var selectedConnection: AdderConnection? = nil
}

extension Adder {
    enum AdderConnection {
        case inA, inB, outA
    }
}
