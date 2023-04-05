//
//  MuxView.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import SwiftUI

struct MuxView: View {
    private let hasLines: Bool
    private let color: Color
    private let secondaryColor: Color
    init(_ hasLines: Bool = true,
         color: Color = .black,
         secondaryColor: Color = .gray) {
        self.hasLines = hasLines
        self.color = color
        self.secondaryColor = secondaryColor
    }
    var body: some View {
        if hasLines {
            MuxLineView(color: self.color)
        } else {
            MuxCircleView(color: self.color, secondaryColor: self.secondaryColor)
        }
    }
}

struct MuxCircleView: View {
    private let color: Color
    private let secondaryColor: Color
    init(color: Color = .black, secondaryColor: Color = .gray) {
        self.color = color
        self.secondaryColor = secondaryColor
    }
    var body: some View {
        GeometryReader { geo in
            GeometryReader { geo in
                Capsule(style: .continuous)
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: geo.size.width / 4)
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
                // Top left
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .position(x: geo.size.width / 4, y: geo.size.height / 4)
                // Bottom Left
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 2,
                           height: geo.size.height / 2)
                    .position(x: geo.size.width / 4,
                              y: geo.size.width - (geo.size.width / 4))
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: geo.size.width / 2, height: geo.size.height / 2)
                    .position(x: geo.size.width / 4 * 3, y: geo.size.height / 2)
            }
        }
    }
}

struct MuxLineView: View {
    private let color: Color
    init(color: Color = .black) {
        self.color = color
    }
    var body: some View {
        GeometryReader { geo in
            Capsule(style: .continuous)
                .fill(self.color)
                .allowsHitTesting(true)
                .frame(width: geo.size.width / 4)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            // Top left
            Rectangle()
                .fill(self.color)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 2, height: geo.size.height / 40)
                .position(x: geo.size.width / 4, y: geo.size.height / 4)
            // Bottom Left
            Rectangle()
                .fill(self.color)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 2,
                       height: geo.size.height / 40)
                .position(x: geo.size.width / 4,
                          y: geo.size.width - (geo.size.width / 4))
            Rectangle()
                .fill(self.color)
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 2, height: geo.size.height / 40)
                .position(x: geo.size.width / 4 * 3, y: geo.size.height / 2)
        }
    }
}

struct MuxView_Previews: PreviewProvider {
    static var previews: some View {
        MuxView(false)
            .frame(width: 200, height: 200)
//            .border(.blue, width: 1)
    }
}
