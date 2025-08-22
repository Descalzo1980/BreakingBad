//
//  ContentView.swift
//  BreakingBad
//
//  Created by Станислав Леонов on 20.08.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                QuoteView(show: "Breaking Bad")
            }
            Tab("Better Call Saul", systemImage: "briefcase") {
                QuoteView(show: "Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
