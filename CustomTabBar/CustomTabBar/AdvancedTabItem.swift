//
//  AdvancedTabItem.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import Foundation

struct AdvancedTabItem {
	let icon: String
	let title: String
	let badgeCount: Int
	let accessibilityHint: String
	
	// Convenience initializer for tabs without badges
	init(icon: String, title: String, badgeCount: Int = 0, accessibilityHint: String = "") {
		self.icon = icon
		self.title = title
		self.badgeCount = badgeCount
		self.accessibilityHint = accessibilityHint.isEmpty ? "Navigate to \(title.lowercased())" : accessibilityHint
	}
}
