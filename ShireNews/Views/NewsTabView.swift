// Tab view for article

import SwiftUI

struct NewsTabView: View {
    
    @StateObject var articleVM = ArticleViewModel()
    
    var body: some View {
        NavigationView{
            
            ListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleVM.fetchTaskToken, loadArticle)
                .refreshable(action: refreshList)
                .navigationTitle("The Shire News")
            
        }
    }
    
    @ViewBuilder
    private var overlayView: some View{
        
        switch articleVM.phase{
            case .empty: ProgressView()
            
            case .success(let articles) where articles.isEmpty:
                PlaceholderView(text: "No articles... yet.", image:Image(systemName: "newspaper"))
            
            case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshList)
            
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
    
    private func loadArticle() async{
        await articleVM.loadArticles()
    }
    
    private func refreshList(){
        articleVM.fetchTaskToken = FetchTaskToken(category: articleVM.fetchTaskToken.category, token: Date())
    }
    
}

struct NewsTabView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = BookmarkViewModel.shared
    static var previews: some View {
        NewsTabView(articleVM: ArticleViewModel(articles: Article.previewData))
            .environmentObject(bookmarkVM)
    }
}
