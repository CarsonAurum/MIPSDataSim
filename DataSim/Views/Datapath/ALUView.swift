//
//  ALUView.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import SwiftUI

/// An ALU shape with two output wires. This shape can be altered between a view with untappable lines, or a
/// view with a tappable circles.
struct ALUView: View {
    @State private var offset: CGFloat = 0.0
    @State private var shaking: Bool = false
    
    @Binding private var obj: ALU
    
    @Binding var curSelection: (UUID, DatapathComponent, DatapathComponent.Connection)?
    
    @EnvironmentObject private var proc: MIPSProcessor
    
    init(obj: Binding<ALU>,
         curSelection: Binding<(UUID, DatapathComponent, DatapathComponent.Connection)?>
    ) {
        _obj = obj
        _curSelection = curSelection
    }
    
    var hitCircles: some View {
        GeometryReader { geo in
            ZStack {
                // Top left
                Circle()
                    .fill(.background)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width / 4,
                              y: geo.size.height / 5)
                    .onTapGesture {
                        guard let curSelection =  curSelection else {
                            shaking.toggle()
                            return
                        }
                        switch curSelection.1 {
                        case .alu:
                            obj.selectedConnection = .inA
                            let src = proc.alus.first { $0.id == curSelection.0 }!
                            src.setSelection((obj.id, .alu, .inA))
                            obj.setSelection((src.id, .alu, src.selectedConnection!))
                            self.curSelection = nil
                        default:
                            return
                        }
                    }
                // Bottom left
                Circle()
                    .fill(.background)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width / 4,
                              y: geo.size.height - geo.size.height / 5)
                    .onTapGesture {
                        guard let curSelection = curSelection else {
                            shaking.toggle()
                            return
                        }
                        switch curSelection.1 {
                        case .alu:
                            obj.selectedConnection = .inB
                            let src = proc.alus.first { $0.id == curSelection.0 }!
                            src.setSelection((obj.id, .alu, .inB))
                            obj.setSelection((src.id, .alu, src.selectedConnection!))
                            self.curSelection = nil
                        default:
                            return
                        }
                        
                    }
                // Top right
                Circle()
                    .fill(.background)
                    .opacity(0.1)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width - (geo.size.width / 4),
                              y: (geo.size.height / 8) * 3)
                    .onTapGesture {
                        guard curSelection == nil else {
                            if curSelection!.0 == obj.id && curSelection!.1 == .alu && curSelection!.2 == .outA {
                                curSelection = nil
                                obj.selectedConnection = nil
                                return
                            }
                            shaking.toggle()
                            return
                        }
                        obj.selectedConnection = .outA
                        curSelection = (obj.id, .alu, .outA)
                        
                    }

                // Bottom right
                Circle()
                    .fill(.background)
                    .opacity(0.1)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width - (geo.size.width / 4),
                              y: (geo.size.height / 8) * 5)
                    .onTapGesture {
                        guard curSelection == nil else {
                            if curSelection!.0 == obj.id && curSelection!.1 == .alu && curSelection!.2 == .outB {
                                curSelection = nil
                                obj.selectedConnection = nil
                                return
                            }
                            shaking.toggle()
                            return
                        }
                        obj.selectedConnection = .outB
                        curSelection = (obj.id, .alu, .outB)
                    }
            }
        }
    }
    
    var wires: some View {
        GeometryReader { geo in
            // Visual wires within the bounds of this view
            // Top left
            Rectangle()
                .fill(.foreground)
                .opacity((obj.inputA != nil || obj.selectedConnection == .inA) ? 100 : 0)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 4,
                       height: geo.size.height / 40)
                .position(x: geo.size.width / 8,
                          y: geo.size.height / 5)
            // Bottom left
            Rectangle()
                .fill(.foreground)
                .opacity((obj.inputB != nil || obj.selectedConnection == .inB) ? 100 : 0)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 4,
                       height: geo.size.height / 40)
                .position(x: geo.size.width / 8,
                          y: geo.size.height - geo.size.height / 5)
            // Top right
            Rectangle()
                .fill(.foreground)
                .opacity((obj.outputA != nil || obj.selectedConnection == .outA) ? 100 : 0)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 4,
                       height: geo.size.height / 40)
                .position(x: geo.size.width - (geo.size.width / 8),
                          y: (geo.size.height / 8) * 3)
            // Bottom right
            Rectangle()
                .fill(.foreground)
                .opacity((obj.outputB != nil || obj.selectedConnection == .outB) ? 100 : 0)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 4,
                       height: geo.size.height / 40)
                .position(x: geo.size.width - (geo.size.width / 8),
                          y: (geo.size.height / 8) * 5)
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                hitCircles
                ALUShape()
                    .fill(.foreground)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 2,
                           height: geo.size.height)
                    .position(x: geo.size.width / 2,
                              y: geo.size.height / 2)
                wires
                // Hit testing circles for connections
            }
            .modifier(ShakeEffect(animatableData: .init(self.shaking ? 1 : 0)))
            .animation(Animation.linear(duration: 0.3), value: shaking)
            .offset(x: offset)
        }
    }
}

/// An ALU shape where the body of the logic unit is not tappable and each of the four circles is selectable.
/// - Description: This view is important to provide the functionality for individual wires to be configured
///   within the program.
/// - Note: Should be square
struct ALUCircleView: View {
    
    private let color: Color
    private let secondaryColor: Color
    
    init(color: Color = .black, secondaryColor: Color = .gray) {
        self.color = color
        self.secondaryColor = secondaryColor
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ALUShape()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 2,
                           height: proxy.size.height)
                    .position(x: proxy.size.width / 2,
                              y: proxy.size.height / 2)
                // Top left
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 4)
                    .position(x: proxy.size.width / 4,
                              y: proxy.size.height / 5)
                // Bottom left
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 4)
                    .position(x: proxy.size.width / 4,
                              y: proxy.size.height - proxy.size.height / 5)
                // Top right
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 4)
                    .position(x: proxy.size.width - (proxy.size.width / 4),
                              y: (proxy.size.height / 8) * 3)
                // Bottom right
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 4)
                    .position(x: proxy.size.width - (proxy.size.width / 4),
                              y: (proxy.size.height / 8) * 5)
            }
        }
    }
}

/// - Note: Should be square
struct ALULineView: View {
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ALUShape()
                    .fill(.foreground)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 2,
                           height: proxy.size.height)
                    .position(x: proxy.size.width / 2,
                              y: proxy.size.height / 2)
                // Top left
                Rectangle()
                    .fill(.foreground)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8,
                              y: proxy.size.height / 5)
                // Bottom left
                Rectangle()
                    .fill(.foreground)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8,
                              y: proxy.size.height - proxy.size.height / 5)
                // Top right
                Rectangle()
                    .fill(.foreground)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8),
                              y: (proxy.size.height / 8) * 3)
                // Bottom right
                Rectangle()
                    .fill(.foreground)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8),
                              y: (proxy.size.height / 8) * 5)
            }
        }
    }
}

/*
struct ALUView_Previews: PreviewProvider {
static var previews: some View {
ALUView()
.frame(width: 200, height: 200)
//            .border(.blue, width: 5)
}
}
*/
