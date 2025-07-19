//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by bino on 7/19/25.
//

import SwiftUI
import TimerKit

struct MeetingFooterView: View {
	
	let speakers: [ScrumTimer.Speaker]
	// Use skipAction to allow users to skip to the next speaker.
	var skipAction: () -> Void
	
	// Determine the speaker number.
	private var speakerNumber: Int? {
		guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else { return nil }
		return index + 1
	}
	
	// Checks whether the active speaker is the last speaker
	private var isLastSpeaker: Bool {
		return speakers.dropLast().allSatisfy { $0.isCompleted }
	}
	
	// Returns information about the active speaker, and pass it to the Text view.
	private var speakerText: String {
		guard let speakerNumber = speakerNumber else {
			return "No more speakers"
		}
		return "Speaker \(speakerNumber) of \(speakers.count)"
	}
	
    var body: some View {
		VStack {
			HStack {
				if isLastSpeaker {
					Text("Last Speaker")
				} else {
					Text(speakerText)
					Button {
						skipAction()
					} label: {
						Image(systemName: "forward.fill")
					}
					.accessibilityLabel("Next speaker")
				}
			}
		}
		.padding([.bottom, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
	@Previewable @State var speakers = DailyScrum.sampleData[0].attendees
		.map { $0.name }
		.map { ScrumTimer.Speaker(name: $0, isCompleted: false) }
	MeetingFooterView(speakers: speakers, skipAction: {})
}
