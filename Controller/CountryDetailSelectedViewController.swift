//
//  ViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 17..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import MapKit

// 맵
class CountryDetailSelectedViewController: UIViewController {
    
    let cellIdentifier: String = "countryCell"
    let regionRadius: CLLocationDistance = 10000
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    let bulletBoardTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    let mapView: MKMapView = {
        let view = MKMapView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.bulletBoardTableView.register(PartnersTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(mapView)
        self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mapView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        self.centerMapOnLocation(location: initialLocation)
        self.mapView.delegate = self
        
        let artwork = Artwork(title: "goh sangbum",
                              locationName: "Waikiki Gateway Park",
                              discipline: "looking for someone who can understand me",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        let artwork2 = Artwork(title: "yonghyun",
                              locationName: "soongsil univ",
                              discipline: "looking for someone who can understand me",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831660))
        let artwork3 = Artwork(title: "william",
                              locationName: "highway",
                              discipline: "looking for someone who can understand me",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        mapView.addAnnotation(artwork)
        mapView.addAnnotation(artwork2)
        mapView.addAnnotation(artwork3)
        
        self.bulletBoardTableView.dataSource = self
        self.bulletBoardTableView.delegate = self
        
        UISetUp()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)

}

}

extension CountryDetailSelectedViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    
    func UISetUp() {
        self.view.addSubview(bulletBoardTableView)
        
        self.bulletBoardTableView.topAnchor.constraint(equalTo: self.mapView.bottomAnchor).isActive = true
        self.bulletBoardTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.bulletBoardTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.bulletBoardTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}

extension CountryDetailSelectedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PartnersTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PartnersTableViewCell else {return UITableViewCell.init()}
        
        cell.profileImageView.image = #imageLiteral(resourceName: "IMG_0596")
        cell.memberNameLabel.text = "상순이"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC: PartnerDetailInfoViewController = PartnerDetailInfoViewController()
        self.navigationController?.present(VC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    
    
    

}
