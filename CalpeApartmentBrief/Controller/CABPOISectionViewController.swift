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

class CABPOISectionViewController: CABBaseSectionViewController, MKMapViewDelegate
{
	@IBOutlet var horizontalConstraints: [NSLayoutConstraint]!
	@IBOutlet var verticalContraints: [NSLayoutConstraint]!
	@IBOutlet weak var infoHorisontalContraint: NSLayoutConstraint!
	@IBOutlet weak var infoVerticalConstraint: NSLayoutConstraint!
	@IBOutlet weak var infoView: UIView!
	@IBOutlet weak var baseSegmentController: UISegmentedControl!
	private weak var childInfoController: UIViewController?
	
	private var viewState: ViewState = .Horisontal {
		didSet {
			stateOfViewChangedTo(viewState)
		}
	}

	private var lastSelectedSegment: Int?
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
			mapView.mapType = .Hybrid
			//addParallaxToView(mapView)
			mapView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 30)
			
			switch CLLocationManager.authorizationStatus() {
			case .AuthorizedAlways: fallthrough
			case .AuthorizedWhenInUse: mapView.showsUserLocation = true
			default: break
			}
		}
	}
	
	// MARK:- Life Cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupRegion()
		loadAttractions()
		updateSegmentController()
	}
	
	private func loadAttractions() {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
			if let justSection = self.section {
				self.attractions = CABDataProvider.sharedInstance.provideBasedAttractionsForSection(justSection)
				self.addParallaxToView(self.mapView)
				dispatch_async(dispatch_get_main_queue()) { 
					self.mapView.addAnnotations(self.attractions)
				}
			}
		}
	}
	
	private func setupRegion() {
		if let lastRegion = CABAppResponse.sharedInstance.latestPOIViewSettings {
			mapView.setRegion(lastRegion, animated: false)
		} else {
			changeRegion(.Local, animated: false)
			lastSelectedSegment = 0
		}
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if self.view.frame.height / self.view.frame.width > MagicNumber.OrientationRatio {
			viewState = .Vertical
		} else {
			viewState = .Horisontal
		}
	}
	
	override func viewDidDisappear(animated: Bool) {
		super.viewDidDisappear(animated)
		CABAppResponse.sharedInstance.latestPOIViewSettings = mapView.region
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let justIdetifier = segue.identifier {
			switch justIdetifier {
			case ConstantSegueIdentifier.InfoContainer:
				childInfoController = segue.destinationViewController
			case ConstantSegueIdentifier.InfoView:
				if let justPoint = sender as? CABAttractionMapPoint, let justInfoVC = segue.destinationViewController as? CABInfoMapViewController {
					justInfoVC.mapPoint = justPoint
					
					UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.1)
					view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
					let image = UIGraphicsGetImageFromCurrentImageContext()
					UIGraphicsEndImageContext()
					justInfoVC.backgroundImage = image
				}
			default:
				break
			}
		}
	}
	
}


// MARK:- SegmentController handler
extension CABPOISectionViewController
{
	@IBAction func tapedRegion(sender: UISegmentedControl) {
		lastSelectedSegment = sender.selectedSegmentIndex
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
	
	private func updateSegmentController() {
		if let justNavController = self.navigationController {
			if !(justNavController.navigationItem.titleView is UISegmentedControl) {
				let segmenter = UISegmentedControl(items: ["Calpe", "C-Blanca"])
				segmenter.tintColor = UIColor.blackColor().colorWithAlphaComponent(0.9)
				segmenter.sizeToFit()
				segmenter.addTarget(self, action:#selector(CABPOISectionViewController.tapedRegion(_:)), forControlEvents: .ValueChanged)
				justNavController.navigationBar.topItem?.titleView = segmenter
				
				if let last = lastSelectedSegment { segmenter.selectedSegmentIndex = last }
				baseSegmentController.hidden = true
				segmenter.hidden = (traitCollection.verticalSizeClass == .Compact) ? true : false
			}
			
		} else {
			if let last = lastSelectedSegment { baseSegmentController.selectedSegmentIndex = last }
			baseSegmentController.hidden = false
		}
	}
	
}


// MARK:- MapView delegate
extension CABPOISectionViewController
{
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
		
		var result: MKAnnotationView?
		
		if let justAttraction = annotation as? CABAttractionMapPoint {
			switch justAttraction.type {
				
			case .Home:
				var view = mapView.dequeueReusableAnnotationViewWithIdentifier(ConstantAnnotationIdentifier.MapPost)
				if nil == view {
					view = CABHomeAnnotationView(annotation: annotation, reuseIdentifier: ConstantAnnotationIdentifier.MapPost, withIconName: justAttraction.iconName )
					view?.canShowCallout = false
				} else { view!.annotation = annotation }
				result = view
				
			case .Parking:
				var view = mapView.dequeueReusableAnnotationViewWithIdentifier(ConstantAnnotationIdentifier.ParkingPin)
				if nil == view {
					view = CABHomeAnnotationView(annotation: annotation, reuseIdentifier: ConstantAnnotationIdentifier.ParkingPin, withIconName: justAttraction.iconName )
					view?.canShowCallout = false
				} else { view!.annotation = annotation }
				result = view
				
			default:
				var view = mapView.dequeueReusableAnnotationViewWithIdentifier(ConstantAnnotationIdentifier.StandartPin)
				if nil == view { view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: ConstantAnnotationIdentifier.StandartPin) }
				else { view!.annotation = annotation }
				
				if let pin = view as? MKPinAnnotationView {
					typealias ConstantPin = ConstantMagicNumbers.ConstantPin
					switch justAttraction.type {
					case .Nature: pin.pinTintColor = ConstantPin.colorFromType(.Nature)
					case .Store: pin.pinTintColor = ConstantPin.colorFromType(.Store)
					case .ChineseStore: pin.pinTintColor = ConstantPin.colorFromType(.ChineseStore)
					case .Entertainment: pin.pinTintColor = ConstantPin.colorFromType(.Entertainment)
					case .Infrastructure: pin.pinTintColor = ConstantPin.colorFromType(.Infrastructure)
					case .Standart: pin.pinTintColor = ConstantPin.colorFromType(.Standart)
					default: pin.tintColor = ConstantPin.colorFromType(.Standart)
					}
					pin.canShowCallout = justAttraction.isTappable
				}
				
				result = view
			}
		}
		
		return result 
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
	
	func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
		mapView.deselectAnnotation(view.annotation, animated: true)
		if traitCollection.horizontalSizeClass == .Compact {
			performSegueWithIdentifier(ConstantSegueIdentifier.InfoView, sender: view.annotation)
		} else {
			if let justPoint = view.annotation as? CABAttractionMapPoint, let justInfoVC = childInfoController as? CABInfoMapViewController {
				justInfoVC.mapPoint = justPoint
				activateInfoView(self)
			}
		}
	}
}


// MARK:- Draggable View Animation
extension CABPOISectionViewController
{
	@IBAction func activateInfoView(sender: AnyObject) {
		executeAnimationClosure{
			self.activateInfoContraint(true)
		}
	}
	
	func addParallaxToView(vw: UIView) {
		let amount = 30
		
		let horizontal = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
		horizontal.minimumRelativeValue = amount
		horizontal.maximumRelativeValue = -amount
		
		let vertical = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
		vertical.minimumRelativeValue = amount
		vertical.maximumRelativeValue = -amount
		
		let group = UIMotionEffectGroup()
		group.motionEffects = [horizontal, vertical]
		vw.addMotionEffect(group)
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
		updateSegmentController()
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
