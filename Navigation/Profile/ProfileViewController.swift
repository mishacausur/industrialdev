//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Миша Козырь on 16.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    let tapToPics = UITapGestureRecognizer(target: self, action: #selector(tapToPhotos))

    @objc func tapToPhotos(sender: UITapGestureRecognizer){
        print("Tapped")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupViews()
        view.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .black)
        
    }
    
    
    private func setupTable(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
    }
    private func setupViews() {
        view.addSubview(tableView)
       
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    var cellHeight: CGFloat {return (view.frame.width - 24 - (8*3)) / (view.frame.width * 4)}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        } else {
            let tableSection = Storage.posts.count
            return tableSection
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        let post = Storage.posts[indexPath.row]
        cell.post = post
        cell.completion = { [weak self] in
            guard let self = self else {
                return
            }

        }
           
       
        let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
        if (indexPath.section == 0) {
            return photoCell } else {
                return cell
            }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let vc = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as! ProfileHeaderView
        return vc
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                    guard section == 0 else { return .zero }
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section == 0 else { return }
            let vc = PhotosViewController()
            navigationController?.pushViewController(vc, animated: true)
    }
}

