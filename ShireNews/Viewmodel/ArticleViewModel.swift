// View model for Article

import SwiftUI

enum DataFetchPhase<T>{
    case empty
    case success(T)
    case failure(Error)
}

struct FetchTaskToken: Equatable{
    var category: Category
    var token: Date
}

@MainActor
class ArticleViewModel: ObservableObject{
    // Initializers
    /// For news article
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newsAPI = NewsAPI.shared
    
    /// For search function
    @Published var searchQuery = ""
    private var trimmedSearchQuery: String{
        searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Init function
    init(articles: [Article]? = nil, selectedCategory: Category = .general){
        if let articles = articles {
            self.phase = .success(articles)
        }else{
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    // Loading articles
    
    func loadArticles() async{
        // For test and debugging purposes only
        //phase = .success(Article.previewData)
        
        // No Articles
        // phase = .empty
        // phase = .success([])
        
        if Task.isCancelled{return}
        phase = .empty
        do{
            let articles = try await newsAPI.fetch(for: fetchTaskToken.category)
            if Task.isCancelled{return}
            phase = .success(articles)
        }catch{
            if Task.isCancelled{return}
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
    
    // Search Function
    func searchArticle() async{
        if Task.isCancelled{return}
        
        let searchQuery = trimmedSearchQuery
        phase = .empty
        
        if searchQuery.isEmpty{
            return
        }
        
        do{
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled{return}
            if searchQuery != trimmedSearchQuery{
                return
            }
            phase = .success(articles)
        }catch{
            if Task.isCancelled {return}
            if searchQuery != trimmedSearchQuery{
                return
            }
            phase = .failure(error)
        }
        
    }
    
}
