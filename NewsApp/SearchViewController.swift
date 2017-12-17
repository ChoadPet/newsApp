//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Vitalii Poltavets on 12/16/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var news = [Array<Articles>]()
    let token = "6ff920ee0921492f8767a86b8b143fee"
    let categories = ["", "All", "Business", "Entertainment", "Gaming", "Sport", "Technology", "General", "Music", "Politics"]
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchButton.layer.backgroundColor = UIColor(red:0.00, green:0.54, blue:0.33, alpha:1.0).cgColor
        createPickerView()
        createToolBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        news = [Array<Articles>]()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        if var category = categoryField.text {
            category = category == "All" ? "" : category
            articleRequest(andCategory: category, token: token)
        }
    }
    
    func createPickerView() {
        let categoryPicker = UIPickerView()
        
        categoryPicker.delegate = self
        categoryField.inputView = categoryPicker
    }
    
    func createToolBar() {
        let toolBar = UIToolbar()
        
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(SearchViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        categoryField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func articleRequest(andCategory category: String, token: String) {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=en&category=\(category)&apiKey=\(token)")
        let request = URLRequest(url: url! as URL)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let allArticles = dictionary["articles"] as? [NSDictionary] {
                        for article in allArticles {
                            if let sources = article["source"] as? [String: Any] {
                                if let name = sources["name"] as? String {
                                    self.news.append([Articles(author: article.value(forKey: "author") as? String, title: article.value(forKey: "title") as? String, description: article.value(forKey: "description") as? String, name: name, image: article.value(forKey: "urlToImage") as? String)])
                                }
                            }
                        }
                        dump(self.news)
                    }
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toNews", sender: self)
                    }
                }
                catch (let error) {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "search")
        backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let secondVC: NewsTableViewController = segue.destination as! NewsTableViewController
        secondVC.news = news
    }
    
    
}

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
       categoryField.text = selectedCategory
    }
}











