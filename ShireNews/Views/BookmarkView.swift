//
//  BookmarkView.swift
//  ShireNews
//
//  Created by Nova on 04/06/22.
//

import SwiftUI

struct BookmarkView: View {
    
    @EnvironmentObject var bookmarkVM: BookmarkViewModel
    
    var body: some View {
        NavigationView{
            ListView(articles: bookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: bookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Bookmarks")
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
    
    @StateObject static var bookmarkVM = BookmarkViewModel()
    
    static var previews: some View {
        
        BookmarkView()
            .environmentObject(bookmarkVM)
        
    }
}
