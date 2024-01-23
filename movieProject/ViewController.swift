//
//  ViewController.swift
//  movieProject
//
//  Created by ALVIN CHEN on 1/18/24.
//

struct Movie: Codable{
var Actors: String
var Country: String
var Director: String
var Metascore: String
var Ratings: [Rating]
var Year: String
}

struct Rating: Codable{
    var Source: String
    var Value: String
}

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ghostLabel: UILabel!
    var x = "Ghost"
    @IBOutlet weak var textFieldOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovie()
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        x = textFieldOutlet.text!
        getMovie()
    }
    
    
    func getMovie(){
        let session = URLSession.shared
        
       let movieURL = URL(string: "http://www.omdbapi.com/?t=\(x)&apikey=78c4cb11&")
        

        
        let dataTask = session.dataTask(with: movieURL!) { [self] (data:Data?, response:URLResponse?, error:Error?) in
            if let e = error{
                print("\(e)")
            }
            
            else{
                if let d = data{
                    print("found data")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary{
                        print(jsonObj)
                        
                        //get Movie object with JSONDecoder
                  //  if let movieObj = try?
                //       JSONDecoder().decode(Movie.self, from: data!){
                 //       print(movieObj.Actors)
                 //       DispatchQueue.main.async{
                   //         self.ghostLabel.text = "\(movieObj.Year)"
                   //     }
                   //     for r in movieObj.Ratings{
                   //         print("\(r.Source)  \(r.Value)")
                  //      }
                 //   }
                        
                    
                        

                               
                        if let y = jsonObj.value(forKey: "Year") as? String{
                                    
                            DispatchQueue.main.async{
                                self.ghostLabel.text = "Movie Year: \(y)"
                                        }
                                   }
                                
                        else{
                            DispatchQueue.main.async{
                                self.ghostLabel.text = "please insert a valid title"
                            }
                        }
                        
                        
                        
                        
                        
                    }
                }
                
                else{
                    print("can't find data")
                }
                
                
            }
        }
        dataTask.resume()
    }


}

