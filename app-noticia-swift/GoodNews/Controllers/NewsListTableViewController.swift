//
//  NewsListTableViewController.swift
//  GoodNews
//

import Foundation
import UIKit
extension UITableViewController{
    var tableViewController : UITableViewController?{
        return next as? UITableViewController
    }
}

class NewsListTableViewController: UITableViewController {
    
    public var articleListVM: ArticleListViewModel!
    public var favoritos:[Article] = []
    
    static var selectedFavoritos = [Article]()
    
    var selectButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NewsListTableViewController.selectedFavoritos =
            FavoritesListTableViewController.favoritosDaSessao
        favoritos = FavoritesListTableViewController.favoritosDaSessao
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=pt&apiKey=0cf790498275413a9247f8b94b3843fd")!
        
        Webservice().getArticles(url: url) { articles in
            
            if let articles = articles {
                
                self.articleListVM = ArticleListViewModel(articles: articles)
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    private func handleMarkAsFavourite(_ index: Int) {
        print("Marked as favourite")
        if(favoritos.count == 0){
            favoritos.append(self.articleListVM.articles[index])
        }else{
            var aux: Int = 0
            for i in favoritos{
                if(i.title == self.articleListVM.articles[index].title){
                    aux += 1
                }
            }
            if(aux == 0){
                favoritos.append(self.articleListVM.articles[index])
            }
        }
        NewsListTableViewController.selectedFavoritos = favoritos
        print(favoritos)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive,title: "Favourite") {
            [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite(indexPath.row)
            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell

        else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        
        cell.actionBlock = {
            guard let url = URL(string: articleVM.url) else {return}
            UIApplication.shared.open(url)
        }
        cell.titleLabel.text = articleVM.title
        cell.descriptionLabel.text = articleVM.description
        return cell 
    }
    
}
