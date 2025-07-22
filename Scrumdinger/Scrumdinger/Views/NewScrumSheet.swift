//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by bino on 7/19/25.
//

import SwiftUI

struct NewScrumSheet: View {

    var body: some View {
		NavigationStack {
			DetailEditView(scrum: nil)
		}
    }
}

#Preview {
	NewScrumSheet()
}
