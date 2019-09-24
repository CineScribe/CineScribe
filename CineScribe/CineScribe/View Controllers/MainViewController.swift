//
//  ViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	// MARK: - Properties & Outlets
	@IBOutlet weak var listTableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		listTableView.delegate = self
		listTableView.dataSource = self
	}

	// MARK: - IBActions
	@IBAction func createListButtonTapped(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Enter a title for your new list", message: nil, preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "List Name"
		}

		let addAction = UIAlertAction(title: "Add", style: .default) { _ in
			// Jeff's code goes here
		}

		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		[addAction, cancelAction].forEach { alert.addAction($0) }

		present(alert, animated: true, completion: nil)
	}


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ListTableViewCell else { return UITableViewCell() }


		return cell
	}
}

extension UIAlertController {
	open override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.view.tintColor = .systemPink
	}
}

