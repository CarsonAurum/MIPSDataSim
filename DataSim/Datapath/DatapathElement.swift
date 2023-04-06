//
//  DatapathElement.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import Foundation

public enum DatapathComponent: String, CaseIterable, Equatable, Hashable {
    case adder      = "Adder",
         alu        = "ALU",
         mux        = "Mux",
         signExt    = "Sign Ext"
    // Logic Units
    
}

protocol DatapathElement: Hashable, Equatable, Identifiable {
    var id: UUID { get }
    var componentType: DatapathComponent { get }
}

extension DatapathElement {
    var shortName: String { self.componentType.rawValue }
    var fullName: String {
        switch componentType {
        case .adder:
            return "Adder"
        case .alu:
            return "Arithmetic Logic Unit"
        case .mux:
            return "Multiplexor"
        case .signExt:
            return "Sign Extension Unit"
        }
    }
}
