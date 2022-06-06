//
//  BookmarkView.swift
//  ShireNews
//
//  Created by Nova on 04/06/22.
//

import SwiftUI

struct BookmarkView: View {
    
    @EnvironmentObject var bookmarkVM: BookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        let articles = self.showList
        
        NavigationView{
            ListView(articles: articles)
                .overlay(overlayView(isEmpty: bookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Bookmarks")
                .searchable(text: $searchText)
        }
        
    }
    
    private var showList: [Article]{
        if searchText.isEmpty{
            return bookmarkVM.bookmarks
        }
        
        return bookmarkVM.bookmarks
            .filter{
                $0.title.lowercased()
                    .contains(searchText.lowercased())
            }
        
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View{
        if isEmpty{
            PlaceholderView(text: "No saved articles", image: Image(systemName: "bookmark"))
        }
    }
    
}

struct BookmarkView_Previews: PreviewProvider {
    
    @StateObject static var bookmarkVM = BookmarkViewModel.shared
    
    static var previews: some View {
        
        BookmarkView()
            .environmentObject(bookmarkVM)
        
    }
}
