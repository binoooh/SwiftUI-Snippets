//
//  ContentView.swift
//  SpeechToText
//
//  Created by bino on 7/31/25.
//

import SwiftUI

struct ContentView: View {
	@State private var isAnimating = false
	@State private var outerScale: CGFloat = 0.3
	@State private var innerScale: CGFloat = 0.5
	@State private var outerOpacity: Double = 0.0
	@State private var innerOpacity: Double = 0.0
	
	var body: some View {
		VStack {
			ZStack {
				
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
					Image(systemName: "microphone.fill")
						.font(.system(size: 50))
						.foregroundColor(.gray)
					
				}
				.frame(width: 60, height: 60)
				.clipShape(.circle)
				.shadow(radius: 10)
			}
		}
		.padding()
	}
	
	private func startWaterDropletAnimation() {
		guard !isAnimating else { return }
		
		isAnimating = true
		
		// Start from microphone size
		outerScale = 0.3
		innerScale = 0.5
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
			innerScale = 0.5
			outerOpacity = 0.0
			innerOpacity = 0.0
			isAnimating = false
		}
	}
}

#Preview {
	ContentView()
}
