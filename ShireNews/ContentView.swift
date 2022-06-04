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
                    Label("Bookmarks", systemImage: "newspaper")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
