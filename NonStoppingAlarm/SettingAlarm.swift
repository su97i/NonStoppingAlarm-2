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
            Text (LocalizedStringKey(day.str))
                .font (.headline)
                .fontWeight (.semibold)
                .foregroundColor (selected ? .white : .black)
                .frame(minWidth: 50 , minHeight: 47)
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
                .accessibilityElement(children: .combine)
                .accessibilityLabel(LocalizedStringKey(day.str+"."))
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
            Text (LocalizedStringKey(val.str))
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
                .accessibilityLabel(LocalizedStringKey(val.str))
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
    
    @Environment(\.managedObjectContext) var moc
//    let moc = PersistenceController.shared.container.viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var alarmName: String = ""
    
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
    
    
    
    func addAlarm() {
        
        let alarms = Alarms(context: self.moc)
        
        alarms.name = self.alarmName
        
        alarms.sun = self.sunSelected
        alarms.mon = self.monSelected
        alarms.tue = self.tueSelected
        alarms.wed = self.wedSelected
        alarms.thu = self.thuSelected
        alarms.fri = self.friSelected
        alarms.sat = self.satSelected
        
        alarms.problem_type = self.selectedTypeOfProblem.str
        
        alarms.vibration = self.vibration
        alarms.snooze = self.snooze
        
        alarms.time = self.selectedDate
        alarms.status = true
        
        do {
            try self.moc.save()
        } catch {
            print("whoops \(error.localizedDescription)")
        }
//        ListAlarms().environment(
//            \.managedObjectContext,
//             self.moc
//        )
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                Group{
                    TextField (
                        "Alarm Name",
                        text: $alarmName
                        
                    )
//                    .accessibilityLabel("Set Alarm Name")
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
                        .accessibilityLabel("Repeat")
                    
                    HStack(spacing: 5.0){
                        
                        WeekDayComponent(day: WeekDayWrapper(val: .Sun, status: false), selected: $sunSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Mon, status: false), selected: $monSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Tue, status: false), selected: $tueSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Wed, status: false), selected: $wedSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Thu, status: false), selected: $thuSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Fri, status: false), selected: $friSelected)
                        WeekDayComponent(day: WeekDayWrapper(val: .Sat, status: false), selected: $satSelected)
                        
                    }.padding()
                    
                }
                
                Divider()
                Text("Tasks to do")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityLabel("Tasks to do")
                
                
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
                    //                    ProblemTypeComponent(
                    //                        val: TypeOfProblemWrapper(val: .WalkMission),
                    //                        selected: Binding(
                    //                            get: {
                    //                                return selectedTypeOfProblem.val == TypeOfProblem.WalkMission
                    //                            },
                    //                            set: { val in
                    //                                if (val){
                    //                                    self.selectedTypeOfProblem = TypeOfProblemWrapper(val: .WalkMission)
                    //                                }
                    //                            }
                    //                        )
                    //                    )
                }
                
                .padding()
                Divider()
                
                Toggle(isOn: $vibration) {
                    Text("Vibration")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Vibration")
                    
                }
                .padding(.all, 20)
                
                Divider()
                
                Toggle(isOn: $snooze) {
                    Text("Snooze")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityLabel("Snooze")
                }
                .padding(.all, 20)
                
            }
            
            .scrollContentBackground(.hidden)
            
        }
        .navigationBarItems(
            trailing:
                Button(action: {
                    self.addAlarm()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                    .fontWeight(.medium)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                }
            
        )
        
    }
    
}




struct SettingAlarm_Previews: PreviewProvider {
    static var previews: some View {
        SettingAlarm()
    }
}
