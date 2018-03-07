//
//  TimelineView.swift
//  PeriscopeRewind
//
//  Created by Ryan Liszewski on 3/7/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit

class TimelineView: UIView {
	
	var duration: TimeInterval = 0.0 {
		didSet { setNeedsDisplay() }
	}
	
	var initialTime: TimeInterval = 0.0 {
		didSet { setNeedsDisplay() }
	}
	
	var currentTIme: TimeInterval = 0.0 {
		didSet { setNeedsDisplay() }
	}
	
	private var _zoom: CGFloat = 1.0 {
		didSet { setNeedsDisplay() }
	}
	
	var zoom: CGFloat {
		get { return _zoom }
		set { _zoom = max(min(newValue, maxZoom), minZoom)}
	}
	
	var minZoom: CGFloat = 1.0 {
		didSet { zoom = _zoom}
	}
	
	var maxZoom: CGFloat = 3.5 {
		didSet { zoom = _zoom}
	}
	
	var intervalWidth: CGFloat = 24.0 {
		didSet { setNeedsDisplay() }
	}
	
	var intervalDuration: CGFloat = 15.0 {
		didSet { setNeedsDisplay() }
	}
	
	private func currentIntervalWidth() -> CGFloat {
		return intervalWidth * zoom
	}
	
	func timeIntervalFromDistance(distance: CGFloat) -> TimeInterval {
		return TimeInterval(distance * intervalDuration / currentIntervalWidth())
	}
	
}
