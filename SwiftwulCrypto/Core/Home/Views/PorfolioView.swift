//
//  PorfolioView.swift
//  SwiftwulCrypto
//
//  Created by piotr koscielny on 25/02/2025.
//

import SwiftUI

struct PorfolioView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text("hi")
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XmarkButton()
                }
            }
        }
    }
}

struct PorfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PorfolioView()
    }
}


