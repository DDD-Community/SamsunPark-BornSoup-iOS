//
//  OZMapView.swift
//  PresentationKit
//
//  Created by 신의연 on 12/11/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import SwiftUI
import MapKit

struct OZMapView: UIViewControllerRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var visibleRect: MKMapRect
    var annotations: [ContentsAnnotation]
    
    func makeUIViewController(context: Context) -> OZMapViewController {
        let mapVC = OZMapViewController()
        mapVC.mapDelegate = context.coordinator
        mapVC.annotations = self.annotations
        return mapVC
    }
    
    func updateUIViewController(_ uiViewController: OZMapViewController, context: Context) {
    }
    
    class Coordinator: OZMapViewDelegate {
        @Binding var region: MKCoordinateRegion
        @Binding var visibleRect: MKMapRect
        
        init(
            region: Binding<MKCoordinateRegion>,
            visibleRect: Binding<MKMapRect>
        ) {
            self._region = region
            self._visibleRect = visibleRect
        }
        
        func didRegionChanged(location: MKCoordinateRegion) {
            self.region = location
        }
        
        func didVisibleRectChanged(visibleRect: MKMapRect) {
            self.visibleRect = visibleRect
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(region: $region, visibleRect: $visibleRect)
    }
}

