//
//  OrdersForm.swift
//  CheckBake
//
//  Created by Kevin Harijanto on 08/05/22.
//

import SwiftUI
import CoreData

struct OrdersForm: View {
    
    @State private var orderTitle = ""
    @State private var orderDesc = ""
    @State private var orderDate = Date()
    @State private var flagged = false
    @State private var numberOfCookies = 1
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Information")) {
                    TextField("Title", text: $orderTitle)
                    TextField("Description", text: $orderDesc)
                    DatePicker("Birthdate", selection: $orderDate, displayedComponents: .date)
                }
                
                Section(header: Text("Actions")) {
                    Toggle("Flag", isOn: $flagged) .toggleStyle(SwitchToggleStyle(tint: .red))
                    Stepper("Number of Cookies", value: $numberOfCookies, in: 1...100)
                    Text("Ordered \(numberOfCookies) cookies")
                }
            }
            .navigationTitle("Order Details")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button{
                        hideKeyboard()
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                    
                    Button("Save", action: saveUser)
                }
            }
        }
        .accentColor(.red)
    }
    func saveUser(){
        
    }
//    func saveUser() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//
//        if(rowSelected == nil){
//            let entity = NSEntityDescription.entity(forEntityName: "Order", in: context)
//            let newOrders = Order(entity: entity!, insertInto: context)
//
//            newOrders.title = $orderTitle
//            newOrders.desc = $orderDesc
//            newOrders.date = $orderDate
//
//            do {
//
//                try context.save()
//                sortedList.append(newOrders)
//                performSegue(withIdentifier: "goToOrdersList", sender: nil)
//            } catch {
//                print("context save error")
//            }
//        }
//    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersForm()
    }
}

extension View {
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


