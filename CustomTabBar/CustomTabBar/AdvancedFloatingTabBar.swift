//
//  AdvancedFloatingTabBar.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct AdvancedFloatingTabBar: View {
	@Binding var selectedTab: Int
	
	// Environment value to detect accessibility text size changes
	// This allows our tab bar to adapt its height when users need larger text
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize
	
	// Create a haptic feedback generator that we'll use throughout the component
	// Think of this as preparing a vibration motor that we can trigger on demand
	private let impactFeedback = UIImpactFeedbackGenerator(style: .light)
	
	// Enhanced tab configuration with badge support and accessibility labels
	// Notice how each tab now has richer metadata to support advanced features
	private let tabs = [
		AdvancedTabItem(
			icon: "house.fill",
			title: "Home",
			badgeCount: 3,  // New messages or notifications
			accessibilityHint: "Navigate to home screen"
		),
		AdvancedTabItem(
			icon: "camera.fill",
			title: "Camera",
			badgeCount: 0,  // No badge for camera
			accessibilityHint: "Open camera to take photos"
		),
		AdvancedTabItem(
			icon: "person.fill",
			title: "Profile",
			badgeCount: 1,  // Profile update available
			accessibilityHint: "View and edit your profile"
		)
	]
	
	var body: some View {
		HStack(spacing: 0) {
			ForEach(0..<tabs.count, id: \.self) { index in
				AdvancedTabBarButton(
					tab: tabs[index],
					isSelected: selectedTab == index,
					dynamicTypeSize: dynamicTypeSize
				) {
					// Enhanced tab switching with haptic feedback
					handleTabSelection(index: index)
				}
				.frame(maxWidth: .infinity)
			}
		}
		.padding(.horizontal, 16)
		// Dynamic padding that adapts to text size - larger text needs more space
		.padding(.vertical, dynamicPadding)
		.background(
			// Enhanced background with more sophisticated visual effects
			RoundedRectangle(cornerRadius: adaptiveCornerRadius)
				.fill(.ultraThinMaterial)
			// Layered shadows create depth and make the tab bar feel like it's truly floating
				.shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 5)
				.shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
		)
		// Subtle entrance animation when the tab bar first appears
		.scaleEffect(1.0)
		.animation(.spring(response: 0.6, dampingFraction: 0.8), value: selectedTab)
	}
	
	// MARK: - Advanced Tab Selection Logic
	private func handleTabSelection(index: Int) {
		// Only proceed if we're actually changing tabs - this prevents unnecessary work
		guard selectedTab != index else { return }
		
		// Prepare the haptic feedback generator - this "primes" it for immediate response
		impactFeedback.prepare()
		
		// Animate the tab change with a smooth, organic feeling spring animation
		withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
			selectedTab = index
		}
		
		// Trigger haptic feedback after a tiny delay to sync with the visual animation
		// This creates a more cohesive user experience where touch, sight, and feel align
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			impactFeedback.impactOccurred()
		}
	}
	
	// MARK: - Dynamic Sizing Calculations
	
	// This computed property adjusts padding based on the user's accessibility settings
	// Think of it as making the tab bar more comfortable for users who need larger interfaces
	private var dynamicPadding: CGFloat {
		switch dynamicTypeSize {
		case .xSmall, .small, .medium:
			return 12
		case .large, .xLarge:
			return 14
		case .xxLarge, .xxxLarge:
			return 16
		default:
			// For accessibility sizes, we provide even more generous spacing
			return 20
		}
	}
	
	// Corner radius that adapts to the overall size of the tab bar
	// Larger tab bars get slightly more rounded corners to maintain visual harmony
	private var adaptiveCornerRadius: CGFloat {
		switch dynamicTypeSize {
		case .xSmall, .small, .medium:
			return 25
		case .large, .xLarge:
			return 27
		default:
			return 30
		}
	}
}

#Preview {
	AdvancedFloatingTabBar(selectedTab: .constant(1))
}
