//
//  HomeViewController.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 20/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var bestCollectionView: UICollectionView!
    @IBOutlet weak var mostPopularCollectionView: UICollectionView!
    
    var categorie : DishCategory?
    var categories : [Category] = []
    
    var bestDishes:BestDish?
    var meals:[Meals] = []
    
    
    var popular:BestDish?
    var dish:[Meals] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAPI()
        fetchRandomDish()
        fetchPopularDish()
        
    }
    
    func fetchAPI(){
        let str = "https://www.themealdb.com/api/json/v1/1/categories.php"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            do {
                if error == nil {
                    self.categorie = try JSONDecoder().decode(DishCategory.self, from: data!)
                    self.categories = self.categorie!.categories!
                DispatchQueue.main.async {
                    self.categoryCollectionView.reloadData()
                    
                }
            }
            }catch let error {
                print(error.localizedDescription)
            }
    }.resume()
    
}
    func fetchRandomDish(){
        let str = "https://www.themealdb.com/api/json/v1/1/random.php"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            do {
                if error == nil {
                    self.bestDishes = try JSONDecoder().decode(BestDish.self, from: data!)
                    self.meals = self.bestDishes!.meals!
                    DispatchQueue.main.async {
                        self.bestCollectionView.reloadData()
                        
                    }
                }
            }catch let error {
                print(error.localizedDescription)
            }
            }.resume()
        
    }
    func fetchPopularDish(){
        let str = "https://www.themealdb.com/api/json/v1/1/random.php"
        let url = URL(string: str)
        
        URLSession.shared.dataTask(with: url!) { [unowned self] (data, response, error) in
            do {
                if error == nil {
                    self.popular = try JSONDecoder().decode(BestDish.self, from: data!)
                    self.dish = self.popular!.meals!
                    DispatchQueue.main.async {
                        self.mostPopularCollectionView.reloadData()
                        
                    }
                }
            }catch let error {
                print(error.localizedDescription)
            }
            }.resume()
        
    }
}
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case categoryCollectionView:
            return categories.count
        case bestCollectionView:
            return meals.count
        case mostPopularCollectionView:
            return dish.count
        default: return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case categoryCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CategoryCollectionViewCell
        
            cell.categoryLbl.text = categories[indexPath.row].strCategory
            cell.categoryImageView.sd_setImage(with: URL(string: categories[indexPath.row].strCategoryThumb!), completed: nil)
            cell.categoryImageView.layer.cornerRadius = cell.categoryImageView.frame.height/2
            cell.categoryImageView.layer.borderColor = UIColor.black.cgColor
            cell.categoryImageView.clipsToBounds = true
            return cell
            
        case bestCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! BestDishesCollectionViewCell
            let obj2 = meals[indexPath.row]
          cell.titleLbl.text = obj2.strMeal
            cell.dishImageView.sd_setImage(with: URL(string: obj2.strMealThumb!), completed: nil)  
           cell.descriptionLbl.text = obj2.strTags
            return cell
            
        case mostPopularCollectionView:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! MostPopularCollectionViewCell
            let obj3 = dish[indexPath.row]
            cell.titleLbl.text = obj3.strMeal
            cell.dishImageView.sd_setImage(with: URL(string: obj3.strMealThumb!), completed: nil)
       
            return cell
            
        default: return UICollectionViewCell()
        
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ListDishesViewController") as! ListDishesViewController
            vc.category = categories[indexPath.row].strCategory
            navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == bestCollectionView {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DishDetailViewController") as! DishDetailViewController
         vc.mealId = meals[indexPath.row].idMeal
            navigationController?.pushViewController(vc, animated: true)
        } else if collectionView == mostPopularCollectionView {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DishDetailViewController") as! DishDetailViewController
            vc.mealId = dish[indexPath.row].idMeal
            navigationController?.pushViewController(vc, animated: true)
    }
}

}

