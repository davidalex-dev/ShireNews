// Main view with tabs

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            NewsTabView()
                .tabItem{
                    Label("News", systemImage: "newspaper")
                }
            
            BookmarkView()
                .tabItem{
                    //system icon for saved; placeholder
                    Label("Bookmarks", systemImage: "bookmark")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @StateObject static var bookmarkVM = BookmarkViewModel.shared
    
    static var previews: some View {
        ContentView()
            .environmentObject(bookmarkVM)
    }
}
