//
//  MapViewController.swift
//  Navigation
//
//  Created by Misha Causur on 08.09.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let locationManager = CLLocationManager()
    
    private var locations = [CLLocationCoordinate2D]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        requestAccessToGeo()
        setupViews()
    }
    
    
    private func configureLocationManager() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(pinLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func pinLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state == .began {
            
            let touchPoint = gestureRecognizer.location(in: mapView)
            let touchCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinates
            annotation.title = "Точка"
            annotation.subtitle = "Новая точка на карте"
            self.mapView.addAnnotation(annotation)
            locations.append(touchCoordinates)
        }
    }
    
    private func requestAccessToGeo() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            let alert = UIAlertController(
                title: "Локация недоступна",
                message: "Требуется доступ к геолокации",
                preferredStyle: .alert
            )
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.present(alert, animated: true, completion: nil)
            }
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        @unknown default:
            break
        }
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        [mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)].forEach { $0.isActive = true }
    }
    
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("failed to update \(error)")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "marker")
        annotationView.markerTintColor = UIColor.blue
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.red
        render.lineWidth = 10
        render.fillColor = UIColor(red: 0, green: 0.7, blue: 0.9, alpha: 0.5)
        render.lineCap = .round
        
        return render
    }
}
