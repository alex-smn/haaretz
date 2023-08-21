//
//  NewsViewModel.swift
//  haAretzHome
//
//  Created by Alexander Livshits on 21/08/2023.
//

import Foundation
import Combine
import UIKit

class NewsViewModel {
    @Published var model: NewsModel
    
    init() {
        self.model = NewsModel()
    }
    
    func start() {
        refreshData()
    }
    
    func refreshData() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            let result = self.loadData()
            DispatchQueue.main.async { [weak self] in
                self?.handleNewData(result)
            }
        }
    }
    
    private func handleNewData(_ result: Result<NewsModel, Error>) {
        switch result {
        case .success(let model):
            self.model = model
            loadImages()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    private func loadData() -> Result<NewsModel, Error> {
        guard let url = URL(string: Constants.newsUrl) else { return .failure(NewsError.jsonNotFound) }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let model = try decoder.decode(NewsModel.self, from: data)
            return .success(model)
        } catch {
            return .failure(error)
        }
    }
    
    private func loadImages() {
        for (sectionIndex, section) in model.main.enumerated() {
            for (itemIndex, item) in section.items.enumerated() {
                guard let url = URL(string: item.imageLink ?? "") else { continue }
                
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: url)
                        let image = UIImage(data: data)
                        DispatchQueue.main.async { [weak self] in
                            self?.model.main[sectionIndex].items[itemIndex].image = image
                        }
                    } catch {
                        return
                    }
                }
            }
        }
        
        
    }
}
