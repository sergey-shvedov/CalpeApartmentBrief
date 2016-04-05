//
//  CABRuleSectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 29.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABRuleSectionViewController: CABBaseSectionViewController, UITableViewDelegate, UITableViewDataSource
{
	
	private var articles = [String]()
	private let isThereBlankCell = true
	private let isThereThanksCell = true
	
	@IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension

        loadArticles()
		tableView.alpha = 0.0
		tableView.reloadData()
		animateAppearing()
    }
	
	private func loadArticles() {
		if let justSection = section {
			self.articles = CABDataProvider.sharedInstance.provideArticlesForSection(justSection)
		}
	}
	
	private func animateAppearing() {
		UIView.animateWithDuration(ConstantMagicNumbers.TableAppearingAnimation.Duration) {
			self.tableView.alpha = 1.0
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		var result = articles.count
		if isThereBlankCell { result += 1 }
		if isThereThanksCell { result += 1 }
		return result
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var identifier = ConstantIdentifier.CellRuleArticle
		if isThereBlankCell && indexPath.row == 0 { identifier = ConstantIdentifier.CellRuleBlank }
		if isThereThanksCell && indexPath.row == (tableView.numberOfRowsInSection(0) - 1) { identifier = ConstantIdentifier.CellRuleThanks }
		let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
		cell.backgroundColor = UIColor.clearColor()
		
		if let justCell = cell as? CABRuleArticleTableViewCell {
			let articleIndex = isThereBlankCell ? (indexPath.row - 1) : indexPath.row
			if articleIndex < articles.count {
				justCell.configureUI(numberItem: "\(articleIndex + 1)", text: articles[articleIndex])
			}
		}
		
		return cell
	}

}
