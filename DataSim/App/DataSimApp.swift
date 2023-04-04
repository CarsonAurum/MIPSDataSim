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
    init() {
        
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
