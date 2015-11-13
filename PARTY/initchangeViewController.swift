//
//  initchangeViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/23/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse

class initchangeViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageview: UIImageView!
   
    @IBOutlet weak var usernamechange: UITextField!
    
    @IBAction func that(sender: AnyObject) {
        
       
        
        _ = PFQuery(className: "User")
        PFUser.currentUser()?.setObject(usernamechange.text!, forKey: "username")
        PFUser.currentUser()?.saveEventually()
        
        var imageData = UIImageJPEGRepresentation(imageview.image!,1.0)
        
        let parseImagedFile = PFFile(data: imageData!)
        imageData = imageview.image?.lowestQualityJPEGNSData
        //let userimagepost = PFObject(className: "User")
     
        //userimagepost["profileimage"] = parseImagedFile
        
        PFUser.currentUser()?.setObject(parseImagedFile, forKey: "profileimage")
        PFUser.currentUser()?.saveInBackground()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        self.performSegueWithIdentifier("thatsit", sender: self)
        
        
            
        
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapped = UITapGestureRecognizer(target: self, action: "imageTapped:")
        imageview.addGestureRecognizer(tapped)
        imageview.userInteractionEnabled = true
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: usernamechange.frame.size.height - width, width:  usernamechange.frame.size.width, height: usernamechange.frame.size.height)
        
        border.borderWidth = width
        usernamechange.layer.addSublayer(border)
        usernamechange.layer.masksToBounds = true
   
        // Do any additional setup after loading the view.
    }
    
    
    func imageTapped(gesture: UIGestureRecognizer) {
        if let _ = gesture.view as? UIImageView {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageview.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    
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
