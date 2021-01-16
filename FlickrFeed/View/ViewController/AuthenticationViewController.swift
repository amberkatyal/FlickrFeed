//
//  AuthenticationViewController.swift
//  FlickrFeed
//
//  Created by Amber Katyal on 15/01/21.
//  Copyright © 2021 Amber Katyal. All rights reserved.
//

import UIKit
import OAuthSwift

final class AuthenticationViewController: UIViewController, HasCustomView {

    typealias CustomView = AuthenticationView
    
    
    // MARK: - Init
    var oAuthSwift: OAuth1Swift!
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
        let service = OAuthService()
//        oAuthSwift = OAuth1Swift(consumerKey: infoForKey(.FLICKR_API_KEY),
//                                     consumerSecret: infoForKey(.FLICKR_API_SECRET),
//                                requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
//                                authorizeUrl: "https://www.flickr.com/services/oauth/authorize",
//                                accessTokenUrl: "https://www.flickr.com/services/oauth/access_token")
//        oAuthSwift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oAuthSwift)
//        let handle = oAuthSwift.authorize( withCallbackURL: "https://www.example.com") { result in
//            switch result {
//            case .success(let (credential, response, parameters)):
//                print(credential.oauthToken)
//                print(credential.oauthTokenSecret)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }

}
