//
//  ViewController.swift
//  BlockchainiOSApp
//
//  Created by ifage-user on 08.01.20.
//  Copyright © 2020 Guillaume Lauzier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var from: Transaction?

    @IBOutlet weak var providerForm: UITextField!
    
    @IBOutlet weak var destinatorForm: UITextField!
    
    @IBOutlet weak var minMaxAmount: UIStepper!
    
    @IBOutlet weak var amountSum: UITextField!
    
    @IBOutlet weak var domesticInternational: UISegmentedControl!
    
    @IBOutlet weak var sendForm: UIButton!
    
    @IBOutlet weak var realTimeTextOutput: UITextView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    private let genesisBlock = Block()
    private var blockchain : Blockchain!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.blockchain = Blockchain(genesisBlock: genesisBlock)
        // Do any additional setup after loading the view.
        self.generateDummyTransactions()
    }
    
    @IBAction func sendFormData(_ sender: UIButton) {
        
        /*
        realTimeTextOutput.text = "This is the value to be sent"
        let Transaction =  (providerForm: from!.text!, destinatorForm: to!.text!, domesticInternational: fees.text!)
        self.from!.providers.append(provider)
        self.from!.tableView.reloadData()
        dismiss(animated: true, completion: nil)
        */
        
        let amount = Double(amountSum!.text!) ?? 0.0
        
        var transType = TransactionType.international
        switch domesticInternational.selectedSegmentIndex
        {
            case 0:
                transType = TransactionType.domestic
            case 1:
                transType = TransactionType.international
            default:
                break
        }
        
        if let from = providerForm!.text, let destinator = destinatorForm!.text{
        
            let transaction = Transaction(from: from, to: destinator, amount: amount, transactionType: transType)
        
            let blockx = Block()
            blockx.addTransaction(transaction: transaction)
        
            self.blockchain.addBlock(blockx)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func generateDummyTransactions() {
        
        
        
        let transaction = Transaction(from: "Mary", to: "Steve", amount: 20.0, transactionType: TransactionType.domestic)
        let block1 = Block()
        block1.addTransaction(transaction: transaction)
        
        
        let transaction2 = Transaction(from: "Mary", to: "John", amount: 10.0, transactionType: .domestic)
        block1.addTransaction(transaction: transaction2)
        print("------------------------------------------------------")
        let block = blockchain.getNextBlock(transactions: [transaction])
        blockchain.addBlock(block)
        
        // print(blockchain.blocks.count)
        let data = try! JSONEncoder().encode(blockchain)
        let blockchainJSON = String(data : data, encoding: .utf8)
        
        print(blockchainJSON!)
        
        realTimeTextOutput.text = blockchainJSON
        
        
        
    }
}
