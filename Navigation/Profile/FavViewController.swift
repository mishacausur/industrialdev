//
//  FavViewController.swift
//  Navigation
//
//  Created by Misha Causur on 05.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    var dataStorage: DataStorage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupTable(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
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

extension FavViewController: UITableViewDelegate, UITableViewDataSource {
    var cellHeight: CGFloat {return (view.frame.width - 24 - (8*3)) / (view.frame.width * 4)}
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dataModel = DataStorageModel()
        dataStorage = DataStorage(dataStorage: dataModel)
        guard let tableSection = dataStorage?.getFavorites().count else {
            return 0
        }
        return tableSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        let dataModel = DataStorageModel()
        dataStorage = DataStorage(dataStorage: dataModel)
        guard let post = dataStorage?.getFavorites()[indexPath.row],
              let postForCell = dataStorage?.toPost(post: post) else {
            return UITableViewCell()
        }
        cell.post = postForCell
        
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        guard indexPath.section == 0 else { return }
//            let vc = PhotosViewController()
//            navigationController?.pushViewController(vc, animated: true)
//    }
}

