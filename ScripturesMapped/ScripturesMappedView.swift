//
//  ScripturesMappedView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 11/18/21.
//

import SwiftUI
import MapKit

struct ScripturesMappedView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VolumesView()
                .navigationTitle("Scriptures Mapped")
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
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("Testing title")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
