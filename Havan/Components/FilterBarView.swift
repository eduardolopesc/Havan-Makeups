//
//  FilterBarView.swift
//  Havan
//
//  Created by Eduardo on 24/05/23.
//

import Foundation
import UIKit

class FilterBarView: UIView {
    
    var didTapNumericButton: (() -> Void)?
    var didTapAlphabeticButton: (() -> Void)?
    var didTapClearButton: (() -> Void)?

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .leading
        view.distribution = .fillProportionally
        view.spacing = 8.0
        return view
    }()
    
    private let filterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Sort:"
        return label
    }()
    
    private let alphabeticButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "character.book.closed"), for: .normal)
        button.setTitle("Name", for: .normal)
        button.addTarget(self, action: #selector(alphabeticButtonTapped), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.sizeToFit()
        return button
    }()

    private let numericButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "dollarsign.circle"), for: .normal)
        button.setTitle("Price", for: .normal)
        button.addTarget(self, action: #selector(numericButtonTapped), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.sizeToFit()
        return button
    }()

    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.setTitle("Clear", for: .normal)
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.sizeToFit()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .white
        buildViewHierarchy()
        addConstraints()
    }
        
    private func buildViewHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(filterLabel)
        stackView.addArrangedSubview(alphabeticButton)
        stackView.addArrangedSubview(numericButton)
        stackView.addArrangedSubview(clearButton)
    }
        

    private func addConstraints() {
        let margin: CGFloat = 16

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: margin),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func alphabeticButtonTapped() {
        self.didTapAlphabeticButton?()
    }

    @objc private func numericButtonTapped() {
        self.didTapNumericButton?()
    }

    @objc private func clearButtonTapped() {
        self.didTapClearButton?()
    }
    
}
