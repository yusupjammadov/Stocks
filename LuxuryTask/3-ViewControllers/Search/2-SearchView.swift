//
//  SearchView.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 31.07.2025.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let navBarSearch = NavBarSearch()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.keyboardDismissMode = .onDrag
        tableView.register(SearchHeaderCell.self, forCellReuseIdentifier: SearchHeaderCell.identifier)
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        return tableView
    }()
    
    let coverView = SuggestionsCoverView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(navBarSearch)
        navBarSearch.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(navBarSearch.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        addSubview(coverView)
        coverView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(navBarSearch.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
}
