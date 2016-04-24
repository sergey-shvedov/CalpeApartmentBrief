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
	
	override var isPromotedWhileSeparated: Bool {
		get { return false }
		set { super.isPromotedWhileSeparated = newValue }
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
    }
	
}

// MARK: TableViewDelegate
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
