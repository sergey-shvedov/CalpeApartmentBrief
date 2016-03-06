//
//  CABBaseSectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABBaseSectionViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
		hideNavigationBar(false, animated: true)
    }
	
	override func willMoveToParentViewController(parent: UIViewController?) {
		if nil == parent {
			hideNavigationBar(true, animated: true)
		}
	}
	
	private func hideNavigationBar(hidden: Bool, animated: Bool) {
		if let justNavController = navigationController {
			justNavController.setNavigationBarHidden(hidden, animated: animated)
		}
	}

	@IBAction func printStatus(sender: AnyObject) {
		print(navigationController)
		print(splitViewController)
	}
}
