//
//  CABButtonPostViewDelegate.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 25.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

protocol CABButtonPostViewDelegate: class {
	func performActionWithIdentifier(identifier: String)
}