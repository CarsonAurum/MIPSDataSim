//
//  Instruction.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import Foundation

protocol MIPSInstruction {
    var name: String { get }
    var exampleUsage: String { get }
    var alu: ALU { get }
    var pc: ProgramCounter { get }
    var adder: [Adder]? { get }
    var signExt: [SignExtender]? { get }
}

struct Instruction {
    // Instruction Identification
    let type: MIPSType
}

extension Instruction {
    enum MIPSType {
        case iFormat
        case rFormat
        case jFormat
    }
}
