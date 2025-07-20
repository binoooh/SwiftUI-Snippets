//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by bino on 7/18/25.
//

import SwiftUI

struct DetailEditView: View {
	
	@Environment(\.dismiss) var dismiss
    
    @Binding var scrum: DailyScrum
	
    @State private var attendeeName = ""
	
	let saveEdits: (DailyScrum)->Void
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete{ indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Attedee", text: $attendeeName)
                    Button {
                        // code here
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: attendeeName)
                            scrum.attendees.append(attendee)
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
					saveEdits(scrum)
					dismiss()
				}
			}
		}
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
	DetailEditView(scrum: $scrum, saveEdits: { _ in })
}
