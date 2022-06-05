// List View for News Article

import SwiftUI

struct ListView: View {
    
    let articles: [Article]
    @State private var selectedArticle: Article?
    @EnvironmentObject var bookmarkVM: BookmarkViewModel
    
    var body: some View {
        List{
            ForEach(articles) { article in
                RowView(article: article)
                    .onTapGesture{
                        selectedArticle = article
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .sheet(item: $selectedArticle){
            BrowserView(url: $0.articleURL)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = BookmarkViewModel.shared
    static var previews: some View {
        NavigationView{
            ListView(articles: Article.previewData)
                .environmentObject(bookmarkVM)
        }
    }
}
