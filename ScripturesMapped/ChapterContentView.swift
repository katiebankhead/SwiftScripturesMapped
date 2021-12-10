//
//  ChapterContentView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/2/21.
//

import SwiftUI
import MapKit

struct ChapterContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State private var displayMapView = false
    
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
                if !viewModel.isDetailVisible {
                    displayMapView = true
                } else {
                    displayMapView = false
                }
                viewModel.focusOnGeoPlaceId(geoPlaceId)
            }
            .onAppear {
                viewModel.setGeocodedPlaces(ScriptureRenderer.shared.geoPlaces(for: book, chapter: chapter))
            }
            .navigationBarTitle(title())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Group {
                    if !viewModel.isDetailVisible {
                        Button(action: {
                            displayMapView = true
                        }, label: {
                            Image(systemName: "map")
                        })
                    }
                }
            )

            .sheet(isPresented: $displayMapView) {
                HStack {
                    Button(action: {
                        displayMapView = false
                    }, label: {
                        Image(systemName: "chevron.down")
                    })
                }.padding()
                MapView()
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

struct PrimaryDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        GeometryReader { geometry in
            MapView()
                .onAppear {
                    print("geometry.size: \(geometry.size.height)")
                    viewModel.isDetailVisible = geometry.frame(in: .global).maxY > 0
                }
        }
    }
}

struct MapView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        Map(coordinateRegion: $viewModel.region, annotationItems: viewModel.geoPlaces) { geoPlace in
                MapAnnotation(
                    coordinate: geoPlace.coordinate,
                    anchorPoint: CGPoint(x: 0.5, y: 1)) {
                        HStack {
                            Image(systemName: "mappin")
                                .foregroundColor(Color(red: 0.7, green: 0.1, blue: 0.1))
                                .shadow(radius: 2, x: 1, y: 1)
                            Text(geoPlace.placename)
                        }
                        
                        
                    }
            }
        .navigationTitle("Testing title")
        .edgesIgnoringSafeArea(.all)
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
