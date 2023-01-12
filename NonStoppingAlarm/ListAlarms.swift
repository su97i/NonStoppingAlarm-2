//
//  ContentView.swift
//  NonStoppingAlarm
//
//  Created by Shouq Turki Bin Tuwaym on 03/01/2023.
//

import SwiftUI

struct AlarmItemComponenet: View {
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
    
    
    @EnvironmentObject private var notificationManager: NotificationManager
    
    @State private var notEditable = true
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Alarms.entity(), sortDescriptors: [])
    var alarms: FetchedResults<Alarms>
    

    var body: some View{
        NavigationView {
            List {
                ForEach(alarms, id: \.self) { alarm in
                    AlarmItemComponenet(value: alarm)
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
                if alarms.count == 0 {
                    Text("No Alarms exist yet")
                }
                
            }
            .scrollContentBackground(.hidden)
            .navigationBarTitle("Alarms", displayMode: .large)
            .navigationBarItems(
                leading:
                    Button(action: {
                        notEditable = !notEditable
                    }) {
                        Text(notEditable ? "Edit" : "Done")
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                    },
                trailing:
                    NavigationLink(
                        destination: SettingAlarm().environment(
                            \.managedObjectContext,
                             self.moc
                        )
                        // this was commentted out because the notification manager disrupt the preview
                        .environmentObject(notificationManager)
                    ){
                        Image(systemName: "plus").foregroundColor(.blue).imageScale(.large)
                    }
            )
            
            
            
        }
        
        // there is still imitation and that part didn't work correctly
//        .onChange(of: notificationManager.currentViewId) { viewId in
//            guard let id = viewId else {
//                return
//            }
//            let viewToShow = notificationManager.currentView(for: id)
////            SettingAlarm()
//        }
    }
}

struct ListAlarms_Previews: PreviewProvider {
    static var previews: some View {
        ListAlarms()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(NotificationManager())
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
