//
//  ListVC.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 29.07.2025.
//

import UIKit
import RxSwift

class ListVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var isShowOnlyFavourites = false
    private var allItems = [StockItemModel]()
    private var favouriteItems: [StockItemModel] {
        return allItems.filter { FavManager.get(isFav: $0.symbol) }
    }
    
    private var mainView: ListView {
        return view as! ListView
    }
    override func loadView() {
        view = ListView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.navBarList.searchContainer.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            let vc = SearchVC(items: allItems)
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        mainView.navBarList.stocksButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.mainView.navBarList.makeStocksButtonSelected()
            self.isShowOnlyFavourites = false
            self.mainView.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        mainView.navBarList.favouriteButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.mainView.navBarList.makeFavouriteButtonSelected()
            self.isShowOnlyFavourites = true
            self.mainView.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        FavManager.favRelay.subscribe { [weak self] _, isFav in
            guard let self = self else { return }
            self.mainView.tableView.reloadData()
        }.disposed(by: disposeBag)
        
        getInfo()
    }
}

extension ListVC {
    
    private func getInfo() {
        let urlString = "https://mustdev.ru/api/stocks.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Request error: \(error)")
                return
            }
            guard let data = data else {
                print("Data error: (data == nil)")
                return
            }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([StockItemModel].self, from: data)
                self?.allItems = items
            } catch {
                print("Decode error: \(error)")
            }
            
            DispatchQueue.main.async {
                self?.mainView.tableView.reloadData()
            }
        }.resume()
    }
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowOnlyFavourites ? favouriteItems.count : allItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        let stockItem = isShowOnlyFavourites ? favouriteItems[indexPath.row] : allItems[indexPath.row]
        let hasBackgroundColor = indexPath.row % 2 == 1
        cell.set(stockItem: stockItem, hasBackgroundColor: hasBackgroundColor)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        var newHeight: CGFloat = 128 - (yOffset+68)
        if newHeight > 128 {
            newHeight = 128
        } else if newHeight < 60 {
            newHeight = 60
        }
        let alpha = ((newHeight-60) - 17) / 51
        
        mainView.navBarList.update(height: newHeight, alpha: alpha)
    }
}
