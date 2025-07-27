//
//  FloatingTabBar.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct FloatingTabBar: View {
	@Binding var selectedTab: Int
	
	// Tab configuration - easy to modify for your needs
	private let tabs = [
		TabItem(icon: "house.fill", title: "Home"),
		TabItem(icon: "camera.viewfinder", title: "Camera"),
		TabItem(icon: "person.fill", title: "Profile")
	]
	
	var body: some View {
		HStack(spacing: 0) {
			ForEach(0..<tabs.count, id: \.self) { index in
				TabBarButton(
					tab: tabs[index],
					isSelected: selectedTab == index
				) {
					// Smooth animation when switching tabs
					withAnimation(.easeInOut(duration: 0.2)) {
						selectedTab = index
					}
				}
				.frame(maxWidth: .infinity) // Equal spacing for all tabs
			}
		}
		.padding(.horizontal, 16) // Internal padding within the tab bar
		.padding(.vertical, 12)
		.frame(width: 250)
		.background(
			// This creates the translucent, blurred background effect
			RoundedRectangle(cornerRadius: 25)
				.fill(.ultraThinMaterial) // iOS 15+ material for blur effect
				.shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
		)
	}
}

#Preview {
	FloatingTabBar(selectedTab: .constant(0))
}
