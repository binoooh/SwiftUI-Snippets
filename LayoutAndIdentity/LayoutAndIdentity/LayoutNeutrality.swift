//
//  LayoutNeutrality.swift
//  LayoutAndIdentity
//
//  Created by bino on 8/5/25.
//

import SwiftUI

struct LayoutNeutrality: View {
	
	@State private var usesFixedSize = false
	
    var body: some View {
		Text("Hello World!")
			.frame(width: usesFixedSize ? 300 : nil)
			.background(.red)
		
		Toggle("Fixes sizes", isOn: $usesFixedSize.animation())
    }
}

#Preview {
    LayoutNeutrality()
}
