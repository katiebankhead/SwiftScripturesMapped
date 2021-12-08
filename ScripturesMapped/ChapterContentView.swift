//
//  ChapterContentView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/2/21.
//

import SwiftUI

struct ChapterContentView: View {
    
    var book: Book
    var chapter: Int
    
    private var html: String {
        ScriptureRenderer.shared.htmlForBookId(book.id, chapter: chapter)
    }
    
    var body: some View {
        ScrollView {
//            WebView(html: html, request: nil)
//                .navigationTitle(title())
//                .navigationBarTitleDisplayMode(.inline)
            Text(html)
        }
    }
    
    private func title() -> String {
        if chapter > 0 {
            return "\(book.fullName) \(chapter)"
        } else {
            return book.fullName
        }
    }
}

struct ChapterContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChapterContentView(
                book: GeoDatabase.shared.bookForId(106),
                chapter: 10)
        }
    }
}
