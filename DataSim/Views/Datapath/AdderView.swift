//
//  ALUView.swift
//  DataSim
//
//  Created by Carson Rau on 3/22/23.
//

import SwiftUI

// Should be square
struct AdderView: View {
    private var color: Color
    init(color: Color) {
        self.color = color
    }
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // Top left
                Rectangle()
                    .fill(self.color)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8, y: proxy.size.height / 5)
                // Bottom left
                Rectangle()
                    .fill(self.color)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width / 8, y: proxy.size.height - proxy.size.height / 5)
                // Right middle
                Rectangle()
                    .fill(self.color)
                    .frame(width: proxy.size.width / 4, height: proxy.size.height / 40)
                    .position(x: proxy.size.width - (proxy.size.width / 8), y: proxy.size.height / 2)
                ALUShape()
                    .fill(self.color)
                    .frame(width: proxy.size.width / 2, height: proxy.size.height)
                    .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
            }
        }
    }
}

struct AdderView_Previews: PreviewProvider {
    static var previews: some View {
        AdderView(color: .green)
            .frame(width: 200, height: 200)
//            .border(.blue, width: 5)
    }
}
