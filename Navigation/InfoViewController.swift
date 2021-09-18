//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.showAlert.localized, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupButton()

        // Do any additional setup after loading the view.
    }
    
    private func setupButton() {
        view.addSubview(alertButton)
        
        let constraints = [
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func showAlert() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
