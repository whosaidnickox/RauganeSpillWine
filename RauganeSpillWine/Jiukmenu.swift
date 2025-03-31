//
//  Jiukmenu.swift
//  RauganeSpillWine
//
//  Created by Nicolae Chivriga on 31/03/2025.
//

import SwiftUI


struct Jiukmenu: View {
    @State var kiulaw: Bool = false
    var body: some View {
        ZStack {
            Image("greyushkacol")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Image("lograugane")
                    .animation(Animation.bouncy.delay(0.2),
                               value: self.kiulaw)
                    .offset(y: kiulaw ? 0 : -UIScreen.main.bounds.height)
                
                Spacer()
                
                NavigationLink {
                    EvhuisemcsView()
                } label: {
                    
                    Image("butntri")
                }

                    .animation(Animation.bouncy.delay(0.3),
                               value: self.kiulaw)
                    .offset(x: kiulaw ? 0 : UIScreen.main.bounds.width)
                
                NavigationLink {
                    OhfnazRe()
                } label: {
                    Image("siuowpsa")
                        
                }
                .animation(Animation.bouncy.delay(0.4),
                           value: self.kiulaw)
                .offset(x: kiulaw ? 0 : UIScreen.main.bounds.width)
              
                
                NavigationLink {
                    SettingsContainerView()
                } label: {
                    Image("liuksowas")
                }
                .animation(Animation.bouncy.delay(0.5),
                           value: self.kiulaw)
                .offset(x: kiulaw ? 0 : UIScreen.main.bounds.width)
             
                   
                
                
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .onAppear() {
            self.kiulaw = true
        }
    }
}
@preconcurrency import WebKit
import SwiftUI

struct WKWebViewRepresentable: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var url: URL
    var webView: WKWebView
    var onLoadCompletion: (() -> Void)?
    
    
    init(url: URL, webView: WKWebView = WKWebView(), onLoadCompletion: (() -> Void)? = nil) {
        self.url = url
        self.webView = webView
        self.onLoadCompletion = onLoadCompletion
        self.webView.layer.opacity = 0 // Hide webView until content loads
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        
        return webView
    }
    
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
        uiView.scrollView.isScrollEnabled = true
        uiView.scrollView.bounces = true
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - Coordinator
extension WKWebViewRepresentable {
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: WKWebViewRepresentable
        private var popupWebViews: [WKWebView] = []
        
        init(_ parent: WKWebViewRepresentable) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            // Handle popup windows
            guard navigationAction.targetFrame == nil else {
                return nil
            }
            
            let popupWebView = WKWebView(frame: .zero, configuration: configuration)
            popupWebView.uiDelegate = self
            popupWebView.navigationDelegate = self
            
            parent.webView.addSubview(popupWebView)
            
            popupWebView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                popupWebView.topAnchor.constraint(equalTo: parent.webView.topAnchor),
                popupWebView.bottomAnchor.constraint(equalTo: parent.webView.bottomAnchor),
                popupWebView.leadingAnchor.constraint(equalTo: parent.webView.leadingAnchor),
                popupWebView.trailingAnchor.constraint(equalTo: parent.webView.trailingAnchor)
            ])
            
            popupWebViews.append(popupWebView)
            return popupWebView
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // Notify when the main page finishes loading
            parent.onLoadCompletion?()
            parent.webView.layer.opacity = 1 // Reveal the webView
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            
            decisionHandler(.allow)
        }
        
        func webViewDidClose(_ webView: WKWebView) {
            // Cleanup closed popup WebViews
            popupWebViews.removeAll { $0 == webView }
            webView.removeFromSuperview()
        }
    }
}
struct Swiper: ViewModifier {
    var onDismiss: () -> Void
    @State private var offset: CGSize = .zero

    func body(content: Content) -> some View {
        content
//            .offset(x: offset.width)
            .animation(.interactiveSpring(), value: offset)
            .simultaneousGesture(
                DragGesture()
                    .onChanged { value in
                                      self.offset = value.translation
                                  }
                                  .onEnded { value in
                                      if value.translation.width > 70 {
                                          onDismiss()
                                  
                                      }
                                      self.offset = .zero
                                  }
            )
    }
}
