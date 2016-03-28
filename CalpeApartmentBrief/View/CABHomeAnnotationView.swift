//
//  CABHomeAnnotationView.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 28.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit
import MapKit

class CABHomeAnnotationView: MKAnnotationView
{
	private(set) var iconName = ""

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
		super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
	}
	
	convenience init(annotation: MKAnnotation?, reuseIdentifier: String?, withIconName iconName: String?) {
		self.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
		if reuseIdentifier == ConstantAnnotationIdentifier.MapPost, let justIconName = iconName {
			image = UIImage(named: justIconName)
			self.iconName = justIconName
		}
	}
}