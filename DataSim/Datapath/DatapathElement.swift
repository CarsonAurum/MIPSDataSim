//
//  DatapathElement.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import Foundation

protocol DatapathElement {
    var componentType: DatapathComponent { get }
    var fullName: String { get }
}

extension DatapathElement {
    var shortName: String { self.componentType.rawValue }
}
