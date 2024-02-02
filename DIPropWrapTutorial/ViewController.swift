//
//  ViewController.swift
//  DIPropWrapTutorial
//
//  Created by Azizbek Asadov on 02/02/24.
//

import UIKit

final class ViewController: UIViewController {
    override func viewDidLoad() {
        let dc = DataController()
        dc.preformDataRequest()
        
        InjectedValues[\.networkProvider] = MockNetworkProvider()
        dc.preformDataRequest()
        
        InjectedValues[\.networkProvider] = NetworkProvider()
        dc.preformDataRequest()
    }
}


struct DataController {
    @Injected(keyPath: \.networkProvider) var provider: NetworkProviding
    
    func preformDataRequest() {
        provider.requestData()
    }
}
