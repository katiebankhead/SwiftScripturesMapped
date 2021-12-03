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
    
    private var html: String
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
        html = ScriptureRenderer.shared.htmlForBookId(book.id, chapter: chapter)
    }
    
    var body: some View {
        ScrollView {
            WebView(html: html, request: nil)
        }
    }
}

//struct ChapterContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChapterContentView()
//    }
//}
