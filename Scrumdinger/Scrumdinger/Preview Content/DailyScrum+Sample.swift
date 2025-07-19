//
//  DailyScrum+Sample.swift
//  Scrumdinger
//
//  Created by bino on 7/17/25.
//

import Foundation
import ThemeKit

extension DailyScrum {
    
    static let sampleData: [DailyScrum] = [
        
        DailyScrum(title: "Design",
                   attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                   lengthInMinutes: 10,
                   theme: .yellow),
        
        DailyScrum(title: "Development",
                   attendees: ["Katie", "Gary", "Euna", "Luis", "Darla"],
                   lengthInMinutes: 5,
                   theme: .orange),
        
        DailyScrum(title: "Testing",
                   attendees: ["Arvin", "Liza", "Danny", "Mary", "Gaidy", "Gerald", "Francis", "Emily"],
                   lengthInMinutes: 5,
                   theme: .poppy),
    ]
}
