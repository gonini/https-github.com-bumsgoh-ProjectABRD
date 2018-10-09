//
//  MainGuidePageViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class SignUpPageViewController: UIPageViewController {
    
    lazy var dotsPageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        pageControl.numberOfPages = self.orderedViewControllers.count
        pageControl.currentPage = 0
      //  pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    weak var tutorialDelegate: TutorialPageViewControllerDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let sexAndAgeVC: SignUpSexAndAgeViewController = SignUpSexAndAgeViewController()
        let infosVC: SignUpInfosViewController = SignUpInfosViewController()
        
        return [sexAndAgeVC,infosVC]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
       // self.tran
        
        self.delegate = self
        tutorialDelegate?.tutorialPageViewController(self,
                                                        didUpdatePageCount: orderedViewControllers.count)
    
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        
        }
        
        //configurePageControl()
        self.view.addSubview(dotsPageControl)
        self.dotsPageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 8).isActive = true
        self.dotsPageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
       


    }
    
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.dotsPageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.dotsPageControl.numberOfPages = orderedViewControllers.count
        self.dotsPageControl.currentPage = 0
        self.dotsPageControl.tintColor = UIColor.black
        self.dotsPageControl.pageIndicatorTintColor = UIColor.white
        self.dotsPageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(dotsPageControl)
       
    }
}

extension SignUpPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
       
    }
}

extension SignUpPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            tutorialDelegate?.tutorialPageViewController(self,
                                                         didUpdatePageIndex: index)
           
        }
        
    }
    
}
protocol TutorialPageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(_ tutorialPageViewController: SignUpPageViewController,
                                    didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(_ tutorialPageViewController: SignUpPageViewController,
                                    didUpdatePageIndex index: Int)
    
}
