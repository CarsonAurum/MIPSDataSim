//
//  MIPSProcessor.swift
//  DataSim
//
//  Created by Carson Rau on 4/8/23.
//

import Foundation

class MIPSProcessor: ObservableObject {
    @Published var alus: [ALU] = []
    @Published var adders: [Adder] = []
    @Published var pc: ProgramCounter? = nil
    @Published var signExtenders: [SignExtender] = []
    
    
    struct Datapath {
        var srcID: UUID
        var srcType: DatapathComponent
        
        var destID: UUID
    }
    
    func reset() {
        alus.removeAll()
        adders.removeAll()
        pc = nil
        signExtenders.removeAll()
    }
}
