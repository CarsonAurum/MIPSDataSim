//
//  DatapathComponent.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

public enum DatapathComponent: String, CaseIterable {
    case adder = "Adder",
         alu = "ALU",
         mux = "Mux",
         signExt = "Sign Ext"
}
