//
//  BadgeView.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct BadgeView: View {
	let count: Int
	let scale: CGFloat
	
	var body: some View {
		ZStack {
			// Badge background - a perfect circle with gradient for depth
			Circle()
				.fill(
					LinearGradient(
						gradient: Gradient(colors: [.red, .red.opacity(0.8)]),
						startPoint: .topLeading,
						endPoint: .bottomTrailing
					)
				)
				.frame(width: badgeSize, height: badgeSize)
				.scaleEffect(scale)
			
			// Badge text with smart formatting for different counts
			Text(badgeText)
				.font(.system(size: fontSize, weight: .bold))
				.foregroundColor(.white)
				.scaleEffect(scale)
		}
		// Subtle shadow to make the badge stand out against any background
		.shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
	}
	
	// MARK: - Badge Sizing Logic
	
	// Badge size adapts to the number of digits
	private var badgeSize: CGFloat {
		count > 99 ? 20 : (count > 9 ? 18 : 16)
	}
	
	// Font size scales with badge size
	private var fontSize: CGFloat {
		count > 99 ? 9 : (count > 9 ? 10 : 11)
	}
	
	// Smart text formatting - shows "99+" for large counts
	private var badgeText: String {
		count > 99 ? "99+" : "\(count)"
	}
}

#Preview {
	BadgeView(count: 0, scale: 1.0)
}
