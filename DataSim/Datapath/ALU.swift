//
//  ALU.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import Foundation

class ALU: DatapathElement, Identifiable, ObservableObject {
    var id: UUID = .init()
    var componentType: DatapathComponent { .alu }
    var fullName: String { "Arithmetic Logic Unit" }
    
    @Published var inputA: DatapathComponent? = nil
    @Published var inputB: DatapathComponent? = nil
    @Published var outputA: DatapathComponent? = nil
    @Published var outputB: DatapathComponent? = nil
    @Published var selectedConnection: ALUConnection? = nil
}

extension ALU {
    enum ALUConnection {
        case inA, inB, outA, outB
    }
}
