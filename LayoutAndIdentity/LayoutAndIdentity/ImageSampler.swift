//
//  ImageSampler.swift
//  LayoutAndIdentity
//
//  Created by bino on 7/18/25.
//

import SwiftUI

struct ImageSampler: View {
    var body: some View {
        HStack {
            Text("Forecast")
                .padding()
                .frame(maxHeight: .infinity)
                .background(.yellow)
            Text("The rain in Spain falls mainly on the Spaniards")
                .padding()
                .frame(maxHeight: .infinity)
                .background(.cyan)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ImageSampler()
}
