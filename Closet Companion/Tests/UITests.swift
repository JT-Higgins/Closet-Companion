//
//  UITests.swift
//  Closet Companion
//
//  Created by JT Higgins on 2/18/25.
//
import Foundation

let url = URL(string: "http://127.0.0.1:5000/")!

let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        print("Error: \(error.localizedDescription)")
        return
    }

    if let data = data {
        if let responseJSON = try? JSONDecoder().decode([String: String].self, from: data) {
            print("\(responseJSON["message"] ?? "No message")")
        } else {
            print("Failed to parse response as JSON.")
        }
    }
}

task.resume()
RunLoop.main.run()