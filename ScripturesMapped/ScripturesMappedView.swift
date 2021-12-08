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
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.778389,
                                       longitude: 35.234736),
        span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
    )
    
    var body: some View {
        NavigationView {
            VolumesView()
                .navigationTitle("Scriptures Mapped")
            Map(coordinateRegion: $region, annotationItems: viewModel.geoPlaces) { geoPlace in
                    MapAnnotation(
                        coordinate: geoPlace.coordinate,
                        anchorPoint: CGPoint(x: 0.5, y: 1)) {
                            Image(systemName: "mappin")
                                .foregroundColor(Color(red: 0.7, green: 0.1, blue: 0.1))
                                .shadow(radius: 2, x: 1, y: 1)
                        }
                }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
