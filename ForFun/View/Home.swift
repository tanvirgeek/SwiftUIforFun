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
            
            VStack(){
                //Top bar
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
                
                Divider()
                HStack{
                    TextField("Write girl's name", text: $homeVM.searchGirl)
                    if(homeVM.searchGirl != ""){
                        Button(action:{}, label:{
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        })
                    }
                }.padding(.horizontal)
                .padding(.top,10)
                Divider()
                
                // Scrollable Girls Card
                ScrollView(){
                    LazyVStack{
                        ForEach(homeVM.filteredGirls){ girl in
                            ZStack(alignment:Alignment(horizontal: .center, vertical: .top)){
                                
                                GirlCard(girl: girl)
                                    .frame(width:UIScreen.main.bounds.width-30)
                                
                                HStack{
                                    Text("Free Delivery")
                                        .padding(10)
                                        .font(.title2)
                                        .background(Color.pink)
                                    Spacer()
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .padding(10)
                                        .background(Color.pink)
                                        .clipShape(Circle())
                                }
                            }
                            
                        }
                    }
                }
                
                Spacer()
            }.padding()
            .onAppear{
                homeVM.locationManager.delegate = homeVM
            }.onChange(of: homeVM.searchGirl) { value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if value == homeVM.searchGirl{
                        homeVM.filterData()
                    }
                    if value == ""{
                        withAnimation(.easeIn){
                            homeVM.filteredGirls = homeVM.girls
                        }
                        
                    }
                }
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
