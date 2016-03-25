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
			mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 38.645156, longitude: 0.053655), span: MKCoordinateSpanMake(0.030, 0.030))
		}
	}

	override func configureUI() {
		
	}

}
