//
//  CABPinnedMapPostView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 19.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit
import MapKit

class CABPinnedMapPostView: CABSuperPostView, CABPostViewConfigurable, MKMapViewDelegate {
	
	@IBOutlet weak var mapView: MKMapView! {
		didSet {
			mapView.delegate = self
			mapView.mapType = .Hybrid
			
			switch CLLocationManager.authorizationStatus() {
			case .AuthorizedAlways: fallthrough
			case .AuthorizedWhenInUse: mapView.showsUserLocation = true
			default: break
			}
		}
	}

	override func configureUI() {
		if let justPost = post as? CABPostPinnedMap {
			mapView.addAnnotations(justPost.annotations)
		}
		mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.649156, longitude: 0.053655), span: MKCoordinateSpanMake(0.040, 0.040))
		//mapView.addAnnotation(CABMapPoint(latitude: 38.657705, longitude: 0.047746, withIconName: nil))
	}
	
	func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
		if annotation is MKUserLocation { return nil }
		
		var view = mapView.dequeueReusableAnnotationViewWithIdentifier("ident")
		if nil == view {
			view = CABHomeAnnotationView(annotation: annotation, reuseIdentifier: "ident", withIconName: (annotation as! CABMapPoint).iconName )
			view?.canShowCallout = false
			
		} else {
			view!.annotation = annotation
		}
		return view
	}
	
	func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
		for view in views {
			if let justView = view as? CABHomeAnnotationView {
				if justView.iconName == "iconHome" {
					justView.superview?.bringSubviewToFront(justView)
				}
//				else {
//					justView.superview?.sendSubviewToBack(justView)
//				}
			}
		}
	}

}
