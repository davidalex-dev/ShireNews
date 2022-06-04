// Safari Browser View
// For news browsing

import SwiftUI
import SafariServices

struct BrowserView: UIViewControllerRepresentable{
    
    let url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
