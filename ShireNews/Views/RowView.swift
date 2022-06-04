// Row view for news article

import SwiftUI

struct RowView: View {
    
    let article: Article
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16){
            AsyncImage(url: article.imageURL){
                phase in
                
                switch phase{
                    
                case .empty:
                    HStack{
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                case .failure:
                    HStack{
                        Spacer()
                        Image(systemName: "photo")
                            .imageScale(.large)
                        Spacer()
                    }
                
                @unknown default:
                    fatalError()
                    
                }
                
            }
            .frame(minHeight: 200, maxHeight: 300)
    
            .background(Color.gray.opacity(0.3))
            .clipped()
            
            VStack(alignment: .leading, spacing: 8){
                Text(article.title)
                    .font(.headline)
                    .lineLimit(3)
                
                HStack{
                    Text(article.captionText)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Button{
                        
                    } label: {
                        Image(systemName: "bookmark")
                    }
                    .buttonStyle(.borderless)
                    .padding(.horizontal, 20)
                    
                    Button{
                        presentShareSheet(url: article.articleURL)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.borderless)
                    
                }
                
            }
            .padding([.horizontal, .bottom])
            
        }
        
    }
}

extension View {
    
    func presentShareSheet(url: URL){
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
    
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            List{
                RowView(article: .previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        
        
    }
}
