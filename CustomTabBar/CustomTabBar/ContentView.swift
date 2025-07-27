//
//  ContentView.swift
//  CustomTabBar
//
//  Created by bino on 7/25/25.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedTab = 1
	
	var body: some View {
		ZStack {
			// Background content that will show through the translucent tab bar
			TabView(selection: $selectedTab) {
				HomeView()
					.tag(0)
				
				CameraView()
					.tag(1)
				
				ProfileView()
					.tag(2)
			}
			.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
			.ignoresSafeArea(.all, edges: .top)
			// Our custom floating tab bar overlay
			VStack {
				Spacer()
				//FloatingTabBar(selectedTab: $selectedTab)
				AdvancedFloatingTabBar(selectedTab: $selectedTab)
					.padding(.horizontal, 20) // Add some side padding
					.padding(.bottom, 34) // Adjust for safe area
			}
		}
		.ignoresSafeArea(.all, edges: .bottom) // Allow content to extend behind tab bar
	}
}

#Preview {
    ContentView()
}
