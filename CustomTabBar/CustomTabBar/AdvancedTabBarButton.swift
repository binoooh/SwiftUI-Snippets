//
//  AdvancedTabBarButton.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct AdvancedTabBarButton: View {
	let tab: AdvancedTabItem
	let isSelected: Bool
	let dynamicTypeSize: DynamicTypeSize
	let action: () -> Void
	
	// Environment value to detect the current color scheme (light/dark mode)
	// Think of this as asking the system: "What appearance mode is the user currently using?"
	@Environment(\.colorScheme) private var colorScheme
	
	// State for managing the badge animation - we'll make badges pulse when they appear
	@State private var badgeScale: CGFloat = 1.0
	
	var body: some View {
		Button(action: action) {
			ZStack {
				// Main tab content in a VStack
				VStack(spacing: adaptiveSpacing) {
					// Icon with badge overlay
					ZStack {
						// The main tab icon with dynamic sizing
						Image(systemName: tab.icon)
							.font(.system(size: iconSize, weight: .medium))
							.foregroundColor(isSelected ? .primary : .secondary)
						
						// Badge overlay - only appears when badgeCount > 0
						if tab.badgeCount > 0 {
							BadgeView(count: tab.badgeCount, scale: badgeScale)
								.offset(x: badgeOffset.x, y: badgeOffset.y)
						}
					}
					
					// Optional text label - shown based on accessibility needs
					if shouldShowLabel {
						Text(tab.title)
							.font(labelFont)
							.foregroundColor(isSelected ? .primary : .secondary)
							.lineLimit(1)
					}
				}
				.scaleEffect(isSelected ? 1.1 : 1.0)
				.animation(.easeInOut(duration: 0.2), value: isSelected)
			}
		}
		.buttonStyle(PlainButtonStyle())
		// Enhanced accessibility support
		.accessibilityLabel(tab.title)
		.accessibilityHint(tab.accessibilityHint)
		.accessibilityAddTraits(isSelected ? .isSelected : [])
		// Animate badge appearance
		.onAppear {
			if tab.badgeCount > 0 {
				startBadgeAnimation()
			}
		}
		.onChange(of: tab.badgeCount) { newCount in
			if newCount > 0 {
				startBadgeAnimation()
			}
		}
	}
	
	// MARK: - Intelligent Color Selection for Dark Mode
	
	// This computed property demonstrates a sophisticated approach to color management
	// Rather than hardcoding colors, we create logic that responds to user preferences
	private var intelligentIconColor: Color {
		switch colorScheme {
		case .dark:
			// In dark mode, we want high contrast for clarity and modern aesthetics
			return isSelected ? .white : Color.white.opacity(0.6)
		case .light:
			// In light mode, we use the system's semantic colors for perfect integration
			return isSelected ? .primary : .secondary
		@unknown default:
			// Future-proofing: handle any new color schemes Apple might introduce
			return isSelected ? .primary : .secondary
		}
	}
	
	// Text color follows the same intelligent logic as icons for visual consistency
	// This ensures that when labels are shown for accessibility, they match the icon colors
	private var intelligentTextColor: Color {
		switch colorScheme {
		case .dark:
			// In dark mode, white text provides optimal readability on the blurred background
			return isSelected ? .white : Color.white.opacity(0.6)
		case .light:
			// In light mode, semantic colors ensure perfect contrast and system integration
			return isSelected ? .primary : .secondary
		@unknown default:
			return isSelected ? .primary : .secondary
		}
	}
	
	// MARK: - Dynamic Sizing Logic
	
	// Icon size adapts to both selection state and accessibility settings
	private var iconSize: CGFloat {
		let baseSize: CGFloat
		switch dynamicTypeSize {
		case .xSmall, .small:
			baseSize = 18
		case .medium, .large:
			baseSize = 20
		case .xLarge, .xxLarge:
			baseSize = 22
		default:
			baseSize = 24
		}
		return isSelected ? baseSize + 4 : baseSize
	}
	
	// Spacing between icon and label adapts to text size
	private var adaptiveSpacing: CGFloat {
		switch dynamicTypeSize {
		case .xSmall, .small, .medium:
			return 4
		case .large, .xLarge:
			return 5
		default:
			return 6
		}
	}
	
	// Determine when to show text labels based on accessibility needs
	private var shouldShowLabel: Bool {
		// Show labels for larger accessibility sizes to improve usability
		switch dynamicTypeSize {
		case .xSmall, .small, .medium, .large:
			return false  // Icons only for standard sizes
		default:
			return true   // Add labels for accessibility
		}
	}
	
	// Font size for labels when they're shown
	private var labelFont: Font {
		switch dynamicTypeSize {
		case .xLarge, .xxLarge:
			return .caption
		default:
			return .caption2
		}
	}
	
	// Badge positioning - needs to adapt based on icon size
	private var badgeOffset: CGPoint {
		let baseOffset = iconSize * 0.4
		return CGPoint(x: baseOffset, y: -baseOffset)
	}
	
	// MARK: - Badge Animation Logic
	
	// Creates a subtle pulsing animation to draw attention to new badges
	private func startBadgeAnimation() {
		withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
			badgeScale = 1.1
		}
	}
}

//#Preview {
//    AdvancedTabBarButton()
//}
