//
//  DishDetailViewController.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 23/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
import SDWebImage
class DishDetailViewController: UIViewController {
    
    var mealId:String!
    var detailDishes:DetailDish?
    var meals:[DetailMeals] = []
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishTitleLbl: UILabel!
    @IBOutlet weak var dishDescriptionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     fetchRandomDish(mealid:mealId)
        
    }
    
    func fetchRandomDish(mealid:String){
        let str = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealid)"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            do {
                if error == nil {
                    self.detailDishes = try JSONDecoder().decode(DetailDish.self, from: data!)
                    self.meals = self.detailDishes!.meals!
                    
                    DispatchQueue.main.async {
                        self.dishTitleLbl.text = self.meals[0].strMeal
                        self.dishImageView.sd_setImage(with: URL(string: self.meals[0].strMealThumb!), completed: nil)
                    self.dishDescriptionLbl.text = self.meals[0].strInstructions
                        
                    }
                }
            }catch let error {
                print(error.localizedDescription)
            }
            }.resume()
        
    }
    
    @IBAction func dishOrderBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlaceOrderViewController") as! PlaceOrderViewController
        vc.placeOrder = meals[0]
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
