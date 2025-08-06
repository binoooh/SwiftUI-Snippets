//
//  ContentView.swift
//  SpeechToText
//
//  Created by bino on 7/31/25.
//

import SwiftUI

struct ContentView: View {
	@State private var isAnimating = false
	@State private var isPressed = false
	@State private var outerScale: CGFloat = 0.3
	@State private var innerScale: CGFloat = 0.6
	@State private var outerOpacity: Double = 0.0
	@State private var innerOpacity: Double = 0.0
	
	var body: some View {
		Spacer()
		VStack {
			ZStack {
				// Outer ripple circle
				Circle().stroke()
					.fill(Color.gray.opacity(-0.1))
					.frame(width: 200, height: 200)
					.scaleEffect(outerScale)
					.opacity(outerOpacity)
					.overlay(
						Circle()
							.stroke(
								Color.gray,
								lineWidth: 5
							)
							.blur(radius: 8)
							.scaleEffect(outerScale)
							.opacity(outerOpacity)
					)
					.shadow(color: Color.gray.opacity(0.7), radius: 20, x: 0, y: 0)
				
				// Inner ripple circle
				Circle().stroke()
					.fill(Color.gray.opacity(-0.1))
					.frame(width: 120, height: 120)
					.scaleEffect(innerScale)
					.opacity(innerOpacity)
					.overlay(
						Circle()
							.stroke(
								Color.gray,
								lineWidth: 5
							)
							.blur(radius: 8)
							.scaleEffect(innerScale)
							.opacity(innerOpacity)
					)
					.shadow(color: Color.gray.opacity(0.7), radius: 20, x: 0, y: 0)
				
				Button {
					startWaterDropletAnimation()
				} label: {
					ZStack {
						// Background circle with embossed effect
						Circle()
							.fill(
								RadialGradient(
									gradient: Gradient(colors: [
										Color.white.opacity(0.9),
										Color.gray.opacity(0.1)
									]),
									center: .topLeading,
									startRadius: 5,
									endRadius: 50
								)
							)
							.frame(width: 80, height: 80)
							.overlay(
								Circle()
									.stroke(
										LinearGradient(
											gradient: Gradient(colors: [
												Color.white.opacity(0.8),
												Color.gray.opacity(0.3)
											]),
											startPoint: .topLeading,
											endPoint: .bottomTrailing
										),
										lineWidth: 1
									)
							)
							.shadow(
								color: Color.black.opacity(0.1),
								radius: isPressed ? 2 : 8,
								x: isPressed ? 1 : 4,
								y: isPressed ? 1 : 4
							)
							.shadow(
								color: Color.white.opacity(0.9),
								radius: isPressed ? 1 : 4,
								x: isPressed ? -0.5 : -2,
								y: isPressed ? -0.5 : -2
							)
							.scaleEffect(isPressed ? 0.95 : 1.0)
						
						// Microphone icon
						Image(systemName: "microphone.fill")
							.font(.system(size: 32, weight: .medium))
							.foregroundStyle(
								LinearGradient(
									gradient: Gradient(colors: [
										Color.gray.opacity(0.8),
										Color.gray.opacity(0.4)
									]),
									startPoint: .topLeading,
									endPoint: .bottomTrailing
								)
							)
							.scaleEffect(isPressed ? 0.9 : 1.0)
					}
					
				}
				.buttonStyle(PlainButtonStyle())
				.onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
					withAnimation(.easeInOut(duration: 0.1)) {
						isPressed = pressing
					}
				}, perform: {})
			}
		}
		.padding()
	}
	
	private func startWaterDropletAnimation() {
		guard !isAnimating else { return }
		
		isAnimating = true
		
		// Start from microphone size
		outerScale = 0.3
		innerScale = 0.6
		outerOpacity = 0.7
		innerOpacity = 0.7
		
		// Animate to full size and fade out
		withAnimation(.easeOut(duration: 2.0)) {
			outerScale = 1.4
			outerOpacity = 0.0
		}
		
		withAnimation(.easeOut(duration: 1.8).delay(0.1)) {
			innerScale = 1.3
			innerOpacity = 0.0
		}
		
		// Hide circles and reset after animation
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
			outerScale = 0.3
			innerScale = 0.6
			outerOpacity = 0.0
			innerOpacity = 0.0
			isAnimating = false
		}
	}
}

#Preview {
	ContentView()
}
