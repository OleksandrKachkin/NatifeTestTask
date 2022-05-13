//
//  MainViewController.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 13.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
  
  let postArray = ["Post 1", "Post 2", "Post 3", "Post 4"]
  let postText = ["He was also a bit of a jokester and liked to have fun at the expense of others.", "When we think of famous bands, we have an image of each member’s distinctive roles. More often than not, every member has clearly defined roles that they stick to from beginning to end.", "Elon Musk and I went out for dinner to celebrate an increase in Tesla’s stock price. We were both overjoyed because we had an extra million dollars in our bank accounts. Yay.", "Living close to my primary school meant I could leave a few minutes before lessons and still be on time. Therefore, I was used to getting up quite late; I didn’t have to worry too much. That privilege ended when I was 13. Instead, the troubles began."]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postArray.count
  }
  
  
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
   
     cell.titleLabel?.text = postArray[indexPath.row]
     cell.subtitleLabel.text = postText[indexPath.row]
   
   return cell
   }
   
  
}
