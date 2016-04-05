//
//  CABAppliancesSectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 02.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABAppliancesSectionViewController: CABBaseSectionViewController, UITableViewDelegate, UITableViewDataSource
{
	
	private var partitions = [CABTablePartition]()
	private let isThereBlankCell = true
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedSectionHeaderHeight = tableView.sectionHeaderHeight
		tableView.sectionHeaderHeight = UITableViewAutomaticDimension
		self.tableView.alpha = 0.0
		
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
			self.loadArticles()
			
			dispatch_async(dispatch_get_main_queue()) { [weak self] in
				self?.tableView.reloadData()
				self?.animateAppearing()
			}
		}
		
	}
	
	private func loadArticles() {
		if let justSection = section {
			self.partitions = CABDataProvider.sharedInstance.provideTablePartitionsForSection(justSection)
		}
	}
	
	private func animateAppearing() {
		UIView.animateWithDuration(ConstantMagicNumbers.TableAppearingAnimation.Duration) {
			self.tableView.alpha = 1.0
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return partitions.count
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var result = 0
		if partitions.count > section {
			result = partitions[section].articles.count
			if isThereBlankCell && (0 == section) { result += 1 }
		}

		return result
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var identifier = ConstantIdentifier.CellAppliancesArticle
		if isThereBlankCell && (0 == indexPath.row) && (0 == indexPath.section) { identifier = ConstantIdentifier.CellAppliancesBlank }

		let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
		cell.backgroundColor = UIColor.clearColor()
		
		if let justCell = cell as? CABAppliancesArticleTableViewCell {
			let partition = partitions[indexPath.section]
			var articleIndex = indexPath.row
			if isThereBlankCell && (0 == indexPath.section) { articleIndex -= 1 }
			
			if articleIndex < partition.articles.count {
				justCell.configureUI(article: partition.articles[articleIndex])
			}
		}
		
		return cell
	}
	
	func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var header: UIView?
		if section < partitions.count {
			let partition = partitions[section]
			if let justHeaderTitle = partition.title {
				let headerComment = partition.comment
				header = tableView.dequeueReusableCellWithIdentifier(ConstantIdentifier.CellAppliancesHeader)
				if let justHeader = header as? CABAppliancesHeaderTableViewCell {
					justHeader.configureUI(title: justHeaderTitle, comment: headerComment)
				}
			}
		}
		if nil == header { header = UIView() }
		
		return header
	}

}
