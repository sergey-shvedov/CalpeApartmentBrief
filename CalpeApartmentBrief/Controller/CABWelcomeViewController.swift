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

	@IBOutlet weak var backgroundImageView: UIImageView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let randomIndex = Int(arc4random_uniform(UInt32(ConstantIntro.ImageNames.count)))
		if let justImage = UIImage(named: ConstantIntro.ImageNames[randomIndex]) {
			backgroundImageView.image = justImage
		}
        
    }

	@IBAction func showMenu(sender: UIButton) {
		if let justNavController = navigationController {
			justNavController.popToRootViewControllerAnimated(true)
		}
	}
	
}
