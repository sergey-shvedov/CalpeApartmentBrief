//
//  CABBaseSectionGeneratedViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABBaseSectionGeneratedViewController: CABBaseSectionViewController
{

	@IBOutlet weak var stackView: UIStackView!
	
	private var postStructure: [CABPost]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		showPosts()
	}
	
	private func showPosts() {
		
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
			self.loadPosts()
			
			dispatch_async(dispatch_get_main_queue()) {
			
				if let justPostStructure = self.postStructure {
					for justPost in justPostStructure {
						var aPost: CABSuperPostView?
						
						switch justPost.type {
						case .Standart: aPost = CABStandartPostView()
						case .TitledImage: aPost = CABTitledImagePostView()
						case .TitledButton: aPost = CABTitledButtonPostView()
						case .TitledParagraph: aPost = CABTitledParagraphPostView()
						case .CommentedButton: aPost = CABCommentedButtonPostView()
						case .NumberedItem: aPost = CABNumberedItemPostView()
						case .NumberedItemWithImage: aPost = CABNumberedItemWithImagePostView()
						}
						
						if let createdPost = aPost {
							createdPost.configureUIWithData(post: justPost)
							createdPost.hidden = true
							createdPost.alpha = 0.0
							self.stackView.addArrangedSubview(createdPost)
						}
					}
				}
				
				self.animatePostAppearing()
			}
		}
	}
	
	private func loadPosts() {
		if let justSection = section {
			self.postStructure = CABDataProvider.sharedInstance.providePostSructureForSection(justSection)
		}
	}
	
	private func animatePostAppearing() {
		for (index, justView) in stackView.arrangedSubviews.enumerate() {
			UIView.animateWithDuration(ConstantMagicNumbers.PostAppearingAnimation.Duration, delay: ConstantMagicNumbers.PostAppearingAnimation.BethDelay * Double(index), options: [], animations: {
				justView.hidden = false
				justView.alpha = 1.0
				}, completion: nil)
		}
	}

}
