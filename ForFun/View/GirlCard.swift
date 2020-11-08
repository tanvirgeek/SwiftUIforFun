//
//  GirlCard.swift
//  ForFun
//
//  Created by MD Tanvir Alam on 8/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct GirlCard: View {
    var girl:Girl
    var body: some View {
        VStack{
            WebImage(url: URL(string: girl.girl_image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height:250)
            Text(girl.girl_name)
            Text("Age: \(girl.girl_age)")
            Text("Rating \(girl.girl_rating)")
        }
        
    }
}


