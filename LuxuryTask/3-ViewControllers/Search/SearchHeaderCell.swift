//
//  SearchHeaderCell.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 31.07.2025.
//

import UIKit
import RxSwift

class SearchHeaderCell: UITableViewCell {
    
    static let identifier = "SearchHeaderCell"
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Stocks"
        label.font = .Montserrat_700_Bold(size: 18)
        label.textColor = .LTPrimaryColor
        return label
    }()
    private let expansionButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .Montserrat_600_SemiBold(size: 12)
        button.setTitleColor(.LTPrimaryColor, for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .white
        
        expansionButton.rx.tap.bind {
            let toggled = !SearchVC.expansionRelay.value
            SearchVC.expansionRelay.accept(toggled)
        }.disposed(by: disposeBag)
        
        SearchVC.expansionRelay.subscribe { [weak self] isExpanded in
            guard let self = self else { return }
            let buttonTitle = isExpanded ? "Show less" : "Show more"
            expansionButton.setTitle(buttonTitle, for: .normal)
        }.disposed(by: disposeBag)
        
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentView.addSubview(expansionButton)
        expansionButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.verticalEdges.equalTo(titleLabel)
        }
    }
}
