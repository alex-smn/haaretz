//
//  NewsItem.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import Foundation
import UIKit

struct NewsItem: Decodable {
    var link: String?
    var title: String?
    var imageLink: String?
    var image: UIImage?
    var author: String?
    var type: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.link = try container.decodeIfPresent(String.self, forKey: .link)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.imageLink = try container.decodeIfPresent(String.self, forKey: .image)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.type = try container.decodeIfPresent(Int.self, forKey: .type)
    }
    
    private enum CodingKeys: String, CodingKey {
        case link
        case title
        case image
        case author
        case type
    }
}
