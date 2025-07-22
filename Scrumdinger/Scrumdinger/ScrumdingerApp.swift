//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by bino on 7/16/25.
//

import SwiftUI
import SwiftData

@main
struct ScrumdingerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ScrumsView()
        }
		.modelContainer(for: DailyScrum.self)
    }
}
