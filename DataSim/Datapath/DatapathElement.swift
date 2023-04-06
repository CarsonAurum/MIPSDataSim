//
//  DatapathElement.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import Foundation

class DatapathElement: Hashable, Equatable, Identifiable {
    static func == (lhs: DatapathElement, rhs: DatapathElement) -> Bool {
        lhs.componentType == rhs.componentType
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(componentType.rawValue)
    }
    
    var id: UUID  = .init()
    var componentType: DatapathComponent
    init(_ componentType: DatapathComponent) {
        self.componentType = componentType
    }
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
