//
//  profileTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/3/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class profileTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var pimage: UIImageView!
   
    @IBOutlet weak var addtocontacts: UIButton!

    @IBOutlet weak var pname: UILabel!
    
    

    @IBAction func editpic(sender: AnyObject) {
 
           
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.allowsEditing = false
        self.presentViewController(imagePicker, animated: true, completion: nil)
            
      
        
        
      

        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
           let currentU = PFUser.currentUser()?.objectId
        var imageData = UIImageJPEGRepresentation(pimage.image!,1.0)
        
        let parseImagedFile = PFFile(data: imageData!)
        imageData = pimage.image?.lowestQualityJPEGNSData
        
        var query = PFUser.query()
        query!.getObjectInBackgroundWithId(currentU!) {
            (query: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let gameScore = query {
                gameScore["profileimage"] = parseImagedFile
                gameScore.saveInBackground()
                self.dismissViewControllerAnimated(true, completion: nil)
                 self.displayMessage("We updated your picture, it will take a few moments to update our system!")
                self.pimage.image = image
                
                
            }
        }
        
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
    
        
        
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    pimage.layer.cornerRadius = self.pimage.frame.size.width/2
    pimage.clipsToBounds = true
    pimage.layer.masksToBounds = true
        
    pimage.layer.borderColor = UIColor.blackColor().CGColor
    pimage.layer.borderWidth = 1.0
        
        
      
        if let userPicture = PFUser.currentUser()!["profileimage"] as? PFFile {
            userPicture.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
                if (error == nil) {
                    self.pimage.image = UIImage(data:imageData!)
                }
            }
        }
        
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        navigationItem.title =  PFUser.currentUser()!.username!
        //pname.text! = PFUser.currentUser()!.username!
        
        
    }
    
    @IBOutlet weak var hostnumber: UILabel!
    @IBOutlet weak var attendednumber: UILabel!
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
        //pname.text! = PFUser.currentUser()!.username!
        
        
        let hostdetail : PFQuery = PFUser.query()!
        hostdetail.getObjectInBackgroundWithId((PFUser.currentUser()?.objectId)!) {
            (object: PFObject?, error: NSError?) -> Void in
            
            
            if error == nil  {
                
                
                let host = object?.objectForKey("hostednumber") as! Int
                let attend = object?.objectForKey("attendingnumber") as! Int
                
                self.hostnumber.text = "\(host)"
                self.attendednumber.text = "\(attend)"
                
                
                
            } else {
                
            }
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
}
