//
//  ProfileView.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
		ZStack {
			LinearGradient(
				gradient: Gradient(colors: [.purple.opacity(0.3), .pink.opacity(0.3)]),
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)
			.ignoresSafeArea()
			
			VStack(spacing: 20) {
				Image(systemName: "person.fill")
					.font(.system(size: 60))
					.foregroundColor(.primary)
				
				Text("Profile")
					.font(.largeTitle)
					.fontWeight(.bold)
				
				Text("Notice the badge on this tab!")
					.foregroundColor(.secondary)
					.multilineTextAlignment(.center)
					.padding()
				
				VStack(alignment: .leading, spacing: 4) {
					Text("Badge Features:")
						.font(.headline)
					Text("• Adaptive sizing based on count")
					Text("• Subtle pulsing animation")
					Text("• Smart text formatting (99+)")
					Text("• Positioned relative to icon size")
				}
				.font(.caption)
				.foregroundColor(.secondary)
				.padding()
			}
		}
    }
}

#Preview {
    ProfileView()
}
