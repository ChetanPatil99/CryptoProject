//
//  View.swift
//  CryptoProject
//
//  Created by Chetan Patil on 11/03/22.
//

import Foundation
import UIKit
protocol AnyView{
    
    var presenter:AnyPresenter?{get set}
    
    func update(with cryptos:[Crypto])
    func update(with error:String)
}


class CryptoViewController:UIViewController,AnyView,UITableViewDataSource,UITableViewDelegate{
    
    var presenter: AnyPresenter?
    var cryptos:[Crypto]=[]
    
    private let tableView:UITableView={
            let table = UITableView()
            table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            table.isHidden=true
            return table
        }()
    
    private let messageLabel:UILabel={
           let label=UILabel()
           label.isHidden=false
           label.text="Downloading...."
           label.font=UIFont.systemFont(ofSize: 20)
           label.textColor = .black
           label.textAlignment = .center
           return label
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.delegate=self
        tableView.dataSource=self
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame=view.bounds
        messageLabel.frame=CGRect(x: view.frame.width/2 - 100, y: view.frame.height/2 - 50, width: 200, height: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text=cryptos[indexPath.row].currency
        content.secondaryText=cryptos[indexPath.row].price
        cell.contentConfiguration=content
        cell.backgroundColor = .yellow
        return cell
    }
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos=cryptos
            self.messageLabel.isHidden=true
            self.tableView.isHidden=false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos=[]
            self.tableView.isHidden=true
            self.messageLabel.isHidden=false
            self.messageLabel.text=error
        }
    }
    
    
}
