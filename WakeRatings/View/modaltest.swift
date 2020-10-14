//
//  modaltest.swift
//  WakeRatings
//
//  Created by CJ Davis on 10/14/20.
//

import SwiftUI

import SwiftUI

struct ModalTest: View {
    var body: some View {
        return ZStack {
            SomeView()
            ModalAnchorView()               // <---- This is the anchor point for the modal
        }
    }
}

struct SomeView: View {
  
    @EnvironmentObject var modalManager: ModalManager
    
    var body: some View {
        return VStack(){
           Button(action: self.modalManager.openModal) {
              Text("Open Modal")
           }
        }
        .onAppear {
            self.modalManager.newModal(position: .closed) {
                Text("Modal Content")
            }
        }
    }
}

struct modaltest_Previews: PreviewProvider {
    static var previews: some View {
        ModalTest()
    }
}
