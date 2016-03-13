//
//  CABRouteSectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 07.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABRouteSectionViewController: CABBaseSectionViewController
{

	@IBOutlet weak var stackView: UIStackView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		showPosts()
	}
	
	private func showPosts() {
		
		dispatch_async(dispatch_get_main_queue(), { () -> Void in
			
			for _ in 0...3 {
				//				let child = self.storyboard!.instantiateViewControllerWithIdentifier("SrandartPost")
				//				self.addChildViewController(child)
				//				child.view.hidden = true
				//				child.view.alpha = 0.0
				//				self.stackView.addArrangedSubview(child.view)
				
				let post = CABStandartPostView()
					post.hidden = true
					post.alpha = 0.0
					self.stackView.addArrangedSubview(post)
				
				
				let post2 = CABNumberedItemWithImagePostView()
					post2.hidden = true
					post2.alpha = 0.0
					self.stackView.addArrangedSubview(post2)
				
				
			}
			
			self.animatePostAppearing()
		})
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
