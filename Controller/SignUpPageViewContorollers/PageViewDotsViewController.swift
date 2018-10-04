//
//  PageViewDotsViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PageViewDotsViewController: UIViewController {

    let dotsPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let pageViewController: SignUpPageViewController = SignUpPageViewController()
            pageViewController.tutorialDelegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     class TutorialViewController: UIViewController {
     
     @IBOutlet weak var pageControl: UIPageControl!
     @IBOutlet weak var containerView: UIView!
     
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     if let tutorialPageViewController = segue.destinationViewController as? TutorialPageViewController {
     tutorialPageViewController.tutorialDelegate = self
     }
     }
     
     }
     
     extension TutorialViewController: TutorialPageViewControllerDelegate {
     
     func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
     didUpdatePageCount count: Int) {
     pageControl.numberOfPages = count
     }
     
     func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
     didUpdatePageIndex index: Int) {
     pageControl.currentPage = index
     }
     
     }
    */

}


extension PageViewDotsViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(_ tutorialPageViewController: SignUpPageViewController,
                                    didUpdatePageCount count: Int) {
        dotsPageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(_ tutorialPageViewController: SignUpPageViewController,
                                    didUpdatePageIndex index: Int) {
        dotsPageControl.currentPage = index
    }
    
}
