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
	
	private var longPressGestureRecgonizer: UILongPressGestureRecognizer = {
		return UILongPressGestureRecognizer (target: self, action: Selector("longPressed:"))
	}()
	
	private let rewindDimView = UIVisualEffectView()
	
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
	
	//MARK: - 
	
	override func loadView() {
		super.loadView()
		
		view.backgroundColor = .black
		view.layer.addSublayer(playerLayer)
		
		
		
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
	}
		
}