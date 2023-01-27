//
//  ListDishesViewController.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 23/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
import SDWebImage
class ListDishesViewController: UIViewController {
    
    var dishes : Dish?
    var meals : [Meal] = []
    var category:String!
    @IBOutlet weak var listDishTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category
        fetchAPI(cat:title!)
        
}
    func fetchAPI(cat:String){
       
      let str = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(cat)"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            do {
                if error == nil {
                    self.dishes = try JSONDecoder().decode(Dish.self, from: data!)
                    self.meals = (self.dishes!.meals)!
                    DispatchQueue.main.async {
                        self.listDishTableView.reloadData()
                        
                    }
                }
            }catch let error {
                print(error.localizedDescription)
            }
            }.resume()
        
    }
   
    }
extension ListDishesViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishcell") as! DishListTableViewCell
        let obj = meals[indexPath.row]
        cell.dishlistimageView.sd_setImage(with: URL(string: obj.strMealThumb!), completed: nil)
        cell.dishlisttilteLbl.text = obj.strMeal
      
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DishDetailViewController") as! DishDetailViewController
         vc.mealId = meals[indexPath.row].idMeal
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
