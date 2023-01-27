//
//  PlaceOrderViewController.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 28/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData

class PlaceOrderViewController: UIViewController,UITextFieldDelegate {
    
    var placeOrder:DetailMeals!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var placeScrollView: UIScrollView!
    @IBOutlet weak var orderDishImageView: UIImageView!
    @IBOutlet weak var orderDishLbl: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var quntityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       orderDishImageView.sd_setImage(with: URL(string:placeOrder.strMealThumb!), completed: nil)
        orderDishLbl.text = placeOrder.strMeal
        
        nameTextField.delegate = self
        numberTextField.delegate = self
        addressTextField.delegate = self
        quntityTextField.delegate = self
           self.hideKeyboardTappedAround()
        
        //keyboard is up
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //keyboard goes down
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardShow(){
        placeScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
      //  placeScrollView.contentOffset = CGPoint(x:0,y:200)
    }
    @objc func keyboardHide(){
       placeScrollView.contentInset = UIEdgeInsets.zero
       // placeScrollView.contentOffset = CGPoint.zero
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func placeOrderBtn(_ sender: UIButton) {
       let order = OrderMeal(context: context)
        order.orderimg = orderDishImageView.image?.jpegData(compressionQuality: 0.1)
        order.ordername = orderDishLbl.text!
        order.name = nameTextField.text!
        order.mobnumber = Int64(numberTextField.text!)!
        order.address = addressTextField.text!
        order.quntity = Int64(quntityTextField.text!)!
        
        do{
            try context.save()
            // create the alert
            let alert = UIAlertController(title: "Message", message: "Order Save Successfully..", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
           
            // show the alert
            self.present(alert, animated: true, completion: nil)
        
        } catch let error {
            print(error.localizedDescription)
        }
        orderDishImageView.image = nil
        orderDishLbl.text?.removeAll()
        nameTextField.text?.removeAll()
        numberTextField.text?.removeAll()
        addressTextField.text?.removeAll()
        quntityTextField.text?.removeAll()
        
       
        
               let vc = storyboard?.instantiateViewController(withIdentifier: "ListOrderViewController") as! ListOrderViewController
               navigationController?.pushViewController(vc, animated: true)
        
    }
    
//    @IBAction func gotoCartBtn(_ sender: UIButton) {
//        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "ListOrderViewController") as! ListOrderViewController
//        navigationController?.pushViewController(vc, animated: true)
//        
//    }
//    
}
extension UIViewController{
    
    func hideKeyboardTappedAround(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
