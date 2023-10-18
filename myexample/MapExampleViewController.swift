//
//  MapExampleViewController.swift
//  myexample
//
//  Created by Luis Humberto Carlin Vargas on 18/10/23.
//

import UIKit
import MapKit


class MapExampleViewController: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!


    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        fetchRandomUsers()
        // Do any additional setup after loading the view.
    }
    
    func fetchRandomUsers() {
        let apiUrlString = "https://randomuser.me/api/?results=10"
        guard let apiUrl = URL(string: apiUrlString) else { return }

        URLSession.shared.dataTask(with: apiUrl) { (data, _, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else { return }

            do {
                let userData = try JSONDecoder().decode(UserData.self, from: data)
                for user in userData.results {
                    self.addAnnotation(for: user)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    
    func addAnnotation(for user: User) {
        let annotation = MKPointAnnotation()
        annotation.title = "\(user.name.first) \(user.name.last)"
        if let latitude = Double(user.location.coordinates.latitude),
           let longitude = Double(user.location.coordinates.longitude) {
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(annotation)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
