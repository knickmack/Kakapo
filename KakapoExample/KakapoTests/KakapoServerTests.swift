//
//  KakapoServerTests.swift
//  KakapoExample
//
//  Created by Joan Romano on 02/04/16.
//  Copyright © 2016 devlucky. All rights reserved.
//

import Foundation

import Quick
import Nimble

@testable import Kakapo

class KakapoServerTests: QuickSpec {
    
    override func spec() {
        
        describe("#KakapoServer") {
            
            beforeEach({
                KakapoServer.enable()
            })
            
            afterEach({ 
                KakapoServer.disable()
            })
            
            it("should call the handler when requesting a registered url") {
                var info: URLInfo? = nil
                var responseURL: NSURL? = nil
                
                KakapoServer.get("/users/:id") { request in
                    info = request.info
                }
                
                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "/users/1")!) { (_, response, _) in
                    responseURL = response?.URL
                }.resume()
                
                expect(info?.params).toEventually(equal(["id" : "1"]))
                expect(info?.queryParams).toEventually(equal([ : ]))
                expect(responseURL?.absoluteString).toEventually(equal("/users/1"))
            }
            
//            it("should call the handler when requesting multiple registered urls") {
//                var usersInfo: URLInfo? = nil
//                var usersResponseURL: NSURL? = nil
//                var usersCommentsInfo: URLInfo? = nil
//                var usersCommentsResponseURL: NSURL? = nil
//                
//                KakapoServer.get("/comments/:id") { request in
//                    usersInfo = request.info
//                }
//                
//                KakapoServer.get("/users/:id") { request in
//                    usersInfo = request.info
//                }
//                
//                KakapoServer.get("/commentaries/:id") { request in
//                    usersInfo = request.info
//                }
//                
//                KakapoServer.get("/users/:id/comments/:comment_id") { request in
//                    usersCommentsInfo = request.info
//                }
//                
//                KakapoServer.get("/users/:id/comments/:comment_id/whatever") { request in
//                    usersCommentsInfo = request.info
//                }
//                
//                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "/users/1")!) { (_, response, _) in
//                    usersResponseURL = response?.URL
//                }.resume()
//                
//                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "/users/1/comments/2?page=2&author=hector")!) { (_, response, _) in
//                    usersCommentsResponseURL = response?.URL
//                }.resume()
//                
//                expect(usersInfo?.params).toEventually(equal(["id" : "1"]))
//                expect(usersInfo?.queryParams).toEventually(equal([ : ]))
//                expect(usersResponseURL?.absoluteString).toEventually(equal("/users/1"))
//                expect(usersCommentsInfo?.params).toEventually(equal(["id": "1", "comment_id": "2"]))
//                expect(usersCommentsInfo?.queryParams).toEventually(equal(["page": "2", "author": "hector"]))
//                expect(usersCommentsResponseURL?.absoluteString).toEventually(equal("/users/1/comments/2?page=2&author=hector"))
//            }
//
//            it("should not call the handler when requesting a non registered url") {
//                var info: URLInfo? = nil
//                var responseURL: NSURL? = NSURL(string: "")
//                var responseError: NSError? = NSError(domain: "", code: 1, userInfo: nil)
//                
//                KakapoServer.get("/users/:id") { request in
//                    // Shouldn't reach here
//                    info = request.info
//                }
//                
//                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "/userssssss/1")!) { (_, response, error) in
//                    // Response will be nil since error
//                    responseURL = response?.URL
//                    responseError = error
//                }.resume()
//                
//                expect(info?.params).toEventually(beNil())
//                expect(info?.queryParams).toEventually(beNil())
//                expect(responseURL?.absoluteString).toEventually(beNil())
//                expect(responseError).toNotEventually(beNil())
//            }
            
            it("should call the handler when requesting a registered url") {
                var info: URLInfo? = nil
                var responseURL: NSURL? = nil
                
                KakapoServer.post("/user_equipment/:id") { request in
                    info = request.info
                }
                
                let request = NSMutableURLRequest(URL: NSURL(string: "/user_equipment/1")!)
                request.HTTPMethod = "POST"
                let params = ["username":"test", "password":"pass"] as Dictionary<String, String>
                request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
//                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//                    print("Response: \(response)")
//                    let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    print("Body: \(strData)")
//                    let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//                    
//                    print(json ?? "")
//                    
//                }).resume()
                
                NSURLConnection(request: request, delegate: nil)
//                [NSURLConnection connectionWithRequest:request delegate:nil];
                
                expect(info?.params).toEventually(equal(["id" : "1"]))
                expect(info?.queryParams).toEventually(equal([ : ]))
                expect(responseURL?.absoluteString).toEventually(equal("/users/1"))
            }
            
//            it("zzzzz", closure: {
//                var info: URLInfo? = nil
//                var responseURL: NSURL? = nil
//                
//                KakapoServer.get("/user_equipment/:id") { request in
//                    info = request.info
//                }
//                
//                let request = NSMutableURLRequest(URL: NSURL(string: "/user_equipment")!)
//                request.HTTPMethod = "POST"
//                let params = ["username":"test", "password":"pass"] as Dictionary<String, String>
//                request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
//                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//                request.addValue("application/json", forHTTPHeaderField: "Accept")
//                NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//                    print("Response: \(response)")
//                    let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                    print("Body: \(strData)")
//                    let json = try? NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
//                    
//                    print(json ?? "")
//                    
//                }).resume()
//
//                NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: "/user_equipment/1")!) { (_, response, _) in
//                    responseURL = response?.URL
//                    }.resume()
//            })
        }
    }


}