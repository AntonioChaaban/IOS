//
//  FavoritesListTableViewController.swift
//  GoodNews
//

import Foundation
import UIKit

class FavoritesListTableViewController: UITableViewController {
    
    public var articleListVM: ArticleListViewModel!
    public var favorites : [Article] = []
    
    static var favoritosDaSessao = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    private func setup() {
        FavoritesListTableViewController.favoritosDaSessao = NewsListTableViewController.selectedFavoritos
        favorites = FavoritesListTableViewController.favoritosDaSessao
        self.articleListVM = ArticleListViewModel(articles: favorites)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("-----------------")
        print(favorites)
    }
    func deleteIndex(_ index:Int){
        articleListVM.articles.remove(at: index)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        FavoritesListTableViewController.favoritosDaSessao = articleListVM.articles
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive,title: "Delete") {
            [weak self] (action, view, completionHandler) in
            self?.deleteIndex(indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell", for: indexPath) as? ArticleTableViewCell

        else {
            fatalError("FavoritesTableViewCell not found")
        }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        
        cell.actionBlock = {
            guard let url = URL(string: articleVM.url) else {return}
            UIApplication.shared.open(url)
        }
        cell.titleFavorites.text = articleVM.title
        cell.descriptionFavorites.text = articleVM.description
        return cell
    }
}
