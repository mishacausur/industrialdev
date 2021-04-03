//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.backgroundColor = .red
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentInfoVC))
    }
    
    @objc private func presentInfoVC() {
        let infoVC = InfoViewController()
        present(infoVC, animated: true, completion: nil)
    }
}
