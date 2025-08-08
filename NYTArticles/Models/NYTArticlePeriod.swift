//
//  NYTArticlePeriod.swift
//  NYTArticles
//
//  Created by Jeslin Johnson on 08/08/2025.
//

import Foundation

enum NYTArticlePeriod: Int, CaseIterable, Identifiable {
    case oneDay = 1
    case sevenDays = 7
    case thirtyDays = 30

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .oneDay: return "1 Day"
        case .sevenDays: return "7 Days"
        case .thirtyDays: return "30 Days"
        }
    }
}
