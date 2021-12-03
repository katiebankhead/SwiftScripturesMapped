//
//  ChapterGridView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/2/21.
//

import SwiftUI

struct ChapterGridView: View {
    var book: Book
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(
                                    repeating: GridItem(.flexible(), spacing: 0),
                                    count: 6
            ),
                      spacing: 8) {
                ForEach(1...(book.numChapters ?? 0), id: \.self) { chapter in
                    NavigationLink("\(chapter)") {
                        ChapterContentView(book: book, chapter: chapter)
                    }
                    .isDetailLink(false)
                }
            }
        }
    }
}

//struct ChapterGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChapterGridView()
//    }
//}
