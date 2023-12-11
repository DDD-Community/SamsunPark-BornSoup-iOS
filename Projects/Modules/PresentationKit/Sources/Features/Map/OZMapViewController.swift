//
//  OZMapViewController.swift
//  PresentationKit
//
//  Created by 신의연 on 12/11/23.
//  Copyright © 2023 kr.ddd.ozeon. All rights reserved.
//

import UIKit
import SwiftUI
import MapKit

protocol OZMapViewDelegate: AnyObject {
    func didRegionChanged(location: MKCoordinateRegion)
    func didVisibleRectChanged(visibleRect: MKMapRect)
}

class OZMapViewController: UIViewController {
    var region: MKCoordinateRegion = .init()
    let mapView : MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }()
    var locationManager = CLLocationManager()
    var annotations: [ContentsAnnotation] = []
    var mapDelegate: OZMapViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.region = self.region
        mapView.delegate = self
        setUpLocationManager()
        setLayout()
    }
    
    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            locationManager.requestLocation()
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    private func setLayout() {
        self.view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setAnnotation() {
        
    }
}

extension OZMapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("update")
        
        locations.last.map {
            let currentCoordinate = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
            mapDelegate.didRegionChanged(location: currentCoordinate)
            mapView.region = currentCoordinate
            manager.stopUpdatingLocation()
        }
    }
}

extension OZMapViewController: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        mapDelegate.didRegionChanged(location: mapView.region)
        mapDelegate.didVisibleRectChanged(visibleRect: mapView.visibleMapRect)
    }
}
