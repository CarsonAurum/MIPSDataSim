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
    private let color: Color
    private let secondaryColor: Color
    
    var shakeAnimation: Animation {
        Animation
            .easeInOut
            .repeatCount(4, autoreverses: true)
    }
    
    @State private var offset: CGFloat = 0.0
    @StateObject private var obj: ALU
    @EnvironmentObject private var processor: MIPSProcessor
    init(_ object: ALU,
         color: Color = .black,
         secondaryColor: Color = .gray
    ) {
        self._obj = StateObject(wrappedValue: object)
        self.color = color
        self.secondaryColor = secondaryColor
    }
    
    var hitCircles: some View {
        GeometryReader { geo in
            ZStack {
                // Top left
                Circle()
                    .fill(.white)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width / 4,
                              y: geo.size.height / 5)
                    .onTapGesture {
                        guard processor.selectedElement == nil else {
                            // TODO: Complete the connection
                            switch processor.selectedElement!.1 {
                            case .alu:
                                obj.inputA = (processor.selectedElement!.0, .alu)
                            default:
                                return
                            }
                            processor.selectedElement = nil
                            return
                        }
                        if obj.selectedConnection != .inA {
                            obj.selectedConnection = .inA
                            processor.selectedElement = (obj.id, obj.componentType)
                        } else {
                            obj.selectedConnection = nil
                        }
                    }
                // Bottom left
                Circle()
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width / 4,
                              y: geo.size.height - geo.size.height / 5)
                    .onTapGesture {
                        guard processor.selectedElement == nil else {
                            // TODO: Complete the connection
                            switch processor.selectedElement!.1 {
                            case .alu:
                                obj.inputB = (processor.selectedElement!.0, .alu)
                            default:
                                return
                            }
                            processor.selectedElement = nil
                            return
                        }
                        if obj.selectedConnection != .inB {
                            obj.selectedConnection = .inB
                            processor.selectedElement = (obj.id, obj.componentType)
                        } else {
                            obj.selectedConnection = nil
                        }
                    }
                // Top right
                Circle()
                    .opacity(0.1)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width - (geo.size.width / 4),
                              y: (geo.size.height / 8) * 3)
                    .onTapGesture {
                        guard processor.selectedElement == nil else {
                            // TODO: Complete the connection
                            switch processor.selectedElement!.1 {
                            case .alu:
                                obj.outputA = (processor.selectedElement!.0, .alu)
                            default:
                                return
                            }
                            processor.selectedElement = nil
                            return
                        }
                        if obj.selectedConnection != .outA {
                            obj.selectedConnection = .outA
                            processor.selectedElement = (obj.id, obj.componentType)
                        } else {
                            obj.selectedConnection = nil
                        }
                    }

                // Bottom right
                Circle()
                    .opacity(0.1)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 4)
                    .position(x: geo.size.width - (geo.size.width / 4),
                              y: (geo.size.height / 8) * 5)
                    .onTapGesture {
                        guard processor.selectedElement == nil else {
                            withAnimation(shakeAnimation) {
                                
                            }
                            return
                        }
                        if obj.selectedConnection != .outB {
                            obj.selectedConnection = .outB
                            processor.selectedElement = (obj.id, obj.componentType)
                        } else {
                            obj.selectedConnection = nil
                        }
                    }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                hitCircles
                ALUShape()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 2,
                           height: geo.size.height)
                    .position(x: geo.size.width / 2,
                              y: geo.size.height / 2)
                // Visual wires within the bounds of this view
                // Top left
                Rectangle()
                    .fill(self.color)
                    .opacity((obj.inputA.1 != nil || obj.selectedConnection == .inA) ? 100 : 0)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 40)
                    .position(x: geo.size.width / 8,
                              y: geo.size.height / 5)
                // Bottom left
                Rectangle()
                    .fill(self.color)
                    .opacity((obj.inputB.1 != nil || obj.selectedConnection == .inB) ? 100 : 0)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 40)
                    .position(x: geo.size.width / 8,
                              y: geo.size.height - geo.size.height / 5)
                // Top right
                Rectangle()
                    .fill(self.color)
                    .opacity((obj.outputA.1 != nil || obj.selectedConnection == .outA) ? 100 : 0)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 40)
                    .position(x: geo.size.width - (geo.size.width / 8),
                              y: (geo.size.height / 8) * 3)
                // Bottom right
                Rectangle()
                    .fill(self.color)
                    .opacity((obj.outputB.1 != nil || obj.selectedConnection == .outB) ? 100 : 0)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 4,
                           height: geo.size.height / 40)
                    .position(x: geo.size.width - (geo.size.width / 8),
                              y: (geo.size.height / 8) * 5)
                // Hit testing circles for connections
            }
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
    
    private let color: Color
    
    init(color: Color = .black) {
        self.color = color
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ALUShape()
                    .fill(self.color)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 2,
                           height: proxy.size.height)
                    .position(x: proxy.size.width / 2,
                              y: proxy.size.height / 2)
                // Top left
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8,
                              y: proxy.size.height / 5)
                // Bottom left
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8,
                              y: proxy.size.height - proxy.size.height / 5)
                // Top right
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4,
                           height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8),
                              y: (proxy.size.height / 8) * 3)
                // Bottom right
                Rectangle()
                    .fill(self.color)
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
