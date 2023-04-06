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
                        ForEach(processor.datapathElements) { elem in
                            DatapathElementView(obj: elem)
                                .frame(minWidth: geo.size.width / 15, minHeight: geo.size.width / 15)
                        }
                    }
                    Divider()
                    ScrollView([.horizontal], showsIndicators: false) {
                        HStack {
                            ForEach(DatapathComponent.allCases,
                                    id: \.self) { comp in
                                VStack {
                                    DatapathElementView(comp)
                                        .aspectRatio(contentMode: .fit)
                                        .onTapGesture {
                                            switch comp {
                                            case .alu:
                                                processor.datapathElements += ALU()
                                            default:
                                                return
                                            }
                                        }
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
                    isPaused.toggle()
                    dismissal()
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
