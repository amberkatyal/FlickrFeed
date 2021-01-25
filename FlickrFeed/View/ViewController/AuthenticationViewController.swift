//
//  AuthenticationViewController.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit

final class AuthenticationViewController: UIViewController, HasCustomView {

    typealias CustomView = AuthenticationView
    
    
    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        self.view = AuthenticationView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thisView.authButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func didTapLogin() {
        let _ = OAuthService()
    }

}
