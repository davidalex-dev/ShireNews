// View for placeholder screen (no articles/no bookmark)

import SwiftUI

struct PlaceholderView: View{
    
    let text: String
    let image: Image?
    
    var body: some View{
        VStack(spacing:8){
            Spacer()
            if let image = self.image{
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
    
}

struct PlaceholderView_Previews: PreviewProvider{
    static var previews: some View{
        PlaceholderView(text: "No Bookmarks", image: Image(systemName: "bookmark"))
    }
}
