//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Vitalii Poltavets on 12/16/17.
//  Copyright © 2017 Vitalii Poltavets. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var news = [Array<Articles>]()
    let token = "6ff920ee0921492f8767a86b8b143fee"
    
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var categoryLbl: UILabel!
    
    @IBOutlet weak var languageField: UITextField!
    @IBOutlet weak var examplesLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        assignbackground()
        self.view.backgroundColor = UIColor.lightGray
        categoryField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        languageField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
        
        categoryLbl.text =  "Possible options:\n\tbusiness\n\tentertainment\n\t" +
            "gaming\n\tgeneral\n\thealth-and-medical\n\tmusic\n\t" +
        "politics\n\tsport\n\ttechnology\nDefault: all categories."
        
        examplesLbl.text =  "Possible options:\n\ten - english\n\tru - russian.\n\t" +
        "es - spanish\n\tfr - franch\nDefault: English."
        
        categoryField.text = ""
        languageField.text = "en"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        news = [Array<Articles>]()
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        
        if let language = languageField.text, let category = categoryField.text {
            articleRequest(withLanguage: language, andCategory: category, token: token)
        }
    }
    
    func articleRequest(withLanguage language: String, andCategory category: String, token: String) {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=\(language)&category=\(category)&apiKey=\(token)")
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
