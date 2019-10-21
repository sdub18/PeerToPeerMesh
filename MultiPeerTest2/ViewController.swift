//
//  ViewController.swift
//  MultiPeerTest2
//
//  Created by Sam DuBois on 10/19/19.
//  Copyright © 2019 SamDuBois. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let colorService = ColorService()
    
    let date = Date()
    
    var connectionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello World"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var redButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(redTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var yellowButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(grayTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
        
        view.addSubview(redButton)
        view.addSubview(yellowButton)
        view.addSubview(connectionsLabel)
        
        NSLayoutConstraint.activate([
            connectionsLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            connectionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
            redButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            redButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            redButton.heightAnchor.constraint(equalToConstant: 50),
            redButton.widthAnchor.constraint(equalToConstant: 50),
            
            yellowButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100),
            yellowButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            yellowButton.heightAnchor.constraint(equalToConstant: 50),
            yellowButton.widthAnchor.constraint(equalToConstant: 50)
        
        ])
    }
    
    @objc func redTapped() {
        self.change(color: .red)
        colorService.send(colorName: "red", sender: colorService.getPeerID(), timestamp: String(describing: date.timeIntervalSince1970))
    }
    
    @objc func grayTapped() {
        self.change(color: .gray)
        colorService.send(colorName: "gray", sender: colorService.getPeerID(), timestamp: String(describing: date.timeIntervalSince1970))
    }
    
    func change(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
    

}

extension ViewController : ColorServiceDelegate {

    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }

    func colorChanged(manager: ColorService, colorString: String) {
        OperationQueue.main.addOperation {
            switch colorString {
            case "red":
                self.change(color: .red)
            case "gray":
                self.change(color: .gray)
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }

}
