//
//  MainGuidePageViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class SignUpPageViewController: UIPageViewController {
     weak var tutorialDelegate: TutorialPageViewControllerDelegate?
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let sexAndAgeVC: SignUpSexAndAgeViewController = SignUpSexAndAgeViewController()
        let infosVC: SignUpInfosViewController = SignUpInfosViewController()
        
        return [sexAndAgeVC,infosVC]
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        self.delegate = self
        tutorialDelegate?.tutorialPageViewController(self,
                                                        didUpdatePageCount: orderedViewControllers.count)
    
        
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        
        }


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
