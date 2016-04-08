//
//  CABSplitViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABSplitViewController: UISplitViewController, UISplitViewControllerDelegate
{

    override func viewDidLoad() {
        super.viewDidLoad()
		self.delegate = self

        preferredDisplayMode = .AllVisible
		preferredPrimaryColumnWidthFraction = ConstantMagicNumbers.SplitView.WidthFraction
		minimumPrimaryColumnWidth = ConstantMagicNumbers.SplitView.MinimumWidth
    }
	
	func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
		
		if secondaryViewController is CABBaseSectionViewController {
			if let justNavController = primaryViewController as? UINavigationController {
				justNavController.setNavigationBarHidden(false, animated: true)
			}
		}
		if secondaryViewController is CABRoutingViewController {
			if let justNavController = primaryViewController as? UINavigationController {
				justNavController.setNavigationBarHidden(false, animated: true)
			}
		}
		
		return false
	}
	
	func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController) -> UIViewController? {
		var result: UIViewController?
		if let justNavController = primaryViewController as? UINavigationController {
			if justNavController.viewControllers.last is CABRoutingViewController {
				result = justNavController.viewControllers.last
				justNavController.popToRootViewControllerAnimated(false)
			}
		}
		return result
	}
	
}
