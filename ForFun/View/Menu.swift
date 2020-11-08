//
//  Menu.swift
//  ForFun
//
//  Created by MD Tanvir Alam on 5/11/20.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var homeVM:HomeViewModel
    var body: some View {
            VStack{
                HStack{
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(.pink)
                    Text("Select a hot girl")
                    Spacer()
                    
                    
                }.padding(.top,40)
                .frame(width: UIScreen.main.bounds.width/1.6)
                
                Spacer()
            }.background(Color.white)
            
        
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu(homeVM: HomeViewModel())
    }
}
