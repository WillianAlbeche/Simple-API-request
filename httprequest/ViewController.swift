//
//  ViewController.swift
//  httprequest
//
//  Created by Willian Magnum Albeche on 26/10/22.
//

import UIKit

struct Post: Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        makeRequest { (posts) in
            print("API return: \(posts)")
        }
    }
    private func makeRequest(completion: @escaping ([Post]) -> ()) {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

           // print("response: \(String(describing: response)) ")
            //print("error: \(String(describing: error))")

            guard let responseData = data else{ return }

            do {
                let posts = try JSONDecoder().decode([Post].self, from: responseData)

                completion(posts)
            } catch let error {
                print("error: \(error)")
            }
//            if let responseString = String(data: responseData, encoding: .utf8) {
//                print(responseString)
//            }

        }
        task.resume()
    }


}

