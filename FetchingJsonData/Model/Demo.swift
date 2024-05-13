//
//  Demo.swift
//  FetchingJsonData
//
//  Created by Karpahalakshmi on 17/04/24.
//

import Foundation

struct Demo: Codable {
    public var posts: [Post]
    public var comments: [Comment]
    public var profile: Profile
}

struct Post: Codable {
    public var id: Int
    public var title: String
}

struct Comment: Codable {
    public var id: Int
    public var body: String
    public var postId: Int
}

struct Profile: Codable {
    public var name: String
}

func fetchData(completion: @escaping (Demo?, Error?) -> Void) {
    let url = URL(string: "https://my-json-server.typicode.com/typicode/demo/db")!
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let data = data else { return }
        do {
            if let usersResponse = try JSONDecoder().decode(Demo?.self, from: data) {
                completion(usersResponse, nil)
//                print(usersResponse.posts[0].id)
            }
        } catch {
            print(error)
            completion(nil, error)
        }
    }
    task.resume()
}
