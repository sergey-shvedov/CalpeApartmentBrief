//
//  CABThemeProtocol.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 06.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation
import UIKit

protocol CABTheme {
	func colorOfMenuItemWithIndex(index: Int) -> UIColor
}