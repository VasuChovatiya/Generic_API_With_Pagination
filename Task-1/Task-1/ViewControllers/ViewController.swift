//
//  ViewController.swift
//  Task-1
//
//  Created by Vasu Chovatiya on 30/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -  IBOutlet
    
    @IBOutlet weak var viewMainContainer: UIView!
    @IBOutlet weak var tblViewNews: UITableView!
    
    
    // MARK: -  Properties
    
    private var viewModel: NewsViewModel = NewsViewModel()
    
    
    // MARK: -  LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNewArticles() 
        setupUI()
    }
    
    
    // MARK: -  Fucntions
    
    private func fetchNewArticles() {
        viewModel.delegate = self
        LoaderManager.showLoader()
        viewModel.fetchNewsArticles()
        LoaderManager.hideLoader()
    }
    private func setupUI() {
        
        setupTableView()
    }
    
    private func setupTableView() {
        tblViewNews.register(NewsTblCellView.nib, forCellReuseIdentifier: NewsTblCellView.identifier)
        tblViewNews.dataSource = self
        tblViewNews.delegate = self
        tblViewNews.reloadData()
    }
    
    
    
    // MARK: -  Actions
    
    
    
    
    // MARK: -  Deinit
    deinit {
        DLog("ViewController Deinited")
    }
    
    

}

//MARK: - NewsService Delegate

extension ViewController: NewsService {
    func reloadData() {
        self.tblViewNews.reloadData()
    }
}


// MARK: -  UITableViewDelegate, UITableViewDataSource

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.arrArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.arrArticles.count - 1 {
            
//            LoaderManager.showLoader()
//            viewModel.loadMoreData()
//            LoaderManager.hideLoader()
        }
        
        let info = viewModel.arrArticles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTblCellView.identifier, for: indexPath) as! NewsTblCellView
        cell.config(info: info)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if offsetY > contentHeight - scrollView.frame.size.height {
                /// we can do it here otherwise in cellForRowAt method also
                LoaderManager.showLoader()
                viewModel.loadMoreData()
                LoaderManager.hideLoader()
            }
        }
    
}


