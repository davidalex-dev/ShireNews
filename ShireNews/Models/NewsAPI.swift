// API for NewsAPI.org

import Foundation

struct NewsAPI{
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "192070063bf3444dbc99cbaa0e4468f9"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
       let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func fetch(for category: Category) async throws -> [Article]{
        try await fetchArticles(from: generateURL(from: category))
    }
    
    func search(for query: String) async throws -> [Article]{
        try await fetchArticles(from: generateSearchURL(from: query))
    }
    
    private func fetchArticles(from url: URL) async throws -> [Article]{
        let (data, response) = try await session.data(from: url)
        
        guard let response = response as? HTTPURLResponse else{
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode{
            case (200...299), (400...499):
                let apiResponse = try jsonDecoder.decode(APIResponse.self, from:data)
                
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            }else{
                throw generateError(description: apiResponse.message ?? "Error")
            }
            
            default:
                throw generateError(description: "Error")
                
            }
    }
    
    //    func fetch(from category: Category) async throws -> [Article] {
    //        let url = generateURL(from: category)
    //
    //        let (data, response) = try await session.data(from: url)
    //
    //        guard let response = response as? HTTPURLResponse else{
    //            throw generateError(description: "Bad Response")
    //        }
    //
    //        switch response.statusCode{
    //            case (200...299), (400...499):
    //                let apiResponse = try jsonDecoder.decode(APIResponse.self, from:data)
    //
    //            if apiResponse.status == "ok" {
    //                return apiResponse.articles ?? []
    //            }else{
    //                throw generateError(description: apiResponse.message ?? "Error")
    //            }
    //
    //            default:
    //                throw generateError(description: "Error")
    //
    //            }
    //
    //
    //    }
    
    private func generateError(code: Int = 1, description: String) -> Error{
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    }
    
    private func generateURL(from category: Category) -> URL{
        var url = "https://newsapi.org/v2/top-headlines"
        url += "?country=id"
        url += "&apiKey=\(apiKey)"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    }
    
    private func generateSearchURL(from query: String) -> URL{
        let searchString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        var url = "https://newsapi.org/v2/top-headlines"
        url += "?country=id"
        url += "&apiKey=\(apiKey)"
        //url += "&category=\(category.rawValue)"
        url += "&q=\(searchString)"
        return URL(string: url)!
    }
    
}
