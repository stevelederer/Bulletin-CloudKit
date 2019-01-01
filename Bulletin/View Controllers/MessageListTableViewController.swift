//
//  MessageListTableViewController.swift
//  Bulletin
//
//  Created by Steve Lederer on 12/31/18.
//  Copyright © 2018 Steve Lederer. All rights reserved.
//

import UIKit

class MessageListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var messageSearchBar: UISearchBar!
    
    var messages : [Message] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MessageController.shared.fetchAllMessageFromCloudKit { (messages) in
            DispatchQueue.main.async {
                guard let messages = messages else { return }
                self.messages = messages
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.timestamp.formattedAsString
        return cell
    }
    
    // MARK: - Actions
    
    func postMessageFromSearchBar() {
        guard let text = messageSearchBar.text, !text.isEmpty else { return }
        MessageController.shared.saveMessageToCloudKit(text: text) { (message) in
            DispatchQueue.main.async {
                guard let message = message else { return }
                self.messages.append(message)
                self.tableView.reloadData()
                self.messageSearchBar.text = ""
            }
        }
    }
    
    @IBAction func postMessageButtonTapped(_ sender: UIButton) {
        postMessageFromSearchBar()
    }
    

}
