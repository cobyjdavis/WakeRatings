//
//  MultilineTextField.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/6/20.
//

import SwiftUI

struct multilineTextField : UIViewRepresentable {
    
    @Binding var txt : String
    
    func makeCoordinator() -> multilineTextField.Coordinator {
        return multilineTextField.Coordinator(parent1 : self)
    }
    func makeUIView(context: UIViewRepresentableContext<multilineTextField>) -> UITextView {
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = ""
        text.textColor = .gray
        text.font = .systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    
    func updateUIView(_ uiView: multilineTextField.UIViewType, context: UIViewRepresentableContext<multilineTextField>) {
        
    }
    
    class Coordinator : NSObject, UITextViewDelegate {
        
        var parent : multilineTextField
        
        init(parent1 : multilineTextField) {
            parent = parent1
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .black
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
    }
}

class TextLimiter: ObservableObject {
    private let limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    @Published var hasReachedLimit = false
    @Published var value = "" {
        didSet {
            if value.count > self.limit {
                value = String(value.prefix(self.limit))
                self.hasReachedLimit = true
            } else {
                self.hasReachedLimit = false
            }
        }
    }
}
