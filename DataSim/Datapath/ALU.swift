//
//  ALU.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import Foundation

class ALU: DatapathElement, ObservableObject {
    func getSelection() -> (UUID, DatapathComponent, DatapathComponent.Connection)? {
        guard let selectedConnection = selectedConnection else { return nil }
        switch selectedConnection {
        case .inA:  return inputA
        case .inB:  return inputB
        case .outA: return outputA
        case .outB: return outputB
        default:    return nil
        }
    }
    
    func setSelection(_ sel: (UUID, DatapathComponent, DatapathComponent.Connection)?) {
        guard let selectedConnection = selectedConnection, let sel = sel else { return }
        switch selectedConnection {
        case .inA:
            inputA = sel
        case .inB:
            inputB = sel
        case .outA:
            outputA = sel
        case .outB:
            outputB = sel
        default: return
        }
    }
    
    static func == (lhs: ALU, rhs: ALU) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID = .init()
    let componentType: DatapathComponent = .alu
    
    @Published var inputA: (UUID, DatapathComponent, DatapathComponent.Connection)? = nil
    @Published var inputB: (UUID, DatapathComponent, DatapathComponent.Connection)? = nil
    @Published var outputA: (UUID, DatapathComponent, DatapathComponent.Connection)? = nil
    @Published var outputB: (UUID, DatapathComponent, DatapathComponent.Connection)? = nil
    @Published var selectedConnection: DatapathComponent.Connection? = nil
}
