//
//  NSArray+Extension.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 14.03.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import Foundation

extension NSArray
{
	convenience init?(contentsOfFileNamed aFileName: String, inBundle anBundle: String?) {
		
		var bundle = NSBundle.mainBundle()
		if let justBundleIdentifier = anBundle, let justBundle = NSBundle(identifier: justBundleIdentifier) {
			bundle = justBundle
		}
		
		if let url = bundle.URLForResource(aFileName, withExtension: nil) {
			self.init(contentsOfURL: url)
		} else {
			return nil
		}
	}
	
}