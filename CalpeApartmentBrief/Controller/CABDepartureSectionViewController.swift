//
//  CABDepartureSectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 07.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABDepartureSectionViewController: CABBaseSectionViewController
{

	@IBOutlet weak var stackView: UIStackView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        animatePostAppearing()
    }

	private func animatePostAppearing() {
		for (index, justView) in stackView.arrangedSubviews.enumerate() {
			UIView.animateWithDuration(0.5, delay: 0.3 * Double(index), options: [], animations: {
				justView.hidden = false
				justView.alpha = 1.0
				}, completion: nil)
		}
	}
}
