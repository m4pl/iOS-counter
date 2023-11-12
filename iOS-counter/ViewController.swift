//
//  ViewController.swift
//  iOS-counter
//
//  Created by Matvei Plokhov on 12.11.2023.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var historyLabel: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var decreaseButton: UIButton!
    
    @IBOutlet weak var increaseButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private var historyOfChanges = ""
    private var count = 0 {
        didSet {
            countLabel.text = String(count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateHistory(type: .initial)
    }
    
    @IBAction func decreaseDidClick(_ sender: Any) {
        if (count > 0) {
            count -= 1
            updateHistory(type: .newValue)
        } else {
            updateHistory(type: .error)
        }
    }
    
    @IBAction func increaseDidClick(_ sender: Any) {
        count += 1
        updateHistory(type: .newValue)
    }
    
    @IBAction func resetDidClick(_ sender: Any) {
        count = 0
        updateHistory(type: .reset)
    }
    
    private func updateHistory(type: History){
        let formattedDate = dateFormatter.string(from: Date())
        var result: String {
            switch type {
            case .initial: "История изменений:\n"
            case .newValue: "\(formattedDate): значение изменено на \(count)\n"
            case .reset: "\(formattedDate): значение сброшено\n"
            case .error: "\(formattedDate): попытка уменьшить значение счётчика ниже 0\n"
            }
        }
        historyOfChanges.append(result)
        historyLabel.text = historyOfChanges
    }
}

enum History {
    case initial
    case newValue
    case reset
    case error
}
