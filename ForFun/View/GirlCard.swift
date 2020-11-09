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
        let widthOfScreen = UIScreen.main.bounds.width
        VStack(alignment: .leading){
            WebImage(url: URL(string: girl.girl_image))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height:250)
                .clipped()
            Text(girl.girl_name)
            
            Text("Age: \(girl.girl_age)")
                .frame(width: widthOfScreen-30, alignment: .trailing)
            HStack{
                ForEach(1...5, id: \.self){ index in
                    Image(systemName: "star.fill")
                        .foregroundColor( index <= NSString(string: girl.girl_rating).integerValue ?? 0 ? Color.pink : Color.gray)
                }
            }.alignmentGuide(.leading) { _ in -80 }
            
            
            Divider()
        }.padding(.bottom,10)
        
        
    }
}


