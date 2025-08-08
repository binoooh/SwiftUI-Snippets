//
//  ContentView.swift
//  SpeechToText
//
//  Created by bino on 7/31/25.
//

import SwiftUI

struct ContentView: View {
	
	var body: some View {
		
		ZStack {
			VStack {
				Spacer()
				MicView()
					.padding(.bottom, 10)
			}
		}
	}
}

#Preview {
	ContentView()
}
