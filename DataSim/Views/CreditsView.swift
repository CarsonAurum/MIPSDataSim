//
//  CreditsView.swift
//  DataSim
//
//  Created by Carson Rau on 4/3/23.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("Carson Rau")
                    .font(.customBody)
                    .foregroundColor(.primary)
                Text("App Design and UX Development")
                    .multilineTextAlignment(.center)
                    .font(.customSubtitle)
                    .foregroundColor(.blue)
            }
            VStack(alignment: .center) {
                Text("Dillon Fleharty")
                    .font(.customBody)
                    .foregroundColor(.primary)
                Text("Image/Graphic Design and Processor Modelling")
                    .multilineTextAlignment(.center)
                    .font(.customSubtitle)
                    .foregroundColor(.blue)
            }
            VStack(alignment: .center) {
                Text("Rene Carbajal")
                    .font(.customBody)
                    .foregroundColor(.primary)
                Text("Instruction encoding and Processor Modelling")
                    .multilineTextAlignment(.center)
                    .font(.customSubtitle)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
