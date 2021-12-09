//
//  ViewModel.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/6/21.
//

import Foundation

class ViewModel: ObservableObject, GeoPlaceCollector {
    
    @Published var geoPlaces = [GeoPlace]()
    
    func focusOnGeoPlaceId(_ geoPlaceId: Int) {
        // TODO: zoom in on selected pin?
    }
    
    func setGeocodedPlaces(_ places: [GeoPlace]?) {
        if let places = places {
            var newPlaces = [GeoPlace]()
            
            places.forEach { p in
                let matchedPlaceIndex = newPlaces.firstIndex { newPlace in
                    newPlace.isEqualToPlace(p)
                }
                
                if matchedPlaceIndex != nil {
                    if !newPlaces[matchedPlaceIndex!].placename.contains(p.placename) {
                        newPlaces[matchedPlaceIndex!].placename.append(", \(p.placename)")
                    }
                } else {
                    newPlaces.append(p)
                }
            }
            
            // replace geoPlaces with new locations
            geoPlaces = newPlaces
        }
    }
}
