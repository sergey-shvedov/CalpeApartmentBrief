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
		
		if let aCell = cell as? CABMenuTableViewCell, let menuSection = CABMenuSection(rawValue: indexPath.row) {
			aCell.configureBasedOn(menuSection)
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
	
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	// Get the new view controller using segue.destinationViewController.
	// Pass the selected object to the new view controller.
	}
	*/
	
	


}
