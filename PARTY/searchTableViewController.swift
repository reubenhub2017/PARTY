//
//  searchTableViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/26/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
import Parse

class searchTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    var searchuser: [PFUser] = [PFUser]()
    var userSearchController = UISearchController!()
    var searchActive: Bool = false
    var userfollowbutton: PFObject!
    var unuserfollowbutton : PFObject!
    var button: customTableViewCell = customTableViewCell()
 
 
    
    

    
    
    
        func loadusers(searchstring: String) {
        var query = PFUser.query()
    
        
        query!.whereKey("username", containsString: searchstring)
        query!.whereKey("username", notEqualTo: (PFUser.currentUser()?.username)!)
            
        query!.findObjectsInBackgroundWithBlock{(objects: [AnyObject]?, error:NSError?) -> Void in
            
            
            
            if (error == nil) {
                self.searchuser.removeAll(keepCapacity: false)
                self.searchuser += objects as! [PFUser]
                self.tableView.reloadData()
            } else {
                // Log details of the failure
                print("search query error: \(error) \(error!.userInfo)")
            }
            self.searchActive = false
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        
        
        self.userSearchController = UISearchController(searchResultsController: nil)
        //self.userSearchController.dimsBackgroundDuringPresentation = true
        //self.tableView.tableHeaderView = userSearchController.searchBar
        // This is used for dynamic seah results updating while the user types
        // Requires UISearchResultsUpdating delegate
        self.userSearchController.searchResultsUpdater = self
        
        // Configure the search controller's search bar
        self.userSearchController.searchBar.placeholder = "Search for a user"
        //self.userSearchController.searchBar.sizeToFit()
        self.userSearchController.searchBar.delegate = self
        self.definesPresentationContext = false
        
        self.userSearchController.hidesNavigationBarDuringPresentation = false
       
       self.navigationItem.titleView = userSearchController.searchBar
       
        
        // Set the search controller to the header of the table
        //self.tableView.tableHeaderView = self.userSearchController.searchBar
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
            //self.userSearchController.view.removeFromSuperview()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (self.userSearchController.active) {
            return self.searchuser.count
        }
        else {
        return 0
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("usercell", forIndexPath: indexPath) as! customTableViewCell
        if (self.userSearchController.active && self.searchuser.count > indexPath.row) {
        
            
        
        
        let user = self.searchuser[indexPath.row] as PFUser
        userfollowbutton = user
        unuserfollowbutton = user
            
            cell.followlabel.layer.cornerRadius = cell.followlabel.frame.size.width/2
            cell.followlabel.clipsToBounds = true
            cell.followlabel.layer.masksToBounds = true
            
            cell.followlabel.layer.borderColor = UIColor.blackColor().CGColor
            cell.followlabel.layer.borderWidth = 1.0
            
        let username = user.username
            if(PFUser.currentUser()?.username == username){
                cell.username.text = username
                
                cell.followlabel.hidden = true
            }
            cell.username.text = username
                
            
            
            
        
        }
     
    
  
        
//        //profile image
//        let findpict:PFQuery = PFUser.query()!
//        //let parta : PFObject = self.parties.objectAtIndex(indexPath.row) as! PFObject
//        
//        findpict.findObjectsInBackgroundWithBlock {
//            (objects:[AnyObject]?, error: NSError?) -> Void in
//            if (error == nil) {
//                let user: PFUser = (objects! as NSArray).lastObject as! PFUser
//                
//                let profileimage :PFFile = user["profileimage"] as! PFFile
//                profileimage.getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) -> Void in
//                    if (error == nil) {
//                        let image: UIImage = UIImage(data: imageData!)!
//                        cell.userprogileimage.image = image
//                    }else {
//                        print(error)
//                        
//                    }
//                }
//            }
//            
//            
//        }



        // Configure the cell...

        return cell
    }
    @IBAction func followbtnpressed(sender: AnyObject) {
       
      
        
        if sender.titleLabel?!.textColor == UIColor.blueColor() {
            
            
            sender.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
         
            sender.setTitle("unfollow", forState: UIControlState .Normal)
            
        
            
            let otherUser = userfollowbutton
            let follow = PFObject(className: "Follow")
        
            follow.setObject(PFUser.currentUser()!, forKey: "from")
            follow.setObject(otherUser, forKey: "to")
            follow.setObject("Follow", forKey: "Type")
            follow.saveInBackground()
        }
        
        else if sender.titleLabel?!.textColor == UIColor.redColor() {
        
        let otherUser = unuserfollowbutton
        let unfollow = PFQuery(className: "Follow")
        unfollow.whereKey("to", equalTo: otherUser)
            unfollow.findObjectsInBackgroundWithBlock({ (objects:[AnyObject]?, error:NSError?) -> Void in
                for object in objects! {
                object.deleteEventually()
                }
        })
            sender.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
            
            
            sender.setTitle("follow", forState: .Normal)
        
        }
        
        
        
        
            
            
        }
    
    
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*Fiona s.
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
//    func searchBarSearchButtonClicked(searchbartab: UISearchBar) {
//        searchbartab.resignFirstResponder()
//        self.loadObjects()
//    }
//    func searchBarCancelButtonClicked(searchbartab: UISearchBar) {
//        searchbartab.resignFirstResponder()
//        searchbartab.text = ""
//        self.loadObjects()
//    }
//    func searchBar(searchbartab: UISearchBar, textDidChange searchText: String) {
//        self.loadObjects()
//    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchString: String = searchController.searchBar.text!.lowercaseString
        if (searchString != "" && !self.searchActive) {
            loadusers(searchString)
            
        }
    }
func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    
    // Force search if user pushes button
    let searchString: String = searchBar.text!.lowercaseString
    if (searchString != "") {
        loadusers(searchString)
        
    }
}

func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    
    // Clear any search criteria
    searchBar.text = ""
    
    // Force reload of table data from normal data source
}
    

}
