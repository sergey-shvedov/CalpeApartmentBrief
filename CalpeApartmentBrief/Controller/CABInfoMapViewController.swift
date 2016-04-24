//
//  CABInfoMapViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 23.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABInfoMapViewController: CABCollapsedViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	
//	private var viewState: ViewState = .Horisontal {
//		didSet {
//			stateOfViewChangedTo(viewState)
//		}
//	}
	
//	override var traitCollection: UITraitCollection {
//		var result = super.traitCollection
//		if viewState == .Vertical {
//			let collections = [UITraitCollection(horizontalSizeClass: .Compact),
//			                   UITraitCollection(verticalSizeClass: .Compact)]
//			result = UITraitCollection(traitsFromCollections: collections)
//		} else {
//			let collections = [UITraitCollection(horizontalSizeClass: .Regular),
//			                   UITraitCollection(verticalSizeClass: .Regular)]
//			result = UITraitCollection(traitsFromCollections: collections)
//		}
//		return result
//	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
    }
	
	
	
//	override func viewWillLayoutSubviews() {
//		super.viewWillLayoutSubviews()
//		if self.view.frame.height / self.view.frame.width > 1.2 {
//			viewState = .Vertical
//		} else {
//			viewState = .Horisontal
//		}
//	}
	
//	override func viewDidLayoutSubviews() {
//		super.viewDidLayoutSubviews()
//		if self.view.frame.height / self.view.frame.width > 1.2 {
//			viewState = .Vertical
//		} else {
//			viewState = .Horisontal
//		}
//	}
	
//	override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//		super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//		if size.height / size.width > 1.2 {
//			viewState = .Vertical
//		} else {
//			viewState = .Horisontal
//		}
//	}
	
//	private func stateOfViewChangedTo(state: ViewState) {
//		switch viewState {
//		case .Vertical:
//			let traitCollection = UITraitCollection(horizontalSizeClass: .Compact)
//			self.setOverrideTraitCollection(traitCollection, forChildViewController: self)
//		case .Horisontal:
//			let traitCollection = UITraitCollection(horizontalSizeClass: .Regular)
//			self.setOverrideTraitCollection(traitCollection, forChildViewController: self)
//		}
//	}
//	
//	private func stateOfViewChangedTo(state: ViewState) {
//		switch viewState {
//		case .Vertical:
//			let traitCollection = UITraitCollection(horizontalSizeClass: .Compact)
//			self.setOverrideTraitCollection(traitCollection, forChildViewController: self)
//		case .Horisontal:
//			let traitCollection = UITraitCollection(horizontalSizeClass: .Regular)
//			self.setOverrideTraitCollection(traitCollection, forChildViewController: self)
//		}
//	}
//	
//	override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//		super.willTransitionToTraitCollection(newCollection, withTransitionCoordinator: coordinator)
//	}

}

extension CABInfoMapViewController: UITableViewDelegate, UITableViewDataSource
{
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let identifier = "Info Map Description Cell"
		
		let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
		cell.backgroundColor = UIColor.clearColor()
		
		return cell
	}
	
}
