//
//  slideViewController.swift
//  PARTY
//
//  Created by Reuben Ukah on 10/23/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit

class slideViewController: UIViewController, UIPageViewControllerDataSource {

    
    var pageController : UIPageViewController!
    var pageTitle: NSArray!
    var pageImage:  NSArray!
    
    
    
    @IBAction func restartbutton(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
        
        
        self.pageTitle = NSArray(objects: "Explore","Today Widget")
        self.pageImage = NSArray(objects: "page1", "page2")
        
        self.pageController = self.storyboard?.instantiateViewControllerWithIdentifier("Pageviewcontroller") as! UIPageViewController
        
        self.pageController.dataSource = self
        
        let startVC = self.viewControllerAtIndex(0) as ContentViewController
        let viewControllers = NSArray(object: startVC)
        
        self.pageController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        
        self.pageController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height-60 )
        
        
        
        self.addChildViewController(self.pageController)
        
        self.view.addSubview(self.pageController.view)
        
        self.pageController.didMoveToParentViewController(self)
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    func viewControllerAtIndex(index: Int) -> ContentViewController {
        if(self.pageTitle.count == 0) || (index >= self.pageTitle.count){
            return ContentViewController()
        }
        let nc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        nc.imageFile = self.pageImage[index] as! String
        nc.titleIndex = self.pageTitle[index] as! String
        
        nc.pageIndex = index
        return nc
        
        
    }
    
    
    
  
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    func pageViewController(pageController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        
        
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        
        
        
        
        if (index == 0 || index == NSNotFound)
            
        {
            
            return nil
            
            
            
        }
        
        
        
        index--
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    func pageViewController(pageController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        
        let vc = viewController as! ContentViewController
        
        var index = vc.pageIndex as Int
        
        
        
        if (index == NSNotFound)
            
        {
            
            return nil
            
        }
        
        
        
        index++
        
        
        
        if (index == self.pageTitle.count)
            
        {
            
            return nil
            
        }
        
        
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    
    func presentationCountForPageViewController(pageController: UIPageViewController) -> Int
        
    {
        
        return self.pageTitle.count
        
    }
    
    
    func presentationIndexForPageViewController(pageController: UIPageViewController) -> Int
        
    {
        
        return 0
        
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
