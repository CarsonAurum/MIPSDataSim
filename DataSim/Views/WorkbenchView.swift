//
//  WorkbenchView.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

import SwiftUI
import NovaCore

struct WorkbenchView: View {
    /// An environment variable to enable escaping from this view.
    @Environment(\.dismiss) private var dismissal
    /// The vertical size class (determining iPad from iPhone) for certain space-sensitive geometries.
    @Environment(\.verticalSizeClass) private var vClass
    /// The environment-wide processor.
    @EnvironmentObject var proc: MIPSProcessor
    @EnvironmentObject var manager: GameManager
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    /// Which element is currently selected within the workbench.
    ///
    /// - Note: Due to the way the @State wrapper works with tuples, the updates will only occur when
    /// changing this tuple as a whole from nil to a value or vice versa. Updating individual components will
    /// not cause changes in the UI.
    @State private var selectedElement: (UUID, DatapathComponent, DatapathComponent.Connection)? = nil
    
    
    // TODO: - Scaling & Panning
    
    var topBar: some View {
        GeometryReader { geo in
            HStack {
                Button {
                    manager.isPaused.toggle()
                    dismissal()
                } label: {
                    Image(systemName: "pause.fill")
                        .foregroundColor(.primary)
                }
                .position(
                    x: geo.size.height / 30,
                    y: geo.size.width / 30
                )
                Spacer()
                Text("Time Remaining: \(formattedTime(manager.timeRemaining))")
                    .font(.customSubtitle)
                    .onReceive(timer) { _ in
                        if !manager.isPaused && manager.timeRemaining > 0 {
                            manager.timeRemaining -= 1
                        } else {
                            timer.upstream.connect().cancel()
                        }
                    }
            }
        }
    }
    
    /// The horizontal pane containing the datapath units available for use on the workbench.
    var selectionPane: some View {
        HStack {
            ForEach(DatapathComponent.allCases,
                    id: \.self) { comp in
                VStack {
                    DatapathElementPreviewView(comp)
                    // Add a new instance of the proper datapath unit on tap.
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
                        .font(.customSubtitle)
                }
            }
            Divider()
            // TODO: Logical units after the Divider.
            Spacer()
        }
    }
    
    /// The collection of ALUs visible on the workbench.
    var alus: some View {
        GeometryReader { geo in
            ForEach($proc.alus, id: \.self) { $alu in
                let frame: CGRect = geo.frame(in: .named("workbench.scroll"))
                ALUView(obj: $alu, curSelection: $selectedElement)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                // TODO: A better way for random positioning.
                    .position(x: 30,
                              y: 30)
                            .onLongPressGesture {
                                print("\(frame.minX)...\(frame.maxX)")
                            }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                topBar
                    .frame(height: (vClass == .compact) ? geo.size.height / 10 : geo.size.height / 20)
                    .padding()
                ScrollView([.horizontal, .vertical],
                           showsIndicators: false) {
                    alus
                    //                        ForEach($adders) { obj in
                    //                            AdderView(obj: obj, selectedElement: $selectedElement)
                    //                                .frame(width: 75, height: 75)
                    //                                .position(x: CGFloat((50...500).randomElement()!),
                    //                                          y: CGFloat((50...500).randomElement()!))
                    //                        }
                }
                           .coordinateSpace(name: "workbench.scroll")
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
    
    func formattedTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
