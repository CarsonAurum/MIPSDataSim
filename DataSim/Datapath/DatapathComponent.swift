//
//  DatapathComponent.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

public enum DatapathComponent: String, CaseIterable, Equatable, Hashable {
    case adder      = "Adder",
         alu        = "ALU",
         mux        = "Mux",
         signExt    = "Sign Ext"
}

public enum LogicComponent: String, CaseIterable {
    case and        = "AND"
    case or         = "OR"
    case not        = "NOT"
    case nand       = "NAND"
    case xor        = "XOR"
}
