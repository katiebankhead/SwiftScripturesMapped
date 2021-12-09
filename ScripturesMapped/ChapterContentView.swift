//
//  ChapterContentView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/2/21.
//

import SwiftUI

struct ChapterContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var book: Book
    var chapter: Int
    
    private var html: String
    
    init(book: Book, chapter: Int) {
        self.book = book
        self.chapter = chapter
        
        html = ScriptureRenderer.shared.htmlForBookId(book.id, chapter: chapter)
    }
    
    var body: some View {
        WebView(html: html, request: nil)
            .injectNavigationHandler { geoPlaceId in
                print("user selected \(geoPlaceId)")
                viewModel.focusOnGeoPlaceId(geoPlaceId)
            }
            .navigationBarTitle(title())
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.setGeocodedPlaces(ScriptureRenderer.shared.geoPlaces(for: book, chapter: chapter))
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
