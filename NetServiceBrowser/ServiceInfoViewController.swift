//
//  ServiceInfoViewController.swift
//  NetServiceBrowser example updated for Swift 3
//

import UIKit

class ServiceInfoViewController: UIViewController {
    var service: NetService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        service.delegate = self
        service.resolve(withTimeout: 10.0)
    }
}

extension ServiceInfoViewController: NetServiceDelegate {
    func netServiceDidResolveAddress(_ sender: NetService) {
        print(sender.hostName)
        
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print(errorDict)
    }
}
