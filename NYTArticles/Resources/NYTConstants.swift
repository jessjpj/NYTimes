//
//  NYTConstants.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//


import SwiftUI

enum NYTConstants {
    
    enum Strings {
        static let appName = "NYT Articles"
        static let homeTitle = "Top Articles"
        static let likedTitle = "Liked Articles"
        static let detailsTitle = "Details"
        static let like = "Like"
        static let unlike = "Unlike"
    }
    
    enum ImageNames {
        static let shareIconName = "square.and.arrow.up"
        static let likeIconName = "heart"
        static let likedIconName = "heart.fill"
        static let filterIconName = "line.3.horizontal.decrease.circle"
        static let calendarIconName = "calendar"
        static let chevronRightIconName = "chevron.right"
        static let photoPlaceholderIconName = "photo"
    }
    
    enum Colors {
        static let likeButtonBackground = Color.blue.opacity(0.1)
        static let chevronColor = Color.gray
        static let placeholderIconColor = Color.gray.opacity(0.5)
    }
    
    enum Layout {
        static let imageSize: CGFloat = 80
        static let cornerRadius: CGFloat = 8
        static let detailImageCornerRadius: CGFloat = 12
        static let verticalPadding: CGFloat = 8
        static let contentSpacing: CGFloat = 16
        static let buttonCornerRadius: CGFloat = 10
        static let imagePadding: CGFloat = 20
    }

    enum LineLimit {
        static let limit2 = 2
    }
}


