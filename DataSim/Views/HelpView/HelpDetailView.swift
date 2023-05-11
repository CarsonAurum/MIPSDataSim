//
//  HelpDetailView.swift
//  DataSim
//
//  Created by Carson Rau on 5/11/23.
//

import SwiftUI

struct HelpDetailView: View {
    private let data: HelpInfo
    init(_ kind: DatapathComponent) {
        self.data = HelpData.getInfo(for: kind)
    }
    var body: some View {
        EmptyView()
    }
}
