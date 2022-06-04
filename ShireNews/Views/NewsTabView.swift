// Tab view for article

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleVM = ArticleViewModel()
    
    var body: some View {
        NavigationView{
            
            ListView(articles: articles)
                .overlay(overlayView)
                .onAppear{
                    async{
                        await articleVM.loadArticles()
                    }
                }
                .navigationTitle("The Shire News")
            
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View{
        
        switch articleVM.phase{
            case .empty: ProgressView()
            
            case .success(let articles) where articles.isEmpty:
                PlaceholderView(text: "No articles", image:nil)
            
            case .failure(let error):
                RetryView(text: error.localizedDescription){
                    //refresh the API
                }
            
            default: EmptyView()
        }
        
    }
    
    private var articles: [Article]{
        if case let .success(articles) = articleVM.phase{
            return articles
        }else{
            return []
        }
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleVM: ArticleViewModel(articles: Article.previewData))
    }
}
