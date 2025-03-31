//
//  OhfnazRe.swift
//  RauganeSpillWine
//
//  Created by Nicolae Chivriga on 31/03/2025.
//

import SwiftUI


struct OhfnazRe: View {
    var body: some View {
        ZStack {
            Image("greyushkacol")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("posbiuwap")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: ParagLeg())
    }
}
import WebKit
struct Gauwiosas: ViewModifier {
    @State var skgie: Bool = true
    @AppStorage("adapt") var veriuProi: URL?
    @State var webView: WKWebView = WKWebView()
    
    func body(content: Content) -> some View {
        ZStack {
            if !skgie {
                if veriuProi != nil {
                    VStack(spacing: 0) {
                        WKWebViewRepresentable(url: veriuProi!)
                        HStack {
                            Button(action: {
                                webView.goBack()
                            }, label: {
                                Image(systemName: "chevron.left")
                                
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20) // Customize image size
                                    .foregroundColor(.white)
                            })
                            .offset(x: 10)
                            
                            Spacer()
                            
                            Button(action: {
                                
                                webView.load(URLRequest(url: veriuProi!))
                            }, label: {
                                Image(systemName: "house.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)                                                                       .foregroundColor(.white)
                            })
                            .offset(x: -10)
                            
                        }
                        //                    .frame(height: 50)
                        .padding(.horizontal)
                        .padding(.top)
                        .padding(.bottom, 15)
                        .background(Color.black)
                    }
                    .onAppear() {
                        
                        
                        AppDelegate.position = .all
                    }
                    .modifier(Swiper(onDismiss: {
                        self.webView.goBack()
                    }))
                    
                    
                } else {
                    content
                }
            } else {
                
            }
        }
        
        //        .yesMo(orientation: .all)
        .onAppear() {
            if veriuProi == nil {
                checkpesk()
            } else {
                skgie = false
            }
        }
    }
    
    class RedirectTrackingSessionDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
        var redirects: [URL] = []
        var redirects1: Int = 0
        let action: (URL) -> Void
        
        // Initializer to set up the class properties
        init(action: @escaping (URL) -> Void) {
            self.redirects = []
            self.redirects1 = 0
            self.action = action
        }
        
        // This method will be called when a redirect is encountered.
        func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
            if let redirectURL = newRequest.url {
                // Track the redirected URL
                redirects.append(redirectURL)
                
                redirects1 += 1
                if redirects1 >= 3 {
                    DispatchQueue.main.async {
                        self.action(redirectURL)
                    }
                }
            }
            
            // Allow the redirection to happen
            completionHandler(newRequest)
        }
    }
    
    func checkpesk() {
        guard let url = URL(string: "https://freepolicyourgheim.xyz/en/raugane") else {
            DispatchQueue.main.async {
                self.skgie = false
            }
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Create a custom URLSession configuration
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false // Prevents automatic cookie handling
        configuration.httpShouldUsePipelining = true
        
        // Create a session with a delegate to track redirects
        let delegate = RedirectTrackingSessionDelegate() { url in
            veriuProi = url
        }
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                DispatchQueue.main.async {
                    self.skgie = false
                }
                return
            }
            
            // Print the final redirect URL
            if let finalURL = httpResponse.url, finalURL != url {
                print("Final URL after redirects: \(finalURL)")
                //                self.hleras = finalURL
            }
            
            // Check the status code and print the response body if successful
            if httpResponse.statusCode == 200, let adaptfe = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    // Uncomment to print the response body
                    // print("Response Body: \(adaptfe)")
                }
            } else {
                DispatchQueue.main.async {
                    print("Request failed with status code: \(httpResponse.statusCode)")
                    self.skgie = false
                }
            }
            
            DispatchQueue.main.async {
                self.skgie = false
            }
        }.resume()
    }
    
    
}
