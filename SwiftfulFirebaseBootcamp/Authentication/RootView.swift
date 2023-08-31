//
//  RootView.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Christopher Walter on 8/30/23.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    var body: some View {
        ZStack {
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
        }
        .onAppear(perform: {
            let authUser = try? AuthenticationManager.shared.getAuthenticationUser()
            self.showSignInView = authUser == nil ? true : false
            
        })
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack {
                AuthenticationView()
            }
        }

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
