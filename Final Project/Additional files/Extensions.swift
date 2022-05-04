//
//  Extensions.swift
//  Final Project
//
//  Created by Денис Сторожик on 04.05.2022.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

extension String {
    func deletingPrefix() -> String {
        let newString = self.components(separatedBy: "/")
        return newString[1]
    }
    
    func deletingSuffix() -> String {
        let newString = self.components(separatedBy: "/")
        return newString[0]
}
}
