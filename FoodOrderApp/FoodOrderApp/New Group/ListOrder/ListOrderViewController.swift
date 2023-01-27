//
//  ListOrderViewController.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 23/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
import CoreData

class ListOrderViewController: UIViewController {
   
    @IBOutlet weak var listTableView: UITableView!
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var orderMeal: [OrderMeal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchOrderMeal()
    }
    func fetchOrderMeal() {
        do{
            orderMeal = try context.fetch(OrderMeal.fetchRequest())
            print("oredrmeal\(orderMeal)")
            listTableView.reloadData()
        }catch let error{
            print(error.localizedDescription)
            
        }
    }
}
extension ListOrderViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  orderMeal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell") as! ListOrderTableViewCell
        let obj = orderMeal[indexPath.row]
        cell.orderImageView.image = UIImage(data: obj.orderimg as! Data)
        cell.orderLbl.text = "Dish: \(obj.ordername!)"
        cell.orderNameLbl.text = "Name: \(obj.name!)"
    cell.numberLabel.text = "Mobile No.: \(String(obj.mobnumber))"
        cell.addressLabel.text = "Address:\(obj.address!)"
        cell.quntityLabel.text = "Quntity: \(String(obj.quntity))"
        return cell
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var obj = orderMeal[indexPath.row]

        // Action Sheet

        let ac = UIAlertController(title: "Operation", message: nil, preferredStyle: .actionSheet)

        let editAction = UIAlertAction(title: "Update", style: .default) { (act) in
            self.editOrderAction(obj: obj)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (act) in
            self.deleteOrder(obj: obj)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(editAction)
        ac.addAction(deleteAction)
        ac.addAction(cancelAction)

        present(ac, animated: true, completion: nil)
    }
    
    func editOrderAction(obj:OrderMeal){
        let ac = UIAlertController(title: "Edit Info", message: nil, preferredStyle: .alert)

        ac.addTextField(configurationHandler: nil)
        ac.addTextField(configurationHandler: nil)
        ac.addTextField(configurationHandler: nil)
        ac.addTextField(configurationHandler: nil)
    
        ac.textFields![0].text = obj.name
        ac.textFields![1].text = String(obj.mobnumber)
        ac.textFields![2].text = obj.address
        ac.textFields![3].text = String(obj.quntity)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (act) in

            self.saveEditedValuesOfOrder(obj: obj, newName: (ac.textFields![0].text!), newMobno: (ac.textFields![1].text!), newAddress: (ac.textFields![2].text!), newQuntity: (ac.textFields![3].text!))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(saveAction)
        ac.addAction(cancelAction)
        present(ac, animated: true, completion: nil)
    }
    func saveEditedValuesOfOrder(obj: OrderMeal,newName: String, newMobno: String, newAddress: String, newQuntity: String){
        obj.name = newName
        obj.mobnumber = Int64(newMobno)!
        obj.address = newAddress
        obj.quntity = Int64(newQuntity)!
        do{
            try context.save()
            fetchOrderMeal()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func deleteOrder(obj:OrderMeal){
        do{
            context.delete(obj)
            try context.save()
            fetchOrderMeal()
        }catch let error{
            print(error.localizedDescription)
        }
    }
}


