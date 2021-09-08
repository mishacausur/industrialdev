//
//  FavViewController.swift
//  Navigation
//
//  Created by Misha Causur on 05.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class FavViewController: UIViewController {
    
    var dataModel: DataStorageModel!
    
    var items: [DataPostModel] = []
    
    private var filterItem: String?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Фильтр по автору", message: "Укажите автора поста для фильтрации", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel)
        let filter = UIAlertAction(title: "Применить", style: .default) { [weak self] (action) in
            guard let text = alert.textFields?[0].text else {
                return
            }
            self?.filterItem = text
            self?.items = self!.dataModel.getFavoritePosts(autor: self?.filterItem)
            self?.tableView.reloadData()
        }
        
        alert.addAction(cancel)
        alert.addAction(filter)
        alert.addTextField(configurationHandler: nil)
        present(alert, animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        filterItem = nil
        items = dataModel.getFavoritePosts(autor: filterItem)
        self.tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        guard let data = dataModel.getFavoritePosts(autor: filterItem) else { return }
//        items = data
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupViews()
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
        let tableSection = items.count
        return tableSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        let post = items[indexPath.row]
        let postForCell = dataModel.dataPostToPost(post: post)
        cell.post = postForCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { [self](action, view, completion) in
            let post = self.items[indexPath.row]
            self.dataModel.remove(post: post)
            items = dataModel.getFavoritePosts(autor: filterItem)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
          delete.image = UIImage(systemName: "trash")
          let swipe = UISwipeActionsConfiguration(actions: [delete])
          return swipe
      }
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
}

