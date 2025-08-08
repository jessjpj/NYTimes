//
//  NYTRootTabView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI

struct NYTRootTabView: View {
    var body: some View {
        TabView {
            NYTHomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            NYTLikedArticlesView()
                .tabItem {
                    Label("Liked", systemImage: "heart.fill")
                }
        }
    }
}

#Preview {
    NYTRootTabView()
}
