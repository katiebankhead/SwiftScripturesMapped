//
//  ScripturesMappedView.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 11/18/21.
//

import SwiftUI
import MapKit

struct ScripturesMappedView: View {
    
    @EnvironmentObject var viewModel: GeoPlaceViewModel
    
    var body: some View {
        NavigationView {
            VolumesView()
                .navigationTitle("Scriptures Mapped")
            PrimaryDetailView()
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ScripturesMappedView()
    }
}
