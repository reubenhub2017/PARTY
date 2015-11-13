//
//  locationuploadViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/20/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import MapKit

class locationuploadViewController: newpartiesViewController, UISearchBarDelegate  {
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
   
    
    
    @IBAction func showSearchBar(sender: AnyObject) {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
        
    }
 
    @IBOutlet weak var mapView: MKMapView!
    
    
  
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)  {
        
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if self.mapView.annotations.count != 0 {
        annotation = self.mapView.annotations[0] as MKAnnotation
        self.mapView.removeAnnotation(annotation)
        
        }
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        
        

        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.startWithCompletionHandler{(localSearchResponse, error) -> Void in
            if localSearchResponse == nil {
                if localSearchResponse == nil {
                    let alert = UIAlertView(title: nil, message: "Place not found", delegate: self,
                        cancelButtonTitle: "Try Again")
                    alert.show()
                    return
            
            }
        }
        self.pointAnnotation = MKPointAnnotation()
        self.pointAnnotation.title = searchBar.text
        let locationupload = PFObject(className: "parties")
            locationupload["location"] = searchBar.text
            
            
        self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
        self.pinAnnotationView = MKPinAnnotationView(annotation:self.pointAnnotation, reuseIdentifier: nil)
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            
            
        }
        
        
        
        
        
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
