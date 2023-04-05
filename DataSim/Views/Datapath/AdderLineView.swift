//
//  ALUView.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import SwiftUI


struct AdderView: View {
    private let showLines: Bool
    private let color: Color
    private let secondaryColor: Color
    init(showLines: Bool = true,
         color: Color = .black,
         secondaryColor: Color = .gray) {
        self.showLines = showLines
        self.color = color
        self.secondaryColor = secondaryColor
    }
    var body: some View {
        if showLines {
            AdderLineView(color: color)
        } else {
            AdderCircleView(color: color)
        }
    }
}

// Should be square
struct AdderCircleView: View {
    private var color: Color
    private var secondaryColor: Color
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
                    .frame(width: proxy.size.width / 2, height: proxy.size.height)
                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                // Top left
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 4)
                    .position(x: proxy.size.width / 4, y: proxy.size.height / 5)
                // Bottom left
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 4)
                    .position(x: proxy.size.width / 4, y: proxy.size.height - proxy.size.height / 5)
                // Right middle
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 4)
                    .position(x: proxy.size.width - (proxy.size.width / 4), y: proxy.size.height / 2)
            }
        }
    }
}

// Should be square
struct AdderLineView: View {
    private var color: Color
    init(color: Color) {
        self.color = color
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ALUShape()
                    .fill(self.color)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 2, height: proxy.size.height)
                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
                // Top left
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8, y: proxy.size.height / 5)
                // Bottom left
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8, y: proxy.size.height - proxy.size.height / 5)
                // Right middle
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8), y: proxy.size.height / 2)
            }
        }
    }
}

struct AdderView_Previews: PreviewProvider {
    static var previews: some View {
        AdderView(showLines: false)
            .frame(width: 200, height: 200)
//            .border(.blue, width: 5)
    }
}
