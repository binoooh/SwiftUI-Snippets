//
//  TabBarButton.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct TabBarButton: View {
	let tab: TabItem
	let isSelected: Bool
	let action: () -> Void
	
	var body: some View {
		Button(action: action) {
			VStack(spacing: 4) {
				// Tab icon with dynamic sizing based on selection
				Image(systemName: tab.icon)
					.font(.system(size: isSelected ? 24 : 20, weight: .medium))
					.foregroundColor(isSelected ? .primary : .secondary)
				
				// Optional: Add tab labels (uncomment if you want text labels)
				/*
				 Text(tab.title)
				 .font(.caption2)
				 .foregroundColor(isSelected ? .primary : .secondary)
				 */
			}
			.scaleEffect(isSelected ? 1.1 : 1.0) // Subtle scale animation
			.animation(.easeInOut(duration: 0.2), value: isSelected)
		}
		.buttonStyle(PlainButtonStyle()) // Remove default button styling
	}
}

//#Preview {
//    TabBarButton()
//}
