//
//  ContentView.swift
//  SIgnUp_SwiftUI
//
//  Created by Sandesh on 07/04/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    @State var firstName = ""
    @State var lastName = ""
    @State var password = ""
    @State var agreement = false
    @State var techExperience = 0
    @State var selectedContry = ""
    
    @State var checkAgreementOnBtnClick = false
    
    @State private var birthDate = Date()
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        
       
        NavigationView {
            
            Form {
                WelcomeText()
                logo()
                
                Section(header: Text("User Details")) {
                    TextField("Firstname", text: $firstName)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                    
                    TextField("Lastname", text: $lastName)
                        .padding()
                        .background(lightGreyColor)
                        .cornerRadius(5.0)
                    
                    
                    Picker(selection: $selectedContry, label: Text("Select Country")) {
                        
                        ForEach(Country.country, id: \.self) { location in
                            Text(location).tag(location)
                        }
                    }
                    
                    
                    Stepper(value: $techExperience, in: 0...40) {
                        Text("Technical Experience - \(techExperience) years")
                    }
                    
                    DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                        Text("Select Birthdate")
                    }
                    
                    
                    VStack {
                        Toggle(isOn: $agreement) {
                            Text("Agree term and condition")
                        }
                        
                        if agreement {
                            Text("Thanks for accepting")
                        }
                    }
                }
                
                Section(header: Text("Password")) {
                    SecureField("Password", text: $password)
                    .padding()
                    .background(lightGreyColor)
                    .cornerRadius(5.0)
                }
                
                if self.isUserInformationValid() {
                Button(action: {
                    print("button tapped")
                    if !self.agreement {
                        self.checkAgreementOnBtnClick = true
                    }
                }) {
                    SignUpButtonText()
                }
                .alert(isPresented: $checkAgreementOnBtnClick) {
                    
                    Alert(title:Text("privacy"), message: Text("Please accept privacy"), dismissButton: .default(Text("Ok")))
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                 }
            }.navigationBarTitle(Text("SignUp"))
                .onAppear { UITableView.appearance().separatorStyle = .none } // to hide divider in form
           
        }
    }
    
    private func isUserInformationValid()-> Bool {
        if firstName.isEmpty {
            return false
        }
        
        if lastName.isEmpty {
            return false
        }
        
        return true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Country {
    static let country = [
        "India",
        "Belgium",
        "USA",
        "London",
        "Japan",
        "France"
    ]
}

struct WelcomeText: View {
    var body: some View {
        Text("Welcome!")
            .font(.title)
            .fontWeight(.semibold)
            .padding(.bottom, 10)
            .frame(minWidth: 0, maxWidth: .infinity)
    }
}

struct logo: View {
    var body: some View {
        HStack {
            Image("Apple")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50, alignment: .center)
                .clipped()
                .padding(.bottom, 20)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        
    }
}

struct SignUpButtonText: View {
    var body: some View {
        Text("SignUp")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}

