//
//  ViewModel.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 12/6/21.
//

import Foundation
import MapKit

class ViewModel: ObservableObject, GeoPlaceCollector {
    
    @Published var geoPlaces = [GeoPlace]()
    @Published var isDetailVisible: Bool = false
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 31.778389,
                                       longitude: 35.234736),
        span: MKCoordinateSpan(latitudeDelta: 3, longitudeDelta: 3)
    )
    let defaultLatitude: Double = 31.778389
    let defaultLongitude: Double = 35.234736
    let defaultSpan: Double = 3
    
    func focusOnGeoPlaceId(_ geoPlaceId: Int) {
        let selectedPin = geoPlaces.first { $0.id == geoPlaceId }
        var pinSpan: Double = defaultSpan
        
        let pinLat = selectedPin?.latitude ?? defaultLatitude
        let pinLng = selectedPin?.longitude ?? defaultLongitude

        if selectedPin != nil {
            pinSpan = 0.05
        }
        
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: pinLat,
                                           longitude: pinLng),
            span: MKCoordinateSpan(latitudeDelta: pinSpan, longitudeDelta: pinSpan)
        )
        
        self.region = region
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
            zoomMapToFitPins()
        }
    }
    
    func zoomMapToFitPins() -> Void {
        var minLat: Double = defaultLatitude
        var maxLat: Double = defaultLatitude
        var minLng: Double = defaultLongitude
        var maxLng: Double = defaultLongitude
        
        // for each place, extend bounds
        geoPlaces.forEach { pin in
            if pin.latitude < minLat {
                minLat = pin.latitude
            } else if pin.latitude > maxLat {
                maxLat = pin.latitude
            }
            
            if pin.longitude < minLng {
                minLng = pin.longitude
            } else if pin.longitude > maxLng {
                maxLng = pin.longitude
            }
            
            // set viewModel latitude and longitude values
            let centerLatitude = (minLat + maxLat) / 2
            let centerLongitude = (minLng + maxLng) / 2
            
            // set lat/lng delta values for span
            let latDelta = maxLat - minLat
            let lngDelta = maxLng - minLng
            
            // set region
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: centerLatitude,
                                               longitude: centerLongitude),
                span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lngDelta)
            )
            
            self.region = region
        }
    }
}
