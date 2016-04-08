//
//  CABMenuTableViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABMenuTableViewController: UITableViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.backgroundView = UIImageView(image: CABAppResponse.sharedInstance.currentTheme.imageForMenuBackground())
	}

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CABAppResponse.sharedInstance.numberOfMenuItems
    }

	
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ConstantIdentifier.CellMenuItem, forIndexPath: indexPath)
		
		if let aCell = cell as? CABMenuTableViewCell {
			let menu = CABAppResponse.sharedInstance.menu
			if indexPath.row < menu.count {
				let menuSection = menu[indexPath.row]
				aCell.configureBasedOn(menuSection)
			}
		}

        return cell
    }
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		var result = ConstantRowHeight.Medium
		
		if self.traitCollection.userInterfaceIdiom == .Pad {
			result = ConstantRowHeight.Large
		} else if self.traitCollection.verticalSizeClass == .Compact {
			result = ConstantRowHeight.Small
		}

		return result
	}
	
	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		if let justCell = tableView.cellForRowAtIndexPath(indexPath) as? CABMenuTableViewCell, let justSection = justCell.section {
			performSegueWithIdentifier(justSection.generateSegueIdentifier(), sender: justCell)
			CABAppResponse.sharedInstance.confirmPrimaryState()
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let justCell = sender as? CABMenuTableViewCell, let justSection = justCell.section {
			if let justDestinationVC = segue.destinationViewController as? CABBaseSectionViewController {
				justDestinationVC.section = justSection
			}
		}
	}
	
	
	func executeSegueWithSection(section: CABMenuSection) {
		tableView.selectRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), animated: false, scrollPosition: .None)
		self.tableView(tableView, didSelectRowAtIndexPath: NSIndexPath(forRow: 2, inSection: 0))
	}

}
