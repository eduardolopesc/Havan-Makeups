//
//  ListViewModelTests.swift
//  HavanTests
//
//  Created by Eduardo on 24/05/23.
//

import XCTest
@testable import Havan

class ListViewModelTests: XCTestCase {
    
    var viewModel: ListViewModel!
    var service: ProductServiceMock!
    var coordinator: CoordinatorMock!
    
    override func setUp() {
        super.setUp()
        service = ProductServiceMock()
        coordinator = CoordinatorMock(navigationController: UINavigationController())
        viewModel = ListViewModel(service: service, coordinator: coordinator)
    }
    
    override func tearDown() {
        viewModel = nil
        service = nil
        coordinator = nil
        super.tearDown()
    }
    
    func testFetchProducts_Success() {
        let expectedProducts = [Product(id: 1, name: "Product 1", price: "10.99")]
        service.result = .success(expectedProducts)
        
        viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products, expectedProducts)
    }
    
    func testFetchProducts_Failure() {
        let expectedError = TestError.testFailure
        service.result = .failure(expectedError)
        
        viewModel.fetchProducts()
        
        XCTAssertEqual(viewModel.products.count, 0)
    }
    
    func testSortByPrice() {
        let products = [
            Product(id: 1, name: "Product 1", price: "15.99"),
            Product(id: 2, name: "Product 2", price: "9.99"),
            Product(id: 3, name: "Product 3", price: "12.99")
        ]
        viewModel.products = products
        
        viewModel.sortByPrice()
        
        XCTAssertEqual(viewModel.products, [
            Product(id: 1, name: "Product 1", price: "15.99"),
            Product(id: 3, name: "Product 3", price: "12.99"),
            Product(id: 2, name: "Product 2", price: "9.99")
        ])
    }
    
    func testSortByName() {
        let products = [
            Product(id: 1, name: "Product B", price: "10.99"),
            Product(id: 2, name: "Product C", price: "12.99"),
            Product(id: 3, name: "Product A", price: "9.99")
        ]
        viewModel.products = products
        
        viewModel.sortByName()
        
        XCTAssertEqual(viewModel.products, [
            Product(id: 3, name: "Product A", price: "9.99"),
            Product(id: 1, name: "Product B", price: "10.99"),
            Product(id: 2, name: "Product C", price: "12.99")
        ])
    }
    
    func testClearSort() {
        let products = [
            Product(id: 1, name: "Product A", price: "9.99"),
            Product(id: 3, name: "Product B", price: "10.99"),
            Product(id: 2, name: "Product C", price: "12.99")
        ]
        viewModel.products = products
        
        viewModel.clearSort()
        
        XCTAssertEqual(viewModel.products, [
            Product(id: 3, name: "Product B", price: "10.99"),
            Product(id: 2, name: "Product C", price: "12.99"),
            Product(id: 1, name: "Product A", price: "9.99")
        ])
    }
    
    func testShowFavorite() {
        viewModel.showFavorite()
        
        XCTAssertTrue(coordinator.showFavoriteCalled)
    }
    
    func testShowDetail() {
        let product = Product(id: 1, name: "Product 1", price: "10.99")
        
        viewModel.showDetail(product: product)
        
        XCTAssertEqual(coordinator.showDetailProduct, product)
    }
}

class ProductServiceMock: ProductServiceProtocol {
    var result: Result<[Product], Error>!
    
    func searchProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        completion(result)
    }
}

class CoordinatorMock: Coordinator {
    var showFavoriteCalled = false
    var showDetailProduct: Product?
    
    override func showFavorite() {
        showFavoriteCalled = true
    }
    
    override func showDetail(product: Product) {
        showDetailProduct = product
    }
}
