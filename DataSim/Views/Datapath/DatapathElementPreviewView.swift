//
//  DatapathElementPreviewView.swift
//  DataSim
//
//  Created by Carson Rau on 4/6/23.
//

import SwiftUI

struct DatapathElementPreviewView: View {
    private let component: DatapathComponent
    init(_ component: DatapathComponent) {
        self.component = component
    }
    var body: some View {
        switch component {
        case .adder:
            AdderView()
        case .alu:
            ALULineView()
        case .mux:
            MuxLineView()
        case .signExt:
            SignExtenderLineView()
        case .pc:
            EmptyView()
        }
    }
}

struct DatapathElementPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        DatapathElementPreviewView(.alu)
            .frame(width: 200, height: 200)
    }
}
