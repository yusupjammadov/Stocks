//
//  SearchVC.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 31.07.2025.
//

import UIKit
import RxCocoa
import RxSwift
import RxRelay

class SearchVC: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let searchRelay = BehaviorRelay<String>(value: "")
    static let expansionRelay = BehaviorRelay<Bool>(value: false)
    
    private var allItems: [StockItemModel]
    private var resultItems: [StockItemModel] {
        return allItems.filter {
            let searchText = searchRelay.value
            return $0.symbol.lowercased().contains(searchText.lowercased()) || $0.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    private let suggestionStockNames: [String] = ["Apple", "First Solar", "Amazon", "AliBaba", "Google", "Facebook", "Tesla", "Mastercard", "Microsoft", "Apple", "First Solar", "Amazon", "AliBaba", "Google", "Facebook", "Tesla", "Mastercard", "1", "2", "3"]
    
    private var mainView: SearchView {
        return view as! SearchView
    }
    override func loadView() {
        view = SearchView()
    }
    
    init(items: [StockItemModel]) {
        self.allItems = items
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        
        let waterfallLayout = mainView.coverView.collectionView.collectionViewLayout as? HorizontalWaterfallLayout
        waterfallLayout?.delegate = self
        mainView.coverView.collectionView.delegate = self
        mainView.coverView.collectionView.dataSource = self
        
        
        mainView.navBarSearch.backButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        mainView.navBarSearch.cancelButton.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.mainView.navBarSearch.searchTextField.text = ""
            self.searchRelay.accept("")
        }.disposed(by: disposeBag)
        
        mainView.navBarSearch.searchTextField.rx.text.orEmpty.bind(to: searchRelay).disposed(by: disposeBag)
        
        searchRelay.subscribe(onNext: { [weak self] text in
            guard let self = self else { return }
            self.mainView.navBarSearch.cancelButton.isHidden = text.isEmpty
            self.mainView.coverView.isHidden = !text.isEmpty
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        Self.expansionRelay.subscribe { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }.disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Self.expansionRelay.accept(false)
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return resultItems.count > 4 ? 1 : 0
        case 1:
            return Self.expansionRelay.value ? resultItems.count : min(resultItems.count, 4)
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchHeaderCell.identifier, for: indexPath)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
            let stockItem = resultItems[indexPath.row]
            let hasBackgroundColor = indexPath.row % 2 == 0
            cell.set(stockItem: stockItem, hasBackgroundColor: hasBackgroundColor)
            return cell
        default:
            fatalError()
        }
    }
}

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return suggestionStockNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuggestionCollectionCell.identifier, for: indexPath) as! SuggestionCollectionCell
        let stockName = suggestionStockNames[indexPath.item]
        cell.set(stockName: stockName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stockName = suggestionStockNames[indexPath.item]
        self.mainView.navBarSearch.searchTextField.text = stockName
        self.searchRelay.accept(stockName)
    }
}

extension SearchVC: HorizontalWaterfallLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, widthForItemAt indexPath: IndexPath, withRowHeight height: CGFloat) -> CGFloat {
        
        let stockName = suggestionStockNames[indexPath.item]
        let label = UILabel()
        label.font = .Montserrat_600_SemiBold(size: 12)
        label.text = stockName
        let width = label.intrinsicContentSize.width
        
        return 16+width+16
    }
}
