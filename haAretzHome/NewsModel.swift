//
//  NewsModel.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import Foundation

struct NewsModel: Decodable {
    var main: [NewsSectionModel] = []
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.main = try container.decode([NewsSectionModel].self, forKey: .main)
    }
    
    private enum CodingKeys: String, CodingKey {
        case configuration
        case header
        case main
    }
}
