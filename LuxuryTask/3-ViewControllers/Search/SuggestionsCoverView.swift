//
//  SuggestionsCoverView.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 02.08.2025.
//

import UIKit

class SuggestionsCoverView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular requests"
        label.font = .Montserrat_700_Bold(size: 18)
        label.textColor = .LTPrimaryColor
        return label
    }()
    let collectionView: UICollectionView = {
        let layout = HorizontalWaterfallLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.register(SuggestionCollectionCell.self, forCellWithReuseIdentifier: SuggestionCollectionCell.identifier)
        return collectionView
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
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(16)
        }
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.height.equalTo(88)
        }
    }
}

class SuggestionCollectionCell: UICollectionViewCell {
    
    static let identifier = "SuggestionCollectionCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Montserrat_600_SemiBold(size: 12)
        label.textColor = .LTPrimaryColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .LTSecondaryBackgroundColor
        contentView.layer.cornerRadius = 20
        
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func set(stockName: String) {
        titleLabel.text = stockName
    }
}

