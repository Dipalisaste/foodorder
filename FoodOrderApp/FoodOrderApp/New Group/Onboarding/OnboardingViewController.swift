//
//  OnboardingViewController.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 19/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var oncollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var nextBtn: UIButton!
    var slides:[OnboardingSilde] = []
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            //we are on last page
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
            
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        slides = [
            OnboardingSilde(title: "Order Food", description: "Hungry! Order food in just a few clicks and we'll take care of you", image: #imageLiteral(resourceName: "order")),
            OnboardingSilde(title: "Find Items", description: "Quickly find the food items you like the most", image: #imageLiteral(resourceName: "find")),
            OnboardingSilde(title: "Quick Delivery", description: "Quick Home Delivery", image:#imageLiteral(resourceName: "delivery")),]
        pageControl.numberOfPages = slides.count
    }
    

    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        if currentPage == slides.count - 1 {
            pageControl.currentPage = currentPage
            //print("Go to the next page")
            let vc = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            present(vc, animated: true, completion: nil)
            //present(controller,animated: true,completion: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            oncollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
extension OnboardingViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnboardingCollectionViewCell
        let obj = slides[indexPath.row]
        cell.slideTitleLbl.text = obj.title
        cell.slideDescriptionLbl.text = obj.description
        cell.slideImageView.image = obj.image
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x/width)
        
        
    }
}
