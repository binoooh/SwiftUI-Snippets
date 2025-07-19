//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by bino on 7/16/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
