//
//  LogoModel.swift
//  PhonePeCodingAssigment
//
//  Created by "" on 25/01/21.
//

import Foundation
typealias LogoList = [LogoModel]
struct LogoModel: Codable {
    let imgUrl: String
    let name: String
}
