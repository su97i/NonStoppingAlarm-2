//
//  AlarmScreen.swift
//  NonStoppingAlarm
//
//  Created by Sarah Sheikh on 8/01/2023.
//

import SwiftUI

struct AlarmScreen: View {
    var body: some View {
        //    let string = NSLocalizedString("Start", comment: "ابدأ")
        //    @State private var isPrsnt = false
                NavigationView{
                    VStack{
                        VStack{
                            
                         
                            
                            ZStack{
                                Loading()
                              
                                Text(Date.now, format:
                                    .dateTime.day().month())
                                    .font(Font.custom("SF Pro", size: 30))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 100)
                                    .accessibility(label:  Text("Wake Up"))
                                
                                
                                
        //                        Text("3 Jan 2030")
        //                            .font(Font.custom("SF Pro", size: 30))
        //                            .foregroundColor(.white)
        //                            .padding(.bottom, 100)
        //                            .accessibility(label:  Text("Wake Up"))
        //
                                
                                Text(Date.now, format:
                                    .dateTime.hour().minute())
                                    .font(Font.custom("SF Pro", size: 58))
                                    .bold()
                                    .foregroundColor(.white)
                                    .accessibility(label:  Text("The time is 6 : 30 AM"))
                                
                                Text("Job interview !")
                                    .font(Font.custom("SF Pro", size: 35))
                                    .foregroundColor(.white)
                                    .padding(.top, 100)
                            }
                        }
                        
                        
        //                Button(action:{
        ////                    isPrsnt = false
                        NavigationLink(destination: MathProblem().navigationBarBackButtonHidden()){
                                

                            Text("Start")
                                .font(Font.custom("SF Pro", size: 21))
                                .frame(width:246, height: 56)
                                .foregroundColor(.white)
                                .background(Color("color"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        
                        
                    }
                      
                               }
                               }
            }


struct AlarmScreen_Previews: PreviewProvider {
    static var previews: some View {
        AlarmScreen()
    }
}

        struct Loading : View {
            @State var animate = false
            var body : some View {
                ZStack{
                    Circle().fill(Color("1")).frame(width: 381, height: 381).scaleEffect(self.animate ? 1: 0)

                    Circle().fill(Color("2")).frame(width: 314, height: 314).scaleEffect(self.animate ? 5: 0)
                    Circle().fill(Color("3").opacity(0.45)).frame(width: 240, height: 240).scaleEffect(self.animate ? 10: 0)

                    Circle().fill(Color("color").opacity(1.45)).frame(width: 169, height: 169)
                }
                .padding(.bottom)
                .onAppear {
                    self.animate.toggle()
                }
                .animation(Animation.linear(duration: 1.8).repeatForever(autoreverses: true) )
            }
        }
    

