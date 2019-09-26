//
//  ViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/23/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	//MARK: - IBOutlets
	
	@IBOutlet weak var listTableView: UITableView!
	
	//MARK: - Properties
	
	let firebaseClient = FirebaseClient()
	
	//MARK: - Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		listTableView.dataSource = self
		
		firebaseClient.getAllCollections {
			self.listTableView.reloadData()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let notesVC = segue.destination as? ReviewsViewController, let indexPath = listTableView.indexPathForSelectedRow {
			notesVC.firebaseClient = firebaseClient
			notesVC.currentCollection = firebaseClient.userCollections[indexPath.row]
		}
	}
	
	//MARK: - IBActions
	
	@IBAction func createListButtonTapped(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Enter a title for your new list", message: nil, preferredStyle: .alert)
		alert.addTextField { (textField) in
			textField.placeholder = "List Name"
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let addAction = UIAlertAction(title: "Add", style: .default) { _ in
			guard let properTitle = alert.textFields?.first?.optionalText else { return }
			self.firebaseClient.createCollection(title: properTitle) {
				print("Collection Saved!")
			}
		}

		[addAction, cancelAction].forEach{ alert.addAction($0) }

		present(alert, animated: true, completion: nil)
	}
	
	//MARK: - Helpers


}

//MARK: - TableView Datasource

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		firebaseClient.userCollections.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? CollectionCell else { return UITableViewCell() }

		cell.collection = firebaseClient.userCollections[indexPath.row]

		return cell
	}
}
