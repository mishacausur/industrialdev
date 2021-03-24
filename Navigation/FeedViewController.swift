//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

protocol FeedViewOutput {
    var navVC: UINavigationController? {get set}
    func showPostVC(_: Post)
}

final class FeedViewController: UIViewController {
    
    var output: FeedViewOutput?
    
    let containerView = ContainerView()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        output = PostPresenter()
        output?.navVC = navigationController
        setupContainer()
    }
    
    private func setupContainer(){
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        
        NSLayoutConstraint.activate(constraints)
        
        containerView.onTap = output?.showPostVC
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
}


class ContainerView: UIStackView {
    
    var onTap: ((Post) -> Void)?
    
    let post: Post = Post(title: "Пост")
    
    let addPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Open post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(navButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add new post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(navButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    @objc private func navButton(){
      onTap?(post)
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addArrangedSubview(addPostButton)
        self.addArrangedSubview(postButton)
        self.axis = .vertical
        self.spacing = 10
    }
    
}

class PostPresenter: FeedViewOutput {

    var navVC: UINavigationController?
    
    func showPostVC(_ post: Post) {
        let postVC = PostViewController()
        postVC.post = post
        navVC?.pushViewController(postVC, animated: true)
    }
    
    
}
