//
//  ViewModel.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/6/21.
//

import Foundation

class ViewModel: ObservableObject, GeoPlaceCollector {
    
    @Published var geoPlaces = [GeoPlace]()
    
    init() {
//        ScriptureRenderer.shared.injectGeoPlaceCollector(self)
    }
    
    func focusOnGeoPlaceId(_ geoPlaceId: Int) {
        // TODO: zoom in on selected pin?
    }
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        if let places = places {
            // TODO: only copy over unique geoPlaces (go off of lat/long, not just name)
            geoPlaces = places
            
            geoPlaces.forEach { place in
                print(place.placename)
            }
        }
    }
}
