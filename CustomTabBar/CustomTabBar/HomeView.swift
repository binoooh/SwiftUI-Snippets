//
//  HomeView.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
		ZStack {
			// Gradient background to show the translucent effect
			LinearGradient(
				gradient: Gradient(colors: [.green.opacity(0.3), .blue.opacity(0.3)]),
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
			
			VStack(spacing: 20) {
				Text("Home")
					.font(.largeTitle)
					.fontWeight(.bold)
				
				Text("Advanced Features Demonstrated:")
					.font(.headline)
					.foregroundColor(.secondary)
				
				VStack(alignment: .leading, spacing: 8) {
					Text("• Haptic feedback on tab switches")
					Text("• Dynamic sizing based on accessibility settings")
					Text("• Badge notifications with animations")
					Text("• Enhanced accessibility support")
					Text("• Adaptive corner radius and padding")
				}
				.font(.body)
				.foregroundColor(.primary)
				.padding(.horizontal)
			}
		}
    }
}

#Preview {
    HomeView()
}
