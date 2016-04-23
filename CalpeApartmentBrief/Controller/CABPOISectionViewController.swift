//
//  CABPOISectionViewController.swift
//  CalpeApartmentBrief
//
//  Created by Sergey Shvedov on 22.04.16.
//  Copyright © 2016 Sergey Shvedov. All rights reserved.
//

import UIKit

class CABPOISectionViewController: CABBaseSectionViewController, UIAdaptivePresentationControllerDelegate
{
	@IBOutlet var horizontalConstraints: [NSLayoutConstraint]!
	@IBOutlet var verticalContraints: [NSLayoutConstraint]!
	@IBOutlet weak var infoHorisontalContraint: NSLayoutConstraint!
	@IBOutlet weak var infoVerticalConstraint: NSLayoutConstraint!
	@IBOutlet weak var infoView: UIView!

	enum ViewState {
		case Vertical
		case Horisontal
	}
	
	private var viewState: ViewState = .Horisontal {
		didSet {
			stateOfViewChangedTo(viewState)
		}
	}

	private var isInfoViewHidden = true
	private var initialGragPoint: CGPoint = CGPointZero
	private typealias MagicNumber = ConstantMagicNumbers.DraggableView

	// MARK: Life
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		if self.view.frame.height / self.view.frame.width > MagicNumber.OrientationRatio {
			viewState = .Vertical
		} else {
			viewState = .Horisontal
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
