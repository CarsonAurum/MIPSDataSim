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
    
    @EnvironmentObject var proc: MIPSProcessor
    
    @State private var isPaused: Bool = false
    @State private var selectedElement: (UUID, DatapathComponent, DatapathComponent.Connection)? = nil
    
    // TODO: - Scaling & Panning
    
    var selectionPane: some View {
        HStack {
            ForEach(DatapathComponent.allCases,
                    id: \.self) { comp in
                VStack {
                    DatapathElementPreviewView(comp)
                        .onTapGesture {
                            switch comp {
                            case .alu:
                                proc.alus.append(.init())
                            case .adder:
                                proc.adders.append(.init())
                            default:
                                return
                            }
                        }
                        .aspectRatio(contentMode: .fit)
                    Text(comp.rawValue)
                        .font(.caption)
                }
            }
            Divider()
            Spacer()
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    Button {
                        isPaused.toggle()
                        dismissal()
                    } label: {
                        Image(systemName: "pause.fill")
                            .foregroundColor(isPaused ? .gray : .blue)
                    }
                    .position(
                        x: geo.size.height / 30,
                        y: geo.size.width / 30
                    )
                    Spacer()
                    Text("Time Remaining: 1:00")
                }
                .frame(height: (vClass == .compact) ? geo.size.height / 10 : geo.size.height / 20)
                .padding()
                ScrollView([.horizontal, .vertical],
                           showsIndicators: false) {
                    ForEach($proc.alus, id: \.self) { $alu in
                        ALUView(obj: $alu,
                                curSelection: $selectedElement)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .position(x: CGFloat((50...500).randomElement()!),
                                      y: CGFloat((50...500).randomElement()!))
                    }
                    //                        ForEach($adders) { obj in
                    //                            AdderView(obj: obj, selectedElement: $selectedElement)
                    //                                .frame(width: 75, height: 75)
                    //                                .position(x: CGFloat((50...500).randomElement()!),
                    //                                          y: CGFloat((50...500).randomElement()!))
                    //                        }
                }
                           .onTapGesture {
                               if selectedElement != nil {
                                   switch selectedElement!.1 {
                                   case .alu:
                                       proc.alus.first {
                                           $0.id == selectedElement!.0
                                       }?.selectedConnection = nil
                                   default:
                                       return
                                   }
                                   selectedElement = nil
                               }
                           }
                Divider()
                ScrollView([.horizontal], showsIndicators: false) {
                    selectionPane
                }
                .padding(.horizontal, 5.0)
                .frame(maxHeight: (vClass == .compact) ?
                       geo.size.height / 5 : geo.size.height / 10)
            }
        }
    }
}

struct Workbench_Previews: PreviewProvider {
    @State static var testProc: MIPSProcessor = .init()
    static var previews: some View {
        WorkbenchView()
            .environmentObject(testProc)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
