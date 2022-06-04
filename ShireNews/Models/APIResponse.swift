// Respons untuk API NewsAPI

import Foundation

struct APIResponse: Decodable{
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
    
}
