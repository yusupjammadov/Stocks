//
//  NavBarSearch.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 31.07.2025.
//

import UIKit

class NavBarSearch: UIView {
    
    private let safeContainerView = UIView()
    
    private let searchContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.LTPrimaryColor.cgColor
        return view
    }()
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.back24X24.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.cancel24X24.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let searchTextField: UITextField = {
        let field = UITextField()
        field.font = .Montserrat_600_SemiBold(size: 16)
        field.textColor = .LTPrimaryColor
        field.tintColor = .LTPrimaryColor
        let placeholder = NSAttributedString(string: "Find company or ticker", attributes: [.foregroundColor: UIColor.LTSecondaryColor])
        field.attributedPlaceholder = placeholder
        return field
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
        addSubview(safeContainerView)
        safeContainerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.height.equalTo(80)
        }
        
        safeContainerView.addSubview(searchContainerView)
        searchContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-16)
        }
        searchContainerView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        searchContainerView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        searchContainerView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(8)
            make.trailing.equalTo(cancelButton.snp.leading).offset(-8)
            make.verticalEdges.equalToSuperview()
        }
    }
}
