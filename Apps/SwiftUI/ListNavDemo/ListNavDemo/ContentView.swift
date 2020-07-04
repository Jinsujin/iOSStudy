//
//  ContentView.swift
//  ListNavDemo
//
//  Created by jsj on 2020/07/05.
//  Copyright © 2020 Tomatoma. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var carStore: CarStore = CarStore(cars: carData)
    
    var body: some View {
        NavigationView {
            List {
                ForEach (carStore.cars) { car in
                    ListCell(car: car)
                    
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
        .navigationBarTitle(Text("EV Cars"))
            .navigationBarItems(leading: NavigationLink(destination: AddNewCar(carStore: self.carStore)) {
                Text("Add")
                    .foregroundColor(.blue)
            }, trailing: EditButton())
        
        }
    }
    
    func deleteItems(at offets: IndexSet) {
        
        carStore.cars.remove(atOffsets: offets)
    }
    
    func moveItems(from source: IndexSet, to destination: Int) {
        carStore.cars.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ListCell: View {
    
    var car: Car
    var body: some View {
        NavigationLink(destination: CarDetail(selectedCar: car)) {
            
            HStack {
                Image(car.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 60)
                Text(car.name)
            }
        }
    }
}
