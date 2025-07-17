//
//  ContentView.swift
//  LayoutAndIdentity
//
//  Created by bino on 7/13/25.
//

import SwiftUI

struct CustomFont: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle)
    }
}
//MARK: Every modifier we add on a view SwiftUI creates a ModifiedContent at runtime
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Tap Me!")
                .frame(width: 300, height: 100, alignment: .bottomTrailing) // Frame is the parent of TextView
                .onTapGesture {
                    print(type(of: self.body))
                }
            Image(systemName: "person")
                .padding()
            
            // We can use ModifiedContent public API as it conforms ViewModifier
            ModifiedContent(content: Text("I am a ModifiedContent"), modifier: CustomFont())
            
            // But we can just use a .modifier() and it will result the same
            Text("I am a Text with .modifier()")
                .modifier(CustomFont())
                .onTapGesture {
                    print(type(of: self.body))
                }
            
            Text("I am a text with no fixed size!")
                .frame(width: 30, height: 100)
            
            Text("I am a text with fixed size!")
                .fixedSize() // fixedSize is the parent view of Text
                .frame(width: 30, height: 100) // frame is the parent view of fixedSize
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
