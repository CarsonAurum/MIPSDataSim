//
//  MIPSProcessor.swift
//  DataSim
//
//  Created by Carson Rau on 4/8/23.
//

import Foundation

class MIPSProcessor: ObservableObject {
    @Published var alu: ALU? = nil
    @Published var adders: [Adder] = []
    @Published var pc: ProgramCounter? = nil
    @Published var signExtenders: [SignExtender] = []
    @Published var muxes: [Multiplexor] = []
    @Published var regFile: RegisterFile? = nil
    // @Published var instructionMem: InstructionMemory? = nil
    // @Published var dataMem: DataMemory? = nil
    // @Published var shifters: [Shifter] = []
    
    public init() {
        var nsDictionary: NSDictionary?
         if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
             print(nsDictionary)
         }
    }
    
    
    
    func reset() {
        alus.removeAll()
        adders.removeAll()
        pc = nil
        signExtenders.removeAll()
        muxes.removeAll()
        regFile = nil
    }
}
