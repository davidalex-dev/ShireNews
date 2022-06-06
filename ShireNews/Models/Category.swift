// News Category
// List of Categories:
// - General
// - Business
// - Technology
// - Entertainment
// - Sports
// - Health
// - Science

import Foundation
import UIKit

enum Category: String, CaseIterable{
    case general
    case business
    case technology
    case entertainment
    case sports
    case health
    case science
    
    var text: String{
        if self == .general{
            return "All Topics"
        }
        return rawValue.capitalized
    }
    
}

extension Category: Identifiable{
    var id: Self { self }
}
