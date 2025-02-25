//
//  XmarkButton.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 25/02/2025.
//

import SwiftUI

struct XmarkButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        Button {
            
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}
