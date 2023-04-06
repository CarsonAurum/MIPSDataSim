//
//  WorkbenchView.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

import SwiftUI
import NovaCore

struct WorkbenchView: View {
    
    @Environment(\.dismiss) private var dismissal
    @Environment(\.verticalSizeClass) private var vClass
    
    @EnvironmentObject private var processor: MIPSProcessor
    
    @State private var isPaused: Bool = false
    @State private var scale: Double = 1.0
    @State private var lastScale: Double = 1.0
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    ScrollView([.horizontal, .vertical],
                               showsIndicators: false) {
                        ALUView(processor.alus[0])
                            .frame(width: 200, height: 200)
                            .position(x: 600, y: 600)
                        ALUView(processor.alus[1])
                            .frame(width: 200, height: 200)
                            .position(x: 300, y: 300)
                    }
                    Divider()
                    ScrollView([.horizontal], showsIndicators: false) {
                        HStack {
                            ForEach(DatapathComponent.allCases,
                                    id: \.self) { comp in
                                VStack {
                                    DatapathElementPreviewView(comp)
                                        .aspectRatio(contentMode: .fit)
                                    Text(comp.rawValue)
                                        .font(.caption)
                                }
                            }
                            Divider()
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 5.0)
                    .frame(maxHeight: (vClass == .compact) ?
                           geo.size.height / 5 : geo.size.height / 10)
                }
                Button (action: {
                    // isPaused.toggle()
                   // dismissal()
                    print(processor.alus.first!.outputA.1!.rawValue)
                }) {
                    Image(systemName: "pause.fill")
                        .foregroundColor(isPaused ? .gray : .blue)
                }
                .position(
                    x: geo.size.height / 30,
                    y: geo.size.width / 30
                )
            }
        }
    }
}

struct Workbench_Previews: PreviewProvider {
    @State static var testProcessor: MIPSProcessor = .init()
    static var previews: some View {
        WorkbenchView()
            .environmentObject(testProcessor)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
