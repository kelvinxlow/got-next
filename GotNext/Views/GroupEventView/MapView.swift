//
//  MapView.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-16.
//

import MapKit
import SwiftUI


struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

