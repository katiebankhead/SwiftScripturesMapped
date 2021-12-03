//
//  ScripturesMappedView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 11/18/21.
//

import SwiftUI
import MapKit

struct ScripturesMappedView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.778389,
                                       longitude: 35.234736),
        span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
    )
    
    var body: some View {
        NavigationView {
            VolumesView()
                .navigationTitle("Scriptures Mapped")
            Map(coordinateRegion: $region)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
