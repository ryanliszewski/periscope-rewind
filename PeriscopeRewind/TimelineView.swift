//
//  TimelineView.swift
//  PeriscopeRewind
//
//  Created by Ryan Liszewski on 3/7/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit

class TimelineView: UIView {
	
	
	init(){
		super.init(frame: .zero)
		isOpaque = false
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		let intervalWidth = currentIntervalWidth()
		
		let originX: CGFloat = bounds.width / 2.0 - distanceFromTimeInterval(timeInterval: currentTime)
		let context = UIGraphicsGetCurrentContext()
		let lineHeight: CGFloat = 5.0;
		
		//Calculate how many intervals
		let intervalsCount = CGFloat(duration) / intervalDuration
		
		//Full Line
		context?.setFillColor(UIColor(white: 0.45, alpha: 1.0).cgColor)
		
		let totalPath = UIBezierPath(roundedRect: CGRect(x: originX, y: 0.0, width: intervalWidth * intervalsCount, height: lineHeight), cornerRadius: lineHeight).cgPath
		
		context?.addPath(totalPath)
		context?.fillPath()
		
		//Draw elapsed line
		context?.setFillColor(UIColor.white.cgColor)
		
		let elapsedPath = UIBezierPath(roundedRect: CGRect(x: originX, y: 0, width: distanceFromTimeInterval(timeInterval: currentTime), height: lineHeight), cornerRadius: lineHeight).cgPath
		context?.addPath(elapsedPath)
		context?.fillPath()
		
		context?.fillEllipse(in: CGRect(x: originX + distanceFromTimeInterval(timeInterval: initialTime), y: 7.0, width: 3.0, height: 3.0))
		
		context?.setFillColor(UIColor(white: 0.00, alpha: 0.5).cgColor)
		
		var intervalIndex: CGFloat = 0.0
		
		repeat {
			intervalIndex += 1.0
			
			if intervalsCount - intervalIndex > 0.0 {
				context?.fill(CGRect(x: originX + intervalWidth + intervalIndex, y: 0.0, width: 1.0, height: lineHeight))
			}
		} while intervalIndex < intervalsCount
		
	}
	
	var duration: TimeInterval = 0.0 {
		didSet { setNeedsDisplay() }
	}
	
	var initialTime: TimeInterval = 0.0 {
		didSet { setNeedsDisplay() }
	}
	
	var currentTime: TimeInterval = 0.0 {
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
	
	var intervalWidth: CGFloat = 30.0 {
		didSet { setNeedsDisplay() }
	}
	
	var intervalDuration: CGFloat = 2.0 {
		didSet { setNeedsDisplay() }
	}
	
	private func currentIntervalWidth() -> CGFloat {
		return intervalWidth * zoom
	}
	
	func timeIntervalFromDistance(distance: CGFloat) -> TimeInterval {
		return TimeInterval(distance * intervalDuration / currentIntervalWidth())
	}
	
	//Calculates distance from given time interval
	func distanceFromTimeInterval(timeInterval: TimeInterval) -> CGFloat {
		return currentIntervalWidth() * CGFloat(timeInterval) / intervalDuration
	}
	
	func rewindByDistance(distance: CGFloat) {
		let newCurrentTime = currentTime + timeIntervalFromDistance(distance: distance)
		currentTime = max(min(newCurrentTime, duration), 0.0)
	}
	
	
}
