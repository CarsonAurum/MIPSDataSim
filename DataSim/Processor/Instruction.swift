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
    var alu: ALU {
        var ret = ALU()
        
        ret.outputA = (nil, .mux)
        ret.inputA = (nil, .pc)
        
        return ret
    }
    
    /*
    var mux: Mux {
        ret.inputB = (nil, .alu)
    }
    
    var adder1: Adder {
        
    }
    
    var adder2: Adder {
        
    }
     */
}

extension Instruction {
    enum MIPSType {
        case iFormat
        case rFormat
        case jFormat
    }
}
