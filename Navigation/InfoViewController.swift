//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    var textForLabel: String?
    var textOrbitalLabel: String?
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "herthe"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orbitalLabel: UILabel = {
        let label = UILabel()
        label.text = "herthe"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Alert", for: .normal)
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
        view.addSubview(textLabel)
        view.addSubview(orbitalLabel)
        view.addSubview(alertButton)
        textLabel.text = JsonModelForFirstTask.textForLabel
        orbitalLabel.text = JsonModel.orbital
        
       
        
        let constraints = [
            orbitalLabel.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -15),
            orbitalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -15),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
