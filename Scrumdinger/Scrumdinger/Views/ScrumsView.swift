//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by bino on 7/17/25.
//

import SwiftUI
import SwiftData

struct ScrumsView: View {
	
    //  fetch all persisted scrums sorted by their title
	@Query(sort: \DailyScrum.title) private var scrums: [DailyScrum]
	
	@State private var isPresentingNewScrumView: Bool = false
    
    var body: some View {
        NavigationStack {
            List(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button {
					isPresentingNewScrumView = true
                } label: {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
			.sheet(isPresented: $isPresentingNewScrumView) {
				NewScrumSheet()
			}
        }
    }
}

#Preview(traits: .dailyScrumsSampleData) {
    ScrumsView()
}
