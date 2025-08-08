//
//  NYTLaunchView.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import SwiftUI

struct NYTLaunchView: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            NYTRootTabView()
        } else {
            VStack {
                Image("AppIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                Text(NYTConstants.Strings.appName)
                    .font(NYTFonts.title)
                    .bold()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

