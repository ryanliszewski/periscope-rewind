//
//  HomeViewController.swift
//  PeriscopeRewind
//
//  Created by Ryan Liszewski on 3/7/18.
//  Copyright © 2018 ImThere. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		let videoURL = Bundle.main.url(forResource: "Corgi", withExtension: "mp4")!
		
		let videoViewController =  VideoViewController(videoURL: videoURL)
		present(videoViewController, animated: true, completion: nil)
	}

}
