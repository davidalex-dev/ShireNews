//
//  ShireNewsApp.swift
//  ShireNews
//
//  Created by Nova on 04/06/22.
//

import SwiftUI

@main
struct ShireNewsApp: App {
    @StateObject var bookmarkVM = BookmarkViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookmarkVM)
        }
    }
}
