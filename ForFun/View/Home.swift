//
//  Home.swift
//  ForFun
//
//  Created by MD Tanvir Alam on 5/11/20.
//

import SwiftUI

struct Home: View {
    @StateObject var homeVM = HomeViewModel()
    var body: some View {
        ZStack{
            //Top bar
            VStack{
                HStack{
                    Button(action:{
                        withAnimation(.easeIn){
                            homeVM.showMenu.toggle()
                        }
                    }, label:{
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.blue)
                    })
                    
                    Text("Girls Address:")
                        .fontWeight(.heavy)
                    Text(homeVM.userAddress == "" ? "Locating.." : homeVM.userAddress)
                        .fontWeight(.heavy)
                    Spacer()
                }.padding()
                
                // Scrollable Girls Card
                ScrollView(){
                    LazyVStack{
                        ForEach(homeVM.girls){ girl in
                            GirlCard(girl: girl)
                                .frame(width:UIScreen.main.bounds.width-30)
                        }
                    }
                }
                
                Spacer()
            }.padding()
            .onAppear{
                homeVM.locationManager.delegate = homeVM
            }
            
            //Sliding Menu
            HStack{
                Menu(homeVM: homeVM)
                    .background(Color.black.opacity(0.3))
                    .offset(x: homeVM.showMenu ? 0 : -UIScreen.main.bounds.width)
                Spacer(minLength: 0)
            }.background(Color.black.opacity(homeVM.showMenu ? 0.5:0)).ignoresSafeArea()
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                withAnimation(.easeIn){
                    homeVM.showMenu = false
                }
            })
            
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
