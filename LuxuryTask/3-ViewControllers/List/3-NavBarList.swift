//
//  NavBarList.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 30.07.2025.
//

import UIKit

class NavBarList: UIView {
    
    private let safeContainerView = UIView()
    
    private let stocksButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "Stocks"
        label.font = .Montserrat_700_Bold(size: 28)
        label.textColor = .LTPrimaryColor
        return label
    }()
    let stocksButton = UIButton()
    
    private let favouriteButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "Favourite"
        label.font = .Montserrat_700_Bold(size: 18)
        label.textColor = .LTSecondaryColor
        return label
    }()
    let favouriteButton = UIButton()
    
    let searchContainer: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.LTPrimaryColor.cgColor
        return button
    }()
    private let searchIcon = UIImageView(image: .search24X24)
    private let searchLabel: UILabel = {
        let label = UILabel()
        label.font = .Montserrat_600_SemiBold(size: 16)
        label.text = "Find company or ticker"
        label.textColor = .LTPrimaryColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2/2
//        layer.shadowOpacity = 0.05
        layer.masksToBounds = false
        
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(safeContainerView)
        safeContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.height.equalTo(128)
        }
        
        safeContainerView.addSubview(stocksButton)
        stocksButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-12)
        }
        stocksButton.addSubview(stocksButtonLabel)
        stocksButtonLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        safeContainerView.addSubview(favouriteButton)
        favouriteButton.snp.makeConstraints { make in
            make.leading.equalTo(stocksButton.snp.trailing).offset(20)
            make.bottom.equalToSuperview().offset(-12)
        }
        favouriteButton.addSubview(favouriteButtonLabel)
        favouriteButtonLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(-2)
        }
        
        safeContainerView.addSubview(searchContainer)
        searchContainer.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-64)
        }
        searchContainer.addSubview(searchIcon)
        searchIcon.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        searchContainer.addSubview(searchLabel)
        searchLabel.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(8)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    func makeStocksButtonSelected() {
        stocksButtonLabel.font = .Montserrat_700_Bold(size: 28)
        stocksButtonLabel.textColor = .LTPrimaryColor
        
        favouriteButtonLabel.font = .Montserrat_700_Bold(size: 18)
        favouriteButtonLabel.textColor = .LTSecondaryColor
        
        stocksButtonLabel.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
        favouriteButtonLabel.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
        }
    }
    func makeFavouriteButtonSelected() {
        stocksButtonLabel.font = .Montserrat_700_Bold(size: 18)
        stocksButtonLabel.textColor = .LTSecondaryColor
        
        favouriteButtonLabel.font = .Montserrat_700_Bold(size: 28)
        favouriteButtonLabel.textColor = .LTPrimaryColor
        
        stocksButtonLabel.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-2)
        }
        favouriteButtonLabel.snp.updateConstraints { make in
            make.bottom.equalToSuperview()
        }
    }
    
    func update(height: CGFloat, alpha: CGFloat) {
        safeContainerView.snp.updateConstraints { make in
            make.height.equalTo(height)
        }
        searchContainer.alpha = alpha
        layer.shadowOpacity = 0.05 * Float(1-alpha)
    }
}
