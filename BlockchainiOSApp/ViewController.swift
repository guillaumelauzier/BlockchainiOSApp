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
    
    @IBOutlet weak var amountSum: UITextField!
    
    @IBOutlet weak var domesticInternational: UISegmentedControl!
    
    @IBAction func onTapSendButton(_ sender: UIButton) {
        
        self.generateDummyTransactions()
        let str:String = "Mary"
        self.providerForm.text = str
        let str2:String = "Bob"
        self.destinatorForm.text = str2
        //let int:Double = 20.0
        //self.amountSum. = int
        
    }
    
    @IBOutlet weak var realTimeTextOutput: UITextView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    private let genesisBlock = Block()
    private var blockchain : Blockchain!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blockchain = Blockchain(genesisBlock: genesisBlock)
        
    }
    
    @IBAction func sendFormData(_ sender: UIButton) {
        
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
        
            let transaction2 = Transaction(from: from, to: destinator, amount: amount, transactionType: transType)
        
            let blockx = Block()
            blockx.addTransaction(transaction: transaction2)
        
            self.blockchain.addBlock(blockx)
            
        }
        
    }

    func generateDummyTransactions() {
        
        _ = self.providerForm
        _ = self.destinatorForm
        _ = self.amountSum
        
        let transaction = Transaction(from: "Mary", to: "Bob", amount: 20, transactionType: TransactionType.domestic)
        let block1 = Block()
        block1.addTransaction(transaction: transaction)
        
        let transaction2 = Transaction(from: "Phil", to: "Gab", amount: 10.0, transactionType: .domestic)
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
