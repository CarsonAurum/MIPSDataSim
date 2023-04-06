//
//  DatapathElementView.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import SwiftUI

struct DatapathElementView: View {
    private let componentType: DatapathComponent
    init(_ componentType: DatapathComponent) {
        self.componentType = componentType
    }
    var body: some View {
        switch componentType {
        case .adder:
            AdderView()
        case .alu:
            ALUView()
        case .mux:
            MuxView()
        case .signExt:
            SignExtenderView()
        }
    }
}

struct DatapathElementView_Previews: PreviewProvider {
    static var previews: some View {
        DatapathElementView(.alu)
            .frame(width: 200, height: 200)
    }
}
