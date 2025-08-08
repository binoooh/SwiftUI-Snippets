//
//  MicView.swift
//  SpeechToText
//
//  Created by bino on 8/7/25.
//

import SwiftUI

struct MicView: View {
	@State private var isPressed = false
	@Environment(\.colorScheme) var colorScheme
	
	var body: some View {
		ZStack {
			// Animated ring - always present in layout but only visible when pressed
			AnimatedRingView()
				.opacity(isPressed ? 1 : 0)
				.transition(.opacity)
			
			// Main microphone button - centered within the same ZStack
			Button {
				// Add your microphone action here
			} label: {
				ZStack {
					// Main button background
					Circle()
						.fill(buttonBackgroundColor)
						.frame(width: 80, height: 80)
						.overlay(
							Circle()
								.stroke(buttonBorderColor, lineWidth: 1)
						)
						.shadow(
							color: shadowColor,
							radius: isPressed ? 3 : 8,
							x: isPressed ? 1 : 3,
							y: isPressed ? 1 : 3
						)
						.shadow(
							color: highlightShadowColor,
							radius: isPressed ? 2 : 5,
							x: isPressed ? -1 : -2,
							y: isPressed ? -1 : -2
						)
						.scaleEffect(isPressed ? 0.95 : 1.0)
					
					// Microphone icon
					Image(systemName: "microphone.fill")
						.font(.system(size: 28, weight: .medium))
						.foregroundColor(microphoneColor)
						.scaleEffect(isPressed ? 0.9 : 1.0)
				}
			}
			.buttonStyle(PlainButtonStyle())
			.onLongPressGesture(
				minimumDuration: 0,
				maximumDistance: .infinity,
				pressing: { pressing in
					withAnimation(.easeInOut(duration: 0.15)) {
						isPressed = pressing
					}
				},
				perform: {}
			)
		}
		// Set a consistent frame size for the entire ZStack
		.frame(width: 100, height: 100)
	}
}

// MARK: - Color Helpers
extension MicView {
	
	/// Background color that adapts to light/dark mode
	private var buttonBackgroundColor: Color {
		colorScheme == .dark
		? Color(red: 0.15, green: 0.15, blue: 0.15)  // Dark gray for dark mode
		: Color(red: 0.95, green: 0.95, blue: 0.95)  // Light gray for light mode
	}
	
	/// Border color for better definition
	private var buttonBorderColor: Color {
		colorScheme == .dark
		? Color.white.opacity(0.1)
		: Color.black.opacity(0.1)
	}
	
	/// Main shadow color
	private var shadowColor: Color {
		colorScheme == .dark
		? Color.black.opacity(0.5)
		: Color.black.opacity(0.15)
	}
	
	/// Highlight shadow for neumorphic effect
	private var highlightShadowColor: Color {
		colorScheme == .dark
		? Color.white.opacity(0.05)
		: Color.white.opacity(0.8)
	}
	
	/// Microphone icon color
	private var microphoneColor: Color {
		colorScheme == .dark
		? Color.white.opacity(0.9)
		: Color.black.opacity(0.7)
	}
}

#Preview {
	MicView()
}
