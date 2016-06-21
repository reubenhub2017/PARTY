//
//  newpartiesViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/18/15.
//  Copyright (c) 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse
import Foundation
import CoreLocation
import MapKit

class newpartiesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
CLLocationManagerDelegate {
    @IBOutlet weak var privacyswitch: UISwitch!
    
    
    @IBOutlet weak var newpartyuserimage: UIImageView!
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    
    
    
    @IBAction func cancelpressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBOutlet weak var titleofparty: UITextField!
    
    @IBOutlet weak var descofparty: UITextView!
    @IBOutlet weak var strtimeofparty: UITextField!
    
    
    @IBOutlet weak var ImagePreview: UIImageView!
    
    @IBAction func imageupload(sender: AnyObject) {
        
        
        
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        
        
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        ImagePreview.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if(locations.count != 0){
            let location = locations[0] as CLLocation
            
            currentLocation = location.coordinate
        } else {
            print("Cannot fetch your location")
        }
    }
    @IBAction func cancelbtn(sender: AnyObject) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
    
    
    }
    @IBAction func finishpressed(sender: AnyObject) {
        let post = PFObject(className: "parties")
        let userhost = PFUser.currentUser()!
        //we are going to post the data to Parse : Classname Parties
        if privacyswitch.on {
        post["privacy"] = true
        }
        else {
        post["privacy"] = false
        }

        post["title"] = titleofparty.text
        post["description"] = descofparty.text
        post["attending"] = 0
        post["partyhost"] = PFUser.currentUser()
        post["username"] = PFUser.currentUser()?.username
        post["location"] = PFGeoPoint(latitude: currentLocation!.latitude, longitude: currentLocation!.longitude)
        userhost.incrementKey("hostednumber")
        
        
        post.saveInBackground()
        userhost.saveInBackground()
        
        
        userhost.incrementKey("hostednumber")
      
        self.dismissViewControllerAnimated(true, completion: nil)
        
       
      
    }
  
 
    
   
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    
    
    
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .Plain, target: nil, action: nil)
        
        newpartyuserimage.layer.cornerRadius = newpartyuserimage.layer.frame.size.width/2
        newpartyuserimage.clipsToBounds = true
        newpartyuserimage.layer.masksToBounds = true
        
        newpartyuserimage.layer.borderColor = UIColor.blackColor().CGColor
        newpartyuserimage.layer.borderWidth = 1.0
        
        
        if let userPicture = PFUser.currentUser()!["profileimage"] as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    self.newpartyuserimage.image = UIImage(data:imageData!)
                    
                }
            }
            
        }
        
    
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    func displayMessage(theMesssage:String)
    {
        // Display alert message with confirmation.
        let myAlert = UIAlertController(title:"Party Notification", message:theMesssage, preferredStyle: UIAlertControllerStyle.Alert);let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion:nil);
        }
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil);
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
