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
     @IBOutlet private weak var buildVersionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
		[jeffImageView, marlonImageView].forEach { $0?.layer.cornerRadius = 12 }
        guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] else { return }
        guard let buildNumber = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") else { return }
        buildVersionLabel.text = "Version: \(version) ⌇ Build: \(buildNumber)"
    }
}
