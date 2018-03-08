//
//  VideoViewController.swift
//  PeriscopeRewind
//
//  Created by Ryan Liszewski on 3/7/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit
import AVFoundation


class VideoViewController: UIViewController {

	private var videoURL: URL!
	
	private var asset: AVURLAsset!
	private var playerItem: AVPlayerItem!
	private var player: AVPlayer!
	private var playerLayer: AVPlayerLayer!
	
	private var longPressGestureRecgonizer: UILongPressGestureRecognizer!
	
	private let rewindDimView = UIVisualEffectView()
	
	private let rewindContentView = UIView()
	private let rewindTimelineView = TimelineView()
	private var previousLocationX: CGFloat = 0.0
	
	//MARK: -
	
	init(videoURL: URL){
		super.init(nibName: nil, bundle: nil)
		
		self.videoURL = videoURL
		
		asset = AVURLAsset(url: videoURL)
		playerItem = AVPlayerItem(asset: asset)
		player = AVPlayer(playerItem: playerItem)
		playerLayer = AVPlayerLayer(player: player)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	//MARK: - View Layout
	
	override func loadView() {
		super.loadView()
		
		view.backgroundColor = .black
		view.layer.addSublayer(playerLayer)
		longPressGestureRecgonizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(gesture:)))
	
		view.addGestureRecognizer(longPressGestureRecgonizer)
		view.addSubview(rewindDimView)
		
		rewindContentView.alpha = 0.0
		
		rewindContentView.addSubview(rewindTimelineView)
		view.addSubview(rewindContentView)
		rewindTimelineView.duration = CMTimeGetSeconds(asset.duration)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		player.play()
	}
		
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		playerLayer.frame = view.bounds
		rewindDimView.frame = view.bounds
		
		rewindContentView.frame = view.bounds
		rewindTimelineView.frame = CGRect(x: 0.0, y: view.bounds.height - 150.0, width: view.bounds.width, height: 10.0)
	}
	
	
	@objc func longPressed(gesture: UILongPressGestureRecognizer){
		
		let location = gesture.location(in: gesture.view!)
		rewindTimelineView.zoom = (location.y - rewindTimelineView.center.y - 10.0) / 30.0
		
		if gesture.state == .began {
			player.pause()
			
			rewindTimelineView.initialTime = CMTimeGetSeconds(playerItem.currentTime())
			
			UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {self.rewindDimView.effect = UIBlurEffect(style: .dark)
				self.rewindContentView.alpha = 1.0
			}, completion: nil)
			
		} else if gesture.state == .changed {
			rewindTimelineView.rewindByDistance(distance: previousLocationX - location.x)
		} else {
			player.play()
			UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut], animations: {self.rewindDimView.effect = nil
				self.rewindContentView.alpha = 0.0
				}, completion: nil)
		}
		
		if previousLocationX != location.x {
			previousLocationX = location.x
		}
	}
}
