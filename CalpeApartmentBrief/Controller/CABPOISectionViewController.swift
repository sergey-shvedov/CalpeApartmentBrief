//
//  CABPOISectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 22.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit
import MapKit

enum ViewState {
	case Vertical
	case Horisontal
}

class CABPOISectionViewController: CABBaseSectionViewController
{
	@IBOutlet var horizontalConstraints: [NSLayoutConstraint]!
	@IBOutlet var verticalContraints: [NSLayoutConstraint]!
	@IBOutlet weak var infoHorisontalContraint: NSLayoutConstraint!
	@IBOutlet weak var infoVerticalConstraint: NSLayoutConstraint!
	@IBOutlet weak var infoView: UIView!
	
	private weak var childInfoController: UIViewController?
	
	private var viewState: ViewState = .Horisontal {
		didSet {
			stateOfViewChangedTo(viewState)
		}
	}

	private var attractions = [CABAttractionMapPoint]()
	private var isInfoViewHidden = true
	private var initialGragPoint: CGPoint = CGPointZero
	private typealias MagicNumber = ConstantMagicNumbers.DraggableView
	
	private enum RegionType {
		case Local
		case NorthRegion
	}

	@IBOutlet weak var mapView: MKMapView! {
		didSet {
			//mapView.delegate = self
			mapView.mapType = .Hybrid
			
			switch CLLocationManager.authorizationStatus() {
			case .AuthorizedAlways: fallthrough
			case .AuthorizedWhenInUse: mapView.showsUserLocation = true
			default: break
			}
		}
	}
	
	// MARK: Life
	
    override func viewDidLoad() {
        super.viewDidLoad()
		loadAttractions()
	}
	
	private func loadAttractions() {
		if let justSection = section {
			self.attractions = CABDataProvider.sharedInstance.provideBasedAttractionsForSection(justSection)
			mapView.addAnnotations(attractions)
			changeRegion(.Local, animated: false)
		}
	}
	
	@IBAction func tapedRegion(sender: UISegmentedControl) {
		switch  sender.selectedSegmentIndex {
		case 0: changeRegion(.Local, animated: true)
		case 1: changeRegion(.NorthRegion, animated: true)
		default: break
		}
	}
	
	private func changeRegion(region: RegionType, animated: Bool) {
		typealias RLocal = ConstantMagicNumbers.MapView.RegionLocal
		typealias RNorth = ConstantMagicNumbers.MapView.RegionNorth
		var targetRegion: MKCoordinateRegion?
		switch region {
		case .Local:
			targetRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: RLocal.Latitude, longitude: RLocal.Longitude), span: MKCoordinateSpanMake(RLocal.SpanLatitude, RLocal.SpanLongitude))
		case .NorthRegion:
			targetRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: RNorth.Latitude, longitude: RNorth.Longitude), span: MKCoordinateSpanMake(RNorth.SpanLatitude, RNorth.SpanLongitude))
		}

		mapView.setRegion(targetRegion!, animated: animated)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if self.view.frame.height / self.view.frame.width > MagicNumber.OrientationRatio {
			viewState = .Vertical
		} else {
			viewState = .Horisontal
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let justIdetifier = segue.identifier {
			switch justIdetifier {
			case "Show Info Container":
				childInfoController = segue.destinationViewController
			case "Show Info View":
				childInfoController = segue.destinationViewController
			default:
				break
			}
		}
	}
	
}

extension CABPOISectionViewController // MapView delegate
{
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
		
		var view = mapView.dequeueReusableAnnotationViewWithIdentifier(ConstantAnnotationIdentifier.MapPost)
		if nil == view {
			view = CABHomeAnnotationView(annotation: annotation, reuseIdentifier: ConstantAnnotationIdentifier.MapPost, withIconName: (annotation as! CABMapPoint).iconName )
			view?.canShowCallout = false
			
		} else {
			view!.annotation = annotation
		}
		return view
	}
	
	func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
		for view in views {
			if let justView = view as? CABHomeAnnotationView {
				if justView.iconName == ConstantAnnotationIdentifier.HomeIconName {
					justView.superview?.bringSubviewToFront(justView)
				}
			}
		}
	}
}


extension CABPOISectionViewController // Draggable View Animation
{
	@IBAction func activateInfoView(sender: AnyObject) {
		executeAnimationClosure{
			self.activateInfoContraint(true)
		}
	}
	
