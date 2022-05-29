//
//  OrdersFormViewController.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 08/05/22.
//

import UIKit
import SwiftUI

class OrdersFormViewController: UIViewController {
    
    @IBOutlet weak var theContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childView = UIHostingController(rootView: OrdersForm())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
        
    }
}
