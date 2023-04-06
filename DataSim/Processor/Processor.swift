//
//  Processor.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import SwiftUI

class MIPSProcessor: ObservableObject {
    @Published var selectedElement: (UUID, DatapathComponent)?
    
    @Published var alus: [ALU] = [.init(), .init()]
    @Published var adders: [Adder] = .init()
    // @Published var signExtenders: [SignExtender]
    
}
