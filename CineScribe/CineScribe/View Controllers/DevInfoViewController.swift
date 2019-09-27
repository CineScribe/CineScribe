//
//  DevInfoViewController.swift
//  CineScribe
//
//  Created by Marlon Raskin on 9/26/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

class DevInfoViewController: UIViewController {

	 @IBOutlet private weak var jeffImageView: UIImageView!
	 @IBOutlet private weak var marlonImageView: UIImageView!


    override func viewDidLoad() {
        super.viewDidLoad()

		[jeffImageView, marlonImageView].forEach { $0?.layer.cornerRadius = 12 }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
