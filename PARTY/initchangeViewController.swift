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
    @IBOutlet weak var partycontinebtn: UIButton!

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
        

        self.performSegueWithIdentifier("thatsit", sender: self)
        
        
            
        
    
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          let borderAlpha : CGFloat = 0.7
        let tapped = UITapGestureRecognizer(target: self, action: "imageTapped:")
        imageview.addGestureRecognizer(tapped)
        imageview.userInteractionEnabled = true
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        border.frame = CGRect(x: 0, y: usernamechange.frame.size.height - width, width:  usernamechange.frame.size.width, height: usernamechange.frame.size.height)
        
        border.borderWidth = width
        usernamechange.layer.addSublayer(border)
        usernamechange.layer.masksToBounds = true
        
        //buttondesign 
        let button = partycontinebtn
        let cornerRadius : CGFloat = 5.0
        
        button.frame = CGRectMake(100, 100, 200, 40)
        button.setTitle("Let's get started", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.backgroundColor = UIColor.clearColor()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        button.layer.cornerRadius = cornerRadius
        
        //the image design 
        imageview.layer.cornerRadius = imageview.frame.size.width/2
        imageview.clipsToBounds = true
        imageview.layer.masksToBounds = true
        
       imageview.layer.borderColor = UIColor.whiteColor().CGColor
        imageview.layer.borderWidth = 2.0
        
       let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
    view.addGestureRecognizer(tap)
   
        // Do any additional setup after loading the view.
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
    //button design

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
