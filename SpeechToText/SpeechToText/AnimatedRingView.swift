//
//  AnimatedRingView.swift
//  SpeechToText
//
//  Created by bino on 8/7/25.
//

import SwiftUI

struct AnimatedRingView: View {
	@State private var rotationAngle: Double = 0
	@State private var isVisible = true
	@Environment(\.colorScheme) var colorScheme
	
	// Random gradient colors
	@State private var gradientColors: [Color] = []
	
	var body: some View {
		ZStack {
			// Animated ring with gradient
			Circle()
				.stroke(
					AngularGradient(
						gradient: Gradient(colors: gradientColors),
						center: .center,
						startAngle: .degrees(rotationAngle),
						endAngle: .degrees(rotationAngle + 360)
					),
					style: StrokeStyle(lineWidth: 3, lineCap: .round)
				)
				.frame(width: 100, height: 100)
				.opacity(isVisible ? 1.0 : 0.0)
				.rotationEffect(.degrees(rotationAngle))
				.onAppear {
					startAnimation()
				}
		}
	}
	
	// MARK: - Animation Logic
	private func startAnimation() {
		// Generate random gradient colors
		generateRandomColors()
		
		// Start the rotation animation
		withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: false)) {
			rotationAngle = 360
		}
		
		// Start the visibility animation (hide/show every 1 second)
		startVisibilityAnimation()
	}
	
	private func startVisibilityAnimation() {
		Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
			withAnimation(.easeInOut(duration: 1.0)) {
				isVisible.toggle()
			}
			
			// Generate new colors when ring becomes visible again
			if isVisible {
				generateRandomColors()
			}
		}
	}
	
	private func generateRandomColors() {
		let colors = [
			Color.red, Color.blue, Color.green, Color.orange,
			Color.purple, Color.pink, Color.yellow, Color.cyan,
			Color.mint, Color.indigo, Color.teal
		]
		
		// Pick 3-4 random colors for the gradient
		gradientColors = Array(colors.shuffled().prefix(Int.random(in: 3...4)))
	}
}

#Preview {
	ZStack {
		Color.gray.opacity(0.1)
			.ignoresSafeArea()
		
		AnimatedRingView()
	}
}
