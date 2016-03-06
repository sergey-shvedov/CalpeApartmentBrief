//
//  CABWelcomeViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABWelcomeViewController: UIViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

	@IBAction func showMenu(sender: UIButton) {
		if let justNavController = navigationController {
			justNavController.popToRootViewControllerAnimated(true)
		}
	}
}
