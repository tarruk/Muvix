//
//  ApiPageManager.swift
//  MoviesApp
//
//  Created by Tarek on 13/03/2021.
//


import Foundation
import RxSwift
import RxCocoa

final class APIPageManager<Element> {
    typealias FetchHandler = (Int) -> Single<[Element]>
    
    private let fetchHandler: FetchHandler
    private(set) var state: BehaviorRelay<State> = .init(value: .waiting)
    private var currentPage: Int = 0
    let elements: BehaviorRelay<[Element]> = .init(value: [])
    let keyword: BehaviorRelay<String?> = .init(value: nil)
    let category: BehaviorRelay<String?> = .init(value: nil)
    var currentRequest: Disposable?
    let disposeBag = DisposeBag()
    
    init(fetchHandler: @escaping FetchHandler) {
        self.fetchHandler = fetchHandler
        self.requestNewPage()
        self.searchSetup()
    }
    
    deinit {
        self.currentRequest?.dispose()
    }
    
    private func searchSetup() {
        self.keyword
            .skip(1)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                self?.reload()
            }
        ).disposed(by: self.disposeBag)
        
        self.category
            .skip(1)
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (_) in
                self?.reload()
            }
        ).disposed(by: self.disposeBag)
        
    }
    
    func requestNewPage() {
        if self.state.value == .waiting {
            fetchElements()
        }
    }
    
    @objc func reload() {
        self.currentPage = 0
        self.state.accept(.waiting)
        self.fetchElements()
    }

    
    private func fetchElements() {
        self.currentRequest?.dispose()
        
        let page   = self.getPageToRequest()
        self.state.accept(.loading)
        
        self.currentRequest = self.fetchHandler(page, keyword.value, category.value)
            .subscribe(
                onSuccess: { [weak self] (_elements) in
                    guard let self = self else { return }
                    self.currentPage += 1
                    self.state.accept(_elements.isEmpty ? .reachedEnd : .waiting)
                    let newElements = page == 1 ? _elements : self.elements.value + _elements
                    self.elements.accept(newElements)
            },
                onError: { [weak self] (error) in
                    self?.state.accept(.waiting)
                    if error.localizedDescription != "cancelled" {
                        print(error)
                    }
            }
        )
    }
    
    private func getPageToRequest() -> Int {
        return self.currentPage + 1
    }
    
    enum State {
        case loading
        case reachedEnd
        case waiting
    }
}