	@IBAction func pannedInfoView(sender: UIPanGestureRecognizer) {
		switch sender.state {
		case .Began:
			initialGragPoint = infoView.frame.origin
			
		case .Changed:
			let transition = sender.translationInView(view)
			switch viewState {
			case .Horisontal:
				if transition.x >= 0.0 {
					infoView.frame.origin.x = initialGragPoint.x + transition.x
				} else {
					infoView.frame.origin.x = initialGragPoint.x + transition.x * MagicNumber.DraggingLag
				}
			case .Vertical:
				if transition.y >= 0.0 {
					infoView.frame.origin.y = initialGragPoint.y + transition.y
				} else {
					infoView.frame.origin.y = initialGragPoint.y + transition.y * MagicNumber.DraggingLag
				}
			}
			
		case .Ended:
			animateInfoView()
		default:
			break
		}
	}
	
	override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
		super.traitCollectionDidChange(previousTraitCollection)
		if traitCollection.horizontalSizeClass == .Compact && previousTraitCollection?.horizontalSizeClass != .Compact {
			isInfoViewHidden = true
		}
	}
	
	private func stateOfViewChangedTo(state: ViewState) {
		if infoView.superview != nil {
			switch viewState {
			case .Vertical:
				for constraint in horizontalConstraints { constraint.active = false }
				for constraint in verticalContraints { constraint.active = true }
				
			case .Horisontal:
				for constraint in horizontalConstraints { constraint.active = true }
				for constraint in verticalContraints { constraint.active = false }
			}
			isInfoViewHidden ? activateInfoContraint(false) : activateInfoContraint(true)
		}
		
		if let justChildController = childInfoController {
			switch viewState {
			case .Vertical:
				let newTraitCollection = UITraitCollection(horizontalSizeClass: .Regular)
				self.setOverrideTraitCollection(newTraitCollection, forChildViewController: justChildController)
			case .Horisontal:
				if traitCollection.verticalSizeClass != .Compact {
					let newTraitCollection = UITraitCollection(horizontalSizeClass: .Compact)
					self.setOverrideTraitCollection(newTraitCollection, forChildViewController: justChildController)
				}
			}
		}
	}

	private func animateInfoView() {
		switch viewState {
		case .Horisontal:
			if (infoView.frame.origin.x - initialGragPoint.x) > (infoView.frame.width * MagicNumber.OutResponseRate) {
				executeAnimationClosure{ self.activateInfoContraint(false) }
			} else {
				executeAnimationClosure{ self.activateInfoContraint(true) }
			}
		case .Vertical:
			if (infoView.frame.origin.y - initialGragPoint.y) > (infoView.frame.height * MagicNumber.OutResponseRate) {
				executeAnimationClosure{ self.activateInfoContraint(false) }
			} else {
				executeAnimationClosure{ self.activateInfoContraint(true) }
			}
		}
	}
	
	private func activateInfoContraint(status: Bool) {
		isInfoViewHidden = !status
		switch (viewState, status) {
		case (.Horisontal, true):
			infoView.hidden = false
			infoHorisontalContraint.constant += MagicNumber.TempStep
			infoHorisontalContraint.constant = MagicNumber.ZeroStep
			infoVerticalConstraint.constant = MagicNumber.MerginStep
			
		case (.Horisontal, false):
			infoHorisontalContraint.constant =  -(infoView.frame.width + MagicNumber.HiddenStepDelta)
			infoVerticalConstraint.constant = MagicNumber.MerginStep
			
		case (.Vertical, true):
			infoView.hidden = false
			infoHorisontalContraint.constant = MagicNumber.ZeroStep
			infoVerticalConstraint.constant += MagicNumber.TempStep
			infoVerticalConstraint.constant = MagicNumber.MerginStep
			
		case (.Vertical, false):
			infoHorisontalContraint.constant = MagicNumber.ZeroStep
			infoVerticalConstraint.constant = -(infoView.frame.height + MagicNumber.HiddenStepDelta)
		}
	}
	
	private func executeAnimationClosure(closure: () -> Void) {
		UIView.animateWithDuration(ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelDuration,
		                           delay: 0.0,
		                           usingSpringWithDamping: ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelDamping,
		                           initialSpringVelocity: ConstantMagicNumbers.MenuCellAnimation.WelcomeLabelVelocity,
		                           options: [],
		                           animations: { closure(); self.view.layoutIfNeeded() },
		                           completion: { _ in if self.isInfoViewHidden { self.infoView.hidden = true } })
	}
}
