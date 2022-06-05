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
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    //@Published var selectedCategory : Category
    @Published var fetchTaskToken: FetchTaskToken
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general){
        if let articles = articles {
            self.phase = .success(articles)
        }else{
            self.phase = .empty
        }
        //self.selectedCategory = selectedCategory
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async{
        // For test and debugging purposes only
        //phase = .success(Article.previewData)
        
        //        // No Articles
        //        phase = .empty
        //        phase = .success([])
        
        if Task.isCancelled{return}
        phase = .empty
        do{
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled{return}
            phase = .success(articles)
        }catch{
            if Task.isCancelled{return}
            print(error.localizedDescription)
            phase = .failure(error)
        }
        
    }
    
}
