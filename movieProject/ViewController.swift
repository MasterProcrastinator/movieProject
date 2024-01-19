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
}

struct Rating: Codable{
    var Source: String
    var Value: String
}

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ghostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getMovie()
    }
    func getMovie(){
        let session = URLSession.shared
        
        let movieURL = URL(string: "http://www.omdbapi.com/?i=tt3896198&apikey=78c4cb11")
        
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
                    if let movieObj = try?
                       JSONDecoder().decode(Movie.self, from: data!){
                        print(movieObj.Actors)
                        for r in movieObj.Ratings{
                            print("\(r.Source)  \(r.Value)")
                        }
                    }
                        
                    else{
                        print("error decoding to movie object")
                    }
                        
                        
                        if let y = jsonObj.value(forKey: "Ghost") as? NSDictionary{
                
                           if let ghost = y.value(forKey: "Year") as? Int{
                                DispatchQueue.main.async{
                                    self.ghostLabel.text = "\(y)"
                                }
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

