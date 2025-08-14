//
//  ListView.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 29.07.2025.
//

import UIKit
import SnapKit

class ListView: UIView {
    
    let navBarList = NavBarList()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 68, left: 0, bottom: 16, right: 0)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(60)
            make.bottom.equalToSuperview()
        }
        
        addSubview(navBarList)
        navBarList.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
