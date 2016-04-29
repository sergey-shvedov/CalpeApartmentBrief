//
//  CABRoutingViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 28.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit
import MapKit

class CABRoutingViewController: CABCollapsedViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
	
	@IBOutlet weak var mapView: MKMapView! {
		didSet {
			mapView.delegate = self
		}
	}
	@IBOutlet weak var stackView: UIStackView!
	@IBOutlet var loadingView: UIView!
	@IBOutlet var moveView: UIView!
	
	var superSection: CABMenuSection?
	var destination: MKMapItem?
	var directions: MKDirections?
	private let locationManager = CLLocationManager()
	
	@IBAction func moveToDestination(sender: UIButton) {
		destination?.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving])
	}
	
	@IBAction func tappedCancel(sender: AnyObject) {
		if let justSuperSection = superSection {
			switch justSuperSection {
			case .Route:
				performSegueWithIdentifier(ConstantSegueIdentifier.BackToRouteView, sender: nil)
			case .POI:
				performSegueWithIdentifier(ConstantSegueIdentifier.BackToPOIView, sender: nil)
			default: break
			}
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		directions?.cancel()
		if let identidier = segue.identifier{
			switch identidier {
			case ConstantSegueIdentifier.BackToRouteView:
				if let destinationVC = segue.destinationViewController as? CABBaseSectionViewController {
					var outsideSection = CABMenuSection.Route
					if let justSuperSection = superSection { outsideSection = justSuperSection }
					destinationVC.section = outsideSection
				}
			case ConstantSegueIdentifier.BackToPOIView:
				if let destinationVC = segue.destinationViewController as? CABPOISectionViewController {
					var outsideSection = CABMenuSection.POI
					if let justSuperSection = superSection { outsideSection = justSuperSection }
					destinationVC.section = outsideSection
				}
			default:
				break
			}
			
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
			locationManager.requestLocation()
			let span = MKCoordinateSpan(latitudeDelta: ConstantMagicNumbers.MapView.SpanLatitude, longitudeDelta: ConstantMagicNumbers.MapView.SpanLongitude)
			if let justLocation = locationManager.location {
				mapView.region = MKCoordinateRegion(center: justLocation.coordinate, span: span)
			} else if let justDestinationLocation = destination?.placemark {
				mapView.region = MKCoordinateRegion(center: justDestinationLocation.coordinate, span: span)
			}
			calculateDirection()
		}
		addDestinationAnnotation()
		makeLoadingView(visible: true)
    }

	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
		directions?.cancel()
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
	}
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		
	}
	
	func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
		let polylineRenderer = MKPolylineRenderer(overlay: overlay)
		let baseColor = CABAppResponse.sharedInstance.currentTheme.baseColor
		if (overlay is MKPolyline) {
			polylineRenderer.strokeColor = baseColor
			polylineRenderer.lineWidth = 5.0
		}
		return polylineRenderer
	}
	
	private func calculateDirection() {
		let request = MKDirectionsRequest()
		request.source = MKMapItem.mapItemForCurrentLocation()
		request.destination = destination
		request.transportType = .Automobile
		let directions = MKDirections(request: request)
		directions.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse?, error: NSError?) in
			if let justRoutes = response?.routes {
				if let justRoute = justRoutes.first {
					self.makeLoadingView(visible: false)
					self.makeMoveView(visible: true)
					self.setupPolyline(justRoute)
				} else {
					self.generateAlert()
				}
			} else if let justError = error {
				let title = justError.localizedDescription
				var text: String?
				if let justSuggestion = justError.localizedRecoverySuggestion { text = justSuggestion }
				else if let justReason = justError.localizedFailureReason { text = justReason }
				
				if self.navigationController != nil || self.splitViewController != nil {
					self.generateAlertWithTitle(title, message: text)
				}
			}
		}
	}
	
	private func addDestinationAnnotation() {
		if let justCoordinate = destination?.placemark.coordinate {
			let annotation = CABMapPoint(latitude: justCoordinate.latitude, longitude: justCoordinate.longitude, withIconName: ConstantAnnotationIdentifier.HomeIconName)
			mapView.addAnnotation(annotation)
		}
	}
	
	private func makeLoadingView(visible visible: Bool) {
		if visible {
			stackView.addArrangedSubview(loadingView)
		} else {
			stackView.removeArrangedSubview(loadingView)
		}
	}
	
	private func makeMoveView(visible visible: Bool) {
		if visible {
			stackView.addArrangedSubview(moveView)
		} else {
			stackView.removeArrangedSubview(moveView)
		}
	}
	
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
	
	private func generateAlertWithTitle(title: String?, message: String?) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
		let okButton = UIAlertAction(title: "OK", style: .Cancel) { (alert) -> Void in
			if let justNavController = self.navigationController {
				justNavController.popViewControllerAnimated(true)
			} else {
				self.performSegueWithIdentifier(ConstantSegueIdentifier.BackToRouteView, sender: nil)
			}
			
		}
		alert.addAction(okButton)
		
		presentViewController(alert, animated: true, completion: nil)
	}
	
	private func generateAlert() {
		generateAlertWithTitle(nil, message: "Directions not available")
	}
	
	private func setupPolyline(route: MKRoute) {
		mapView.addOverlay(route.polyline)
		if mapView.overlays.count == 1 {
				mapView.setVisibleMapRect(route.polyline.boundingMapRect,
	                          edgePadding: ConstantMagicNumbers.MapView.MapPadding,
	                          animated: true)
		}
	}

}
