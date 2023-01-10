//
//  ContentView.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 03/01/2023.
//

import SwiftUI




enum WeekDay: String, Codable, Hashable{
    case Sat = "Sat"
    case Sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
}


struct WeekDayWrapper: Codable, Hashable{
    var val: WeekDay
    var status: Bool
    var num:Int {
        switch(self.val){
            case .Sat:
                return 1
            case .Sun:
                return 2
            case .Mon:
                return 3
            case .Tue:
                return 4
            case .Wed:
                return 5
            case .Thu:
                return 6
            case .Fri:
                return 7
        }
    }
    var str:String {
        switch(self.val){
            case .Sat:
                return "Sat"
            case .Sun:
                return "Sun"
            case .Mon:
                return "Mon"
            case .Tue:
                return "Tue"
            case .Wed:
                return "Wed"
            case .Thu:
                return "Thu"
            case .Fri:
                return "Fri"
        }
    }
}

//func deleteUser(at offsets: IndexSet) {
//    for index in offsets {
//        let user = users[index]
//        moc.delete(user)
//    }
//    try? moc.save()
//}

struct Alarm: Codable, Hashable{
    var title: String
    var frequency: [WeekDayWrapper]
    var Time: Date
    var Status: Bool
}

//var alarmList = [
//    Alarm(
//        title: "Test 1",
//        frequency: [WeekDayWrapper(val: .Mon), WeekDayWrapper(val: .Tue)],
//        Time: createDateTime(time: "1999/1/1 18:34"),
//        Status: true
//    ),
//    Alarm(
//        title: "Test 2",
//        frequency: [WeekDayWrapper(val: .Thu), WeekDayWrapper(val: .Fri)],
//        Time: createDateTime(time: "1999/1/1 9:34"),
//        Status: true
//    ),
//    Alarm(
//        title: "Test 3",
//        frequency: [],
//        Time: createDateTime(time: "1999/1/1 23:34"),
//        Status: false
//    )
//]

struct AlarmItem: View {
    //    @State var isOn = false
    @State var value:Alarms
    
    var body: some View{
        Toggle(isOn: $value.status) {
            Text(value.name!)
                .font(.body)
                .foregroundColor(Color("green 1"))
                .accessibilityElement()
                .accessibilityLabel(String(value.name!))
                .accessibilityValue(String(value.name!))
            
            
            
            
            Text (getDateTime(time:value.time!))
                .font(.title)
                .accessibilityElement()
                .accessibilityLabel(LocalizedStringKey(getDateTime(time:value.time!)))
                .accessibilityValue(getDateTime(time:value.time!))
            
            
            HStack{
                ForEach([
                    WeekDayWrapper(val: .Sat, status: value.sat),
                    WeekDayWrapper(val: .Sun, status: value.sun),
                    WeekDayWrapper(val: .Mon, status: value.mon),
                    WeekDayWrapper(val: .Tue, status: value.tue),
                    WeekDayWrapper(val: .Wed, status: value.wed),
                    WeekDayWrapper(val: .Thu, status: value.thu),
                    WeekDayWrapper(val: .Fri, status: value.fri),
                ], id: \.self) { item in
                    if(item.status){
                        Text(LocalizedStringKey(item.str))
                            .font(.body)
                            .accessibilityElement(children: .combine)
                            .accessibilityLabel(LocalizedStringKey(item.str+"."))
                    }
                }
                Text(" ")
            }
            .accessibilityElement(children: .combine)
            //                    .accessibilityLabel(LocalizedStringKey("Repeat Every"))
        }
        .accessibilityElement(children: .combine)
        .padding(10)
        .listRowSeparator(.hidden)
        .listRowInsets(
            EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        )
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("light purple 1"))
        )
    }
}


struct ListAlarms: View {
    
    @State private var notEditable = true
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Alarms.entity(), sortDescriptors: [])
    var alarms: FetchedResults<Alarms>
    
    var body: some View{
        NavigationView {
            List {
                ForEach(alarms, id: \.self) { alarm in
                    AlarmItem(value: alarm)
                }.onDelete{ indexSet in
                    for index in indexSet {
                        moc.delete(alarms[index])
                        do {
                            try moc.save()
                        } catch {
                            // handle the Core Data error
                        }
                    }
                }.deleteDisabled(notEditable)
                //                .onDelete(perform: deleteUser(at:))
                if alarms.count == 0 {
                    Text("No Alarms exist yet")
                }
                //                ForEach(
                //                    alarmList, id: \.self
                //                ) { value in
                //                    AlarmItem(value: value)
                //                }
                
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Alarm", displayMode: .large)
            .navigationBarItems(
                leading:
                    Button(action: {
                        notEditable = !notEditable
                    }) {
                        Text(notEditable ? "Edit" : "Cancel")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    },
                trailing:
                    NavigationLink(
                        destination: SettingAlarm().environment(
                            \.managedObjectContext,
                             self.moc
                        )
                    ){
                        Image(systemName: "plus").foregroundColor(.blue).imageScale(.large)
                    }
            )
            
            
            
        }
    }
}

struct ListAlarms_Previews: PreviewProvider {
    static var previews: some View {
        ListAlarms()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}



//                HStack{
//                    Image(systemName: "bed.double")
//                        .foregroundColor(Color("green 1"))
//                        .imageScale(.large)
//
//                    Text ("Sleep | Wakeup")
//                        .fontWeight(.semibold)
//                        .foregroundColor(/*@START_MENU_TOKEN@*/Color("green 1")/*@END_MENU_TOKEN@*/)
//                        .padding(.trailing, 200.0)
//                }

//                    Text ("Everyday")
