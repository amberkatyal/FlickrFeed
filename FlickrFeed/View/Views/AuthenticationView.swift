//
//  AuthenticationView.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

final class AuthenticationView: UIView {
    
    // MARK: - Views
    let authButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        backgroundColor = .systemBackground
        addSubview(authButton)
        authButton.center(in: self)
        
    }
}
