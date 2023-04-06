//
//  SignExtenderView.swift
//  DataSim
//
//  Created by Carson Rau on 4/5/23.
//

import SwiftUI

struct SignExtenderView: View {
    private let showLines: Bool
    init(showLines: Bool = true) {
        self.showLines = showLines
    }
    var body: some View {
        if showLines {
            SignExtenderLineView()
        } else {
            SignExtenderCircleView()
        }
    }
}

struct SignExtenderCircleView: View {
    var body: some View {
        GeometryReader { geo in
            Ellipse()
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 5 * 3, height: geo.size.height)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            // Left
            Circle()
                .fill(.blue)
                .allowsHitTesting(true)
                .frame(width: geo.size.width / 4, height: geo.size.height / 4)
                .position(x: geo.size.width - (geo.size.width / 5),
                          y: geo.size.height / 2)
            // Right
            Circle()
                .fill(.blue)
                .allowsHitTesting(true)
                .frame(width: geo.size.width / 4, height: geo.size.height / 4)
                .position(x: geo.size.width / 5, y: geo.size.height / 2)
        }
    }
}

struct SignExtenderLineView: View {
    var body: some View {
        GeometryReader { geo in
            Ellipse()
                .allowsHitTesting(true)
                .frame(width: geo.size.width / 5 * 3, height: geo.size.height)
                .position(x: geo.size.width / 2, y: geo.size.height / 2)
            // Left line
            Rectangle()
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 4, height: geo.size.height / 40)
                .position(x: geo.size.width - (geo.size.width / 8),
                          y: geo.size.height / 2)
            // Right line
            Rectangle()
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 4, height: geo.size.height / 40)
                .position(x: geo.size.width / 8, y: geo.size.height / 2)
            // Right diagonal line
            Rectangle()
                .rotation(.degrees(45))
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 6, height: geo.size.height / 40)
                .position(x: geo.size.width / 8, y: geo.size.height / 2)
            // Left diagonal line
            Rectangle()
                .rotation(.degrees(45))
                .allowsHitTesting(false)
                .frame(width: geo.size.width / 6, height: geo.size.height / 40)
                .position(x: geo.size.width - (geo.size.width / 8),
                          y: geo.size.height / 2)
        }
    }
}

struct SignExtenderView_Previews: PreviewProvider {
    static var previews: some View {
        SignExtenderView(showLines: false)
            .frame(width: 200, height: 200)
            .border(.blue, width: 1)
    }
}
