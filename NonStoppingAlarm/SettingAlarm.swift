//
//  SettingAlarm.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 08/01/2023.
//

import SwiftUI
import CoreData


struct WeekDayComponent: View{
    var day: WeekDayWrapper
    @Binding var selected: Bool
    var body: some View{
        
        Button(action: {
            selected = !selected
        }, label: {
            Text (day.str)
                .font (.headline)
                .fontWeight (.semibold)
                .foregroundColor (selected ? .white : .black)
                .frame(minWidth: 42 , minHeight: 42)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("light green 1"),lineWidth: 1)
                )
                .background(content: {
                    if (selected) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("light green 1"))
                    }
                })
        })
        
    }
    
}


struct ProblemTypeComponent: View{
    var val: TypeOfProblemWrapper
    @Binding var selected: Bool
    var body: some View{
        
        Button(action: {
            selected = !selected
        }, label: {
            Text (val.str)
                .font (.headline)
                .fontWeight (.semibold)
                .foregroundColor (selected ? .white : .black)
                .frame(width: 172 , height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("light green 1"),lineWidth: 1)
                )
                .background(content: {
                    if (selected) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color("light green 1"))
                    }
                })
        })
        
    }
    
}

enum TypeOfProblem: Codable, Hashable{
    case MathProblem
    case WalkMission
}


struct TypeOfProblemWrapper: Codable, Hashable{
    var val: TypeOfProblem
    var num:Int {
        switch(self.val){
            case .MathProblem:
                return 1
            case .WalkMission:
                return 2
        }
    }
    var str:String {
        switch(self.val){
            case .MathProblem:
                return "Math Problem"
            case .WalkMission:
                return "Walk Mission"
        }
    }
}

struct SettingAlarm: View {
//    private var managedObjectContext = ContentView()
//        .environment(\.managedObjectContext, yourCoreDataContext)
    
    @State private var selectedDate = Date()
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @State private var setAlarmName: String = ""
    
    @State private var sunSelected:Bool = false
    @State private var monSelected:Bool = false
    @State private var tueSelected:Bool = false
    @State private var wedSelected:Bool = false
    @State private var thuSelected:Bool = false
    @State private var friSelected:Bool = false
    @State private var satSelected:Bool = false
    
    @State private var selectedTypeOfProblem:TypeOfProblemWrapper = TypeOfProblemWrapper(val:.MathProblem)
    
    @State private var vibration:Bool = false
    @State private var snooze:Bool = false
    
    var body: some View {
        
        
        NavigationView {
            ScrollView {
                Group{
                    TextField (
                        "Set Alarm Name",
                        text: $setAlarmName
                        
                    )
                    .multilineTextAlignment(.center)
                    .font(.title3)
                    
                    
                    DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                        .font(.largeTitle)
                    
                    Divider()
                    
                    Text("Repeat")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 12.0){
                        
                        WeekDayComponent(day: WeekDayWrapper(val: .Sun), selected: $sunSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Mon), selected: $monSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Tue), selected: $tueSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Wed), selected: $wedSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Thu), selected: $thuSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Fri), selected: $friSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Sat), selected: $satSelected)
                        
                    }.padding()
                    
            }
                    
                    Divider()
                    Text("Tasks to do")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                
                HStack(spacing: 18.0){
                    ProblemTypeComponent(
                        val: TypeOfProblemWrapper(val: .MathProblem),
                        selected: Binding(
                            get: {
                                return selectedTypeOfProblem.val == TypeOfProblem.MathProblem
                            },
                            set: { val in
                                if (val){
                                    self.selectedTypeOfProblem = TypeOfProblemWrapper(val: .MathProblem)
                                }
                            }
                        )
                    )
                    ProblemTypeComponent(
                        val: TypeOfProblemWrapper(val: .WalkMission),
                        selected: Binding(
                            get: {
                                return selectedTypeOfProblem.val == TypeOfProblem.WalkMission
                            },
                            set: { val in
                                if (val){
                                    self.selectedTypeOfProblem = TypeOfProblemWrapper(val: .WalkMission)
                                }
                            }
                        )
                    )
                }
//                NavigationLink(
//                    destination: ListAlarms()
//                ) {
//                    Text("test")
//                }
                
                .padding()
                 Divider()

                Toggle(isOn: $vibration) {
                    Text("Vibration")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)

                }
                .padding(.all, 20)
                
                 Divider()
                
                Toggle(isOn: $snooze) {
                    Text("Snooze")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.all, 20)
                
//                Divider()
                
//                Spacer()
            }
            
                .scrollContentBackground(.hidden)
                .navigationBarItems(leading:
                                        Button(action: {
                    
                }) {
//                    Image(systemName: "chevron.left").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).imageScale(.large)
                    
                    Text("Cancel")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                },
                                    trailing:
                                        Button(action: {
                    
                }) {
                    Button("Save")
                    {
//                        guard let entity = NSEntityDescription.entity(forEntityName: "Alarms", in: managedObjectContext)
                    }
                        .fontWeight(.medium)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                }
           
                )
        }
        
    }
    
}

    


struct SettingAlarm_Previews: PreviewProvider {
    static var previews: some View {
        SettingAlarm()
    }
}
