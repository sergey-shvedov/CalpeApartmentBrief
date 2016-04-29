 //
//  CABInfoMapViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 23.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit
import MapKit

class CABInfoMapViewController: CABCollapsedViewController {
	
	var mapPoint: CABAttractionMapPoint? {
		didSet {
			if isViewLoaded() { updateUI() }
		}
	}
	
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var attractionImage: UIImageView!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var bluredImageView: UIImageView!
	
	var backgroundImage: UIImage?
	private var attractionDescription: String?
	
	override var isPromotedWhileSeparated: Bool {
		get { return false }
		set { super.isPromotedWhileSeparated = newValue }
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupBackground()
		tableView.estimatedRowHeight = tableView.rowHeight
		tableView.rowHeight = UITableViewAutomaticDimension
		updateUI()
    }
	
	private func setupBackground() {
		if let justImage = backgroundImage {
			bluredImageView.image = justImage
		}
	}
	
	private func updateUI() {
		if let justPoint = mapPoint {
			titleLabel.text = justPoint.title
			attractionDescription = justPoint.body
			tableView.reloadData()
			switch justPoint.imageName {
			case nil:
				break
			default:
				attractionImage.image = UIImage(named: justPoint.imageName!)
			}
		}
	}
	

	@IBAction func tappedRouting(sender: AnyObject) {
		performSegueWithIdentifier(ConstantSegueIdentifier.RoutingMapView, sender: nil)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let justIdentifier = segue.identifier {
			switch justIdentifier {
			case ConstantSegueIdentifier.RoutingMapView:
				if let justRoutingVC = segue.destinationViewController as? CABRoutingViewController, let justMapPont = mapPoint {
					let coordinate = justMapPont.coordinate
					let point = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
					point.name = justMapPont.title
					justRoutingVC.destination = point
					justRoutingVC.superSection = CABMenuSection.POI
				}
			default:
				break
			}
		}
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
		
		if let justCell = cell as? InfoMapDescriptionTableViewCell {
			justCell.configureUI(text: attractionDescription)
		}
		
		return cell
	}
	
}
