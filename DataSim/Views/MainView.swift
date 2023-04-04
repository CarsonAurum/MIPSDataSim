//
//  MainView.swift
//  DataSim
//
//  Created by Carson Rau on 3/20/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                Spacer()
                Text("MIPS DataSim")
                    .font(.largeTitle)
                Spacer()
                    .frame(height: 20)
                NavigationLink(
                    destination: WorkbenchView()
                        .navigationBarBackButtonHidden(true)
                ) {
                    Text("New Game")
                        .font(.headline)
                        .frame(height: 20)
                }
                NavigationLink(destination: HelpView()) {
                    Text("Datapath Hints")
                        .font(.subheadline)
                        .frame(height: 20)
                }
                NavigationLink(destination: OptionsView()) {
                    Text("Game Settings")
                        .font(.subheadline)
                        .frame(height: 20)
                }
                NavigationLink(destination: CreditsView()) {
                    Text("Game Credits")
                        .font(.subheadline)
                        .frame(height: 20)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
