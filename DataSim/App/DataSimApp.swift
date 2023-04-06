//
//  DataSimApp.swift
//  DataSim
//
//  Created by Carson Rau on 3/20/23.
//

import SwiftUI

@main
struct DataSimApp: App {
    @State var color: Color = .gray
    @StateObject var processor: MIPSProcessor = .init()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(processor)
        }
    }
}
