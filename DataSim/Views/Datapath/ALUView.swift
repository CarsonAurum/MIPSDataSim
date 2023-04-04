//
//  ALUView.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import SwiftUI

struct ALUView: View {
    private let hasLines: Bool
    private let color: Color
    private let secondaryColor: Color
    init(_ hasLines: Bool = true,
         color: Color = .black,
         secondaryColor: Color = .black
    ) {
        self.hasLines = hasLines
        self.color = color
        self.secondaryColor = secondaryColor
    }
    var body: some View {
        if hasLines {
            ALULineView(color: color)
        } else {
            ALUCircleView(color: color, secondaryColor: secondaryColor)
        }
    }
}

// Should be square
struct ALUCircleView: View {
    
    private let color: Color
    private let secondaryColor: Color
    
    init(color: Color = .black, secondaryColor: Color = .black) {
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
                // Top right
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 4)
                    .position(x: proxy.size.width - (proxy.size.width / 4), y: (proxy.size.height / 8) * 3)
                // Bottom right
                Circle()
                    .fill(self.secondaryColor)
                    .allowsHitTesting(true)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 4)
                    .position(x: proxy.size.width - (proxy.size.width / 4), y: (proxy.size.height / 8) * 5)
            }
        }
    }
}

// Should be square
struct ALULineView: View {
    
    private let color: Color
    
    init(color: Color = .black) {
        self.color = color
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
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
                // Top right
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8), y: (proxy.size.height / 8) * 3)
                // Bottom right
                Rectangle()
                    .fill(self.color)
                    .allowsHitTesting(false)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8), y: (proxy.size.height / 8) * 5)
                ALUShape()
                    .fill(self.color)
                    .frame(width: proxy.size.width / 2, height: proxy.size.height)
                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
        }
    }
}

struct ALUView_Previews: PreviewProvider {
    static var previews: some View {
        ALUView(false,
                color: .init(.lightGray),
                secondaryColor: .init(.gray)
        )
            .frame(width: 200, height: 200)
//            .border(.blue, width: 5)
    }
}
