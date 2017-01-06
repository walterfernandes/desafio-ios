//
//  Pull.swift
//  Desafio
//
//  Created by Walter Fernandes de Carvalho on 05/01/17.
//  Copyright © 2017 Walter Fernandes de Carvalho. All rights reserved.
//

import Foundation

class Pull {
    
    var title: String
    var state: String
    var htmlURL: String
    var body: String?
    var user: User
    
    init (_ title: String, state: String, htmlURL: String, description: String?, user:User) {
        self.title = title
        self.state = state
        self.htmlURL = htmlURL
        self.body = description
        self.user = user
    }
    
    convenience init? (with object: [String: AnyObject]) {
        
        guard let title = object["title"] as? String else {
            return nil
        }
        
        guard let state = object["state"] as? String else {
            return nil
        }
        
        guard let htmlURL = object["html_url"] as? String else {
            return nil
        }

        guard let user = User(with: object["user"] as! [String : AnyObject]) else {
            return nil
        }
        
        let description = object["body"] as? String

        self.init (title, state: state, htmlURL: htmlURL, description: description, user: user)
    }
    
}
