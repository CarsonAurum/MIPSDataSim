//
//  Instruction.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import Foundation

struct Instruction {
    // Instruction Identification
    let type: MIPSType
    let name: String
    let exampleUsage: String
    // Datapath Components
}


extension Instruction {
    enum MIPSType {
        case iFormat
        case rFormat
        case jFormat
    }
}
