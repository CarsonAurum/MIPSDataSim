//
//  WorkbenchView.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

import SwiftUI

struct WorkbenchView: View {
    
    @Environment(\.dismiss) private var dismissal
    
    @State private var isPaused: Bool = false
    @State private var scale: Double = 1.0
    @State private var lastScale: Double = 1.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    ScrollView([.horizontal, .vertical],
                               showsIndicators: false) {
                    }
                    Divider()
                    ScrollView([.horizontal], showsIndicators: false) {
                        HStack {
                            ForEach(DatapathComponent.allCases,
                                    id: \.self) { comp in
                                VStack {
                                    DatapathElementView(comp)
                                        .aspectRatio(contentMode: .fit)
                                    Text(comp.rawValue)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: geo.size.height / 5)
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
    static var previews: some View {
        WorkbenchView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
