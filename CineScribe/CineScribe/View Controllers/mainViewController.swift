//
//  ViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

	// MARK: - Properties & Outlets
	@IBOutlet weak var listTableView: UITableView!



	override func viewDidLoad() {
		super.viewDidLoad()
		listTableView.delegate = self
		listTableView.dataSource = self

	}

	// MARK: - IBActions


}

extension mainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell else { return UITableViewCell() }


		return cell
	}

	
}

