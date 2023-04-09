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
    
    
    struct Datapath {
        var srcID: UUID
        var srcType: DatapathComponent
        
        var destID: UUID
    }
}
