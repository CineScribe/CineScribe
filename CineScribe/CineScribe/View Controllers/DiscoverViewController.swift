//
//  DiscoverViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {

	@IBOutlet weak var movieSearchBar: UISearchBar!
//	private var searchVC: SearchTableViewController?

	override func viewDidLoad() {
        super.viewDidLoad()
//		movieSearchBar.delegate = searchVC
    }
    
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let searchVC = segue.destination as? SearchTableViewController {
//			self.searchVC = searchVC
			movieSearchBar.delegate = searchVC
		}
	}
}
