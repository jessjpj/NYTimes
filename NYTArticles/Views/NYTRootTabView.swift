//
//  NYTRootTabView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI

struct NYTRootTabView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TabView {
            NYTHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            NYTLikedArticlesView(context: modelContext)
                .tabItem {
                    Label("Liked", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    NYTRootTabView()
}
