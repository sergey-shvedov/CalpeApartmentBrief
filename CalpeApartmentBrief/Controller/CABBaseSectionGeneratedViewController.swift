//
//  CABBaseSectionGeneratedViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 13.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit
import MapKit

class CABBaseSectionGeneratedViewController: CABBaseSectionViewController, CABButtonPostViewDelegate
{

	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	
	private var postStructure: [CABPost]?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		showPosts()
	}
	
	private func showPosts() {
		turnSpinnerOn(true)
		
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
								(aPost as! CABTitledButtonPostView).delegate = self
						case .TitledParagraph: aPost = CABTitledParagraphPostView()
						case .CommentedButton: aPost = CABCommentedButtonPostView()
								(aPost as! CABCommentedButtonPostView).delegate = self
						case .NumberedItem: aPost = CABNumberedItemPostView()
						case .NumberedItemWithImage: aPost = CABNumberedItemWithImagePostView()
						case .PinnedMap: aPost = CABPinnedMapPostView()
						}
						
						if let createdPost = aPost {
							createdPost.configureUIWithData(post: justPost)
							createdPost.hidden = true
							createdPost.alpha = 0.0
							self.stackView.addArrangedSubview(createdPost)
						}
					}
				}
				
				self.turnSpinnerOn(false)
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
			UIView.animateWithDuration(ConstantMagicNumbers.PostAppearingAnimation.Duration, delay: ConstantMagicNumbers.PostAppearingAnimation.BethDelay * Double(index), options: [.AllowUserInteraction], animations: {
				justView.hidden = false
				justView.alpha = 1.0
				}, completion: nil)
		}
	}
	
	private func turnSpinnerOn(isWorking: Bool) {
		if isWorking {
			spinner.alpha = 0.0
			UIView.animateWithDuration(ConstantMagicNumbers.SpinnerAppearingAnimation.Duration) {
				self.spinner.alpha = ConstantMagicNumbers.SpinnerAppearingAnimation.TargetAlpha
			}
			spinner.startAnimating()
		} else {
			UIView.animateWithDuration(ConstantMagicNumbers.SpinnerAppearingAnimation.OutDuration, animations: {
				self.spinner.alpha = 0.0
				}) { (isComplete) in
					self.spinner.stopAnimating()
			}
		}
	}
	
	func performActionWithIdentifier(identifier: String) {
		switch identifier {
		case ConstantActionIdentifier.CallElena:
			if let url = NSURL(string: ConstantActionIdentifier.ElenaNumber) {
				UIApplication.sharedApplication().openURL(url)
			}
		case ConstantActionIdentifier.Routing:
			performSegueWithIdentifier(ConstantSegueIdentifier.RoutingMapView, sender: nil)
		case ConstantActionIdentifier.ShowRouteSection:
			showRouteSection()
		default: break
		}
	}
	
	private func showRouteSection() {
		if let justNavController = navigationController {
			
			let storyboard = UIStoryboard(name: ConstantStoryboardIdentifier.MainStoryboard, bundle: nil)
			let destinationVC = storyboard.instantiateViewControllerWithIdentifier(ConstantStoryboardIdentifier.BaseGeneratedVC)
			if let justDestinationVC = destinationVC as? CABBaseSectionViewController {
				justDestinationVC.section = CABMenuSection.Route
			}
			justNavController.popViewControllerAnimated(false)
			justNavController.pushViewController(destinationVC, animated: false)
			
		} else if let justSplitController = splitViewController, let justNavController = justSplitController.viewControllers.first as? UINavigationController, let justMenuController = justNavController.viewControllers.first as? CABMenuTableViewController {
			justMenuController.executeSegueWithSection(CABMenuSection.Route)
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		super.prepareForSegue(segue, sender: sender)
		
		if let justIdentifier = segue.identifier {
			switch justIdentifier {
			case ConstantSegueIdentifier.RoutingMapView:
				if let justRoutingVC = segue.destinationViewController as? CABRoutingViewController {
					let homePoint = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: ConstantMagicNumbers.MapView.HomeLatitude, longitude: ConstantMagicNumbers.MapView.HomeLongitude), addressDictionary: nil))
					homePoint.name = ConstantMagicNumbers.MapView.PointName
					justRoutingVC.destination = homePoint
					justRoutingVC.superSection = section
				}
			default: break
			}
		}
	}

}
