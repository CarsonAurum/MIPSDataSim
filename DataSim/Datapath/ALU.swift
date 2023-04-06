//
//  ALU.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import Foundation

class ALU: DatapathElement, ObservableObject {
    static func == (lhs: ALU, rhs: ALU) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID = .init()
    let componentType: DatapathComponent = .alu
    
    @Published var inputA: (UUID?, DatapathComponent?) = (nil, nil)
    @Published var inputB: (UUID?, DatapathComponent?) = (nil, nil)
    @Published var outputA: (UUID?, DatapathComponent?) = (nil, nil)
    @Published var outputB: (UUID?, DatapathComponent?) = (nil, nil)
    @Published var selectedConnection: ALUConnection? = (nil)
}

extension ALU {
    enum ALUConnection {
        case inA, inB, outA, outB
    }
}
