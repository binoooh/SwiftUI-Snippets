//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by bino on 7/18/25.
//

import SwiftUI
import ThemeKit
import SwiftData

struct DetailEditView: View {
	
	@Environment(\.dismiss) var dismiss
	@Environment(\.modelContext) private var context
    
    let scrum: DailyScrum
	private let isCreatingScrum: Bool
	
    @State private var attendeeName = ""
	@State private var title: String
	@State private var lengthInMinutesAsDouble: Double
	@State private var theme: Theme
	@State private var attendees: [Attendee]
	//let saveEdits: (DailyScrum)->Void
	
	init(scrum: DailyScrum?) {
		let scrumToEdit: DailyScrum
		if let scrum {
			scrumToEdit = scrum
			isCreatingScrum = false
		} else {
			scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
			isCreatingScrum = true
		}
		
		
		self.scrum = scrumToEdit
		self.title = scrumToEdit.title
		self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
		self.attendees = scrumToEdit.attendees
		self.theme = scrumToEdit.theme
	}
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $title)
                HStack {
                    Slider(value: $lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete{ indices in
                    attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attedee", text: $attendeeName)
                    Button {
                        // code here
                        withAnimation {
                            let attendee = Attendee(name: attendeeName)
                            attendees.append(attendee)
                            attendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(attendeeName.isEmpty)
                }
            }
        }
		.toolbar {
			ToolbarItem(placement: .cancellationAction) {
				Button("Cancel") {
					dismiss()
				}
			}
			ToolbarItem(placement: .confirmationAction) {
				Button("Done") {
					saveEdits()
					dismiss()
				}
			}
		}
    }
	private func saveEdits() {
		scrum.title = title
		scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
		scrum.attendees = attendees
		scrum.theme = theme
		
		if isCreatingScrum {
			context.insert(scrum)
		}
		
		try? context.save()
	}
}

#Preview(traits: .dailyScrumsSampleData) {
	@Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
	DetailEditView(scrum: scrums[0])
}
