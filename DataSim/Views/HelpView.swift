//
//  HelpView.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                HStack {
                    Text("Gameplay and Datapath Help")
                        .font(.customLargeTitle)
                        .padding([.leading], 20)
                    Spacer()
                }
                Spacer()
                Text("Help coming soon.")
                    .font(.customCaption)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
