//
//  NewsSectionModel.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import Foundation

struct NewsSectionModel: Decodable {
    var title: String = ""
    var items: [NewsItem] = []
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try container.decode(String.self, forKey: .title)
        self.items = try container.decode([NewsItem].self, forKey: .items)
    }
    
    private enum CodingKeys: String, CodingKey {
        case title
        case items
    }
}
