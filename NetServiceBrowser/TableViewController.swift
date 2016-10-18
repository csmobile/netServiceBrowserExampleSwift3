//
//  TableViewController.swift
//  NetServiceBrowser example updated for Swift 3
//

import UIKit

class TableViewController: UITableViewController, NetServiceBrowserDelegate, NetServiceDelegate {
    
   // public var availableServices: [NetService] = []
    
    private lazy var serviceBrowser: NetServiceBrowser = {
        let serviceBrowser = NetServiceBrowser()
        serviceBrowser.delegate = self
        serviceBrowser.includesPeerToPeer = true
        
        return serviceBrowser
    }()
    
    public var availableServices: [NetService] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceBrowser.searchForServices(ofType: "_http._tcp.", inDomain: "local.")
    }
    
    
    // MARK: - Table view data source
    func numberOfSectionsIntableView(_tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableServices.count
    }
    
    override func tableView(_ _tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = availableServices[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ _tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let infoViewController = ServiceInfoViewController()
        infoViewController.service = availableServices[indexPath.row]
        
        navigationController?.pushViewController(infoViewController, animated: true)
    }


    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserWillSearch")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserDidStopSearch")
    }

    func netServiceBrowser(_ browser: NetServiceBrowser,
                           didFind service: NetService,
                           moreComing: Bool) {
    print("netServiceBrowser didFindService \(service)" + " moreServicesComing \(moreComing)")
    availableServices.append(service)
    }
}
