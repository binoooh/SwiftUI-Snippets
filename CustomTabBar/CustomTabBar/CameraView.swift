//
//  CameraView.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
		ZStack {
			LinearGradient(
				gradient: Gradient(colors: [.orange.opacity(0.3), .red.opacity(0.3)]),
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
			
			VStack(spacing: 20) {
				Image(systemName: "camera.fill")
					.font(.system(size: 60))
					.foregroundColor(.primary)
				
				Text("Camera")
					.font(.largeTitle)
					.fontWeight(.bold)
				
				Text("Try switching tabs to feel the haptic feedback!")
					.foregroundColor(.secondary)
					.multilineTextAlignment(.center)
					.padding()
				
				Text("The tab bar adapts its size based on your accessibility settings")
					.font(.caption)
					.foregroundColor(.secondary)
					.multilineTextAlignment(.center)
					.padding(.horizontal)
			}
		}
    }
}

#Preview {
    CameraView()
}
