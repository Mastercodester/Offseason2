//
//  CreateUserPage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//




import SwiftUI
import Firebase
import FirebaseStorage


class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    static let shared = FirebaseManager()
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        super.init()
    }
    
}
struct CreateUserPage: View {
    
    @State var isLoginMode = false
    @State var email = ""
    @State var password = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    @State private var presentSheet = false
    @State private var buttonsDisabled = false
    @State var shouldShowImagePicker = false
    
    @FocusState private var focusField: Field?

    enum Field{
        case email,password
    }
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 16) {
                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }.pickerStyle(SegmentedPickerStyle())
                        
                    if !isLoginMode {
                        Button {
                            shouldShowImagePicker.toggle()
                        } label: {
                            
                            VStack {
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                } else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(Color(.label))
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 64)
                                        .stroke(Color.black, lineWidth: 3)
                            )
                            
                        }
                    }
                    
                    Group {
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .submitLabel(.next)
                            .focused($focusField, equals: .email)
                            .onSubmit{
                              focusField = .password
                            }
                            .onChange(of: email){ _ in
                                enablebuttons()
                            }
                            .autocapitalization(.none)
                        
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .submitLabel(.done)
                        .focused($focusField, equals: .password)
                            .onSubmit{
                                focusField = nil
                            }.onChange(of: password){ _ in
                                enablebuttons()
                            }
                    }
                    .padding(12)
                    .background(Color.white)
                    
                    Button {
                        if isLoginMode {
                            login()
                        } else {
                            register()
                        }

                        
//                        handleAction()
                    } label: {
                        HStack {
                            Spacer()
                            Text(isLoginMode ? "Log In" : "Create Account")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                        
                    }
                    
                    Text(self.loginStatusMessage)
                        .foregroundColor(.red)
                }
                .padding()
                
            }
            .onAppear{
                // if logged in when the app runs, navigate to the new screen
                if Auth.auth().currentUser != nil {
                    print ("🪵 Login successful !")
                   presentSheet = true
                    
                }
            }
            .fullScreenCover(isPresented: $presentSheet){
                ContentView()
            }
            
            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            .background(Color(.init(white: 0, alpha: 0.05))
                            .ignoresSafeArea())
        } .alert(alertMessage, isPresented: $showingAlert){
            Button("OK",role:.cancel){
                 
            }
        }// alert
        
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
            ImagePicker(image: $image)
        }
    }
    
    @State var image: UIImage?
    
    
    
    func enablebuttons(){
        let emailIsGood = email.count >= 6 && email.contains("@")
        let passwordIsGood = password.count >= 6
        buttonsDisabled = !(emailIsGood && passwordIsGood)
    }

    
    
    private func handleAction() {
        if isLoginMode {
//            print("Should log into Firebase with existing credentials")
            loginUser()
        } else {
            createNewAccount()
//            print("Register a new account inside of Firebase Auth and then store image in Storage somehow....")
        }
    }
    
    private func loginUser() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to login user:", err)
                self.loginStatusMessage = "Failed to login user: \(err)"
                return
            }
            
            print("Successfully logged in as user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
        }
    }
    
    @State var loginStatusMessage = ""
    
    
    //tetsing area
    
    func register(){
        Auth.auth().createUser(withEmail:email,password:password){
            result,error in
            if let error = error {
                print("🤬 Error: SIGN-UP Error:\(error.localizedDescription)")
                alertMessage = "SIGN-UP Error:\(error.localizedDescription)"
                showingAlert = true
                // mayhbe
            }
            else{
                print ("😎 Registration success!")
                /// load list view
                         presentSheet = true

            }
        }
    }
    
    
    
    func login(){
        Auth.auth().signIn(withEmail:email,password:password){
            result,error in
            if let error = error {
                print("🤬 Error: Login Error:\(error.localizedDescription)")
                alertMessage = "Login Error:\(error.localizedDescription)"
                showingAlert = true
            }
            else{
                print ("🪵 Login successful !")
                presentSheet = true
                /// load list view
            }
        }
    }
    
    
    
    
    
    
    
    
    
    private func createNewAccount() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.loginStatusMessage = "Failed to create user: \(err)"
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
            
            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            
            self.persistImageToStorage()
        }
    }
    
    private func persistImageToStorage() {
//        let filename = UUID().uuidString
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
                return
            }
            
            ref.downloadURL { url, err in
                if let err = err {
                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
                    return
                }
                
                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
                print(url?.absoluteString)
            }
        }
    }
}


struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        CreateUserPage()
    }
}






















//import SwiftUI
//import Firebase
//
//class FirebaseManager: NSObject {
//
//    let auth: Auth
//    let storage: Storage
//
//    static let shared = FirebaseManager()
//
//    override init() {
//        FirebaseApp.configure()
//
//        self.auth = Auth.auth()
//        self.storage = Storage.storage()
//
//        super.init()
//    }
//
//}
//struct CreateUserView: View {
//    //how to control what you see by tagging things to true or false
//    @State var isLoginMode = false
//    @State var email = ""
//    @State var password = ""
//
//    @State var shouldShowImagePicker = false
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//
//                VStack(spacing: 16) {
//                    Picker(selection: $isLoginMode, label: Text("Picker here")) {
//                        Text("Login")
//                            .tag(true)
//                        Text("Create Account")
//                            .tag(false)
//                    }.pickerStyle(SegmentedPickerStyle())
//
//                    if !isLoginMode {
//                        Button {
//                            shouldShowImagePicker.toggle()
//                        } label: {
//
//                            VStack {
//                                if let image = self.image {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .scaledToFill()
//                                        .frame(width: 128, height: 128)
//                                        .cornerRadius(64)
//                                } else {
//                                    Image(systemName: "person.fill")
//                                        .font(.system(size: 64))
//                                        .padding()
//                                        .foregroundColor(Color(.label))
//                                }
//                            }
//                            .overlay(RoundedRectangle(cornerRadius: 64)
//                                        .stroke(Color.black, lineWidth: 3)
//                            )
//
//                        }
//                    }
//
//                    Group {
//                        TextField("Email", text: $email)
//                            .keyboardType(.emailAddress)
//                            .autocapitalization(.none)
//                        SecureField("Password", text: $password)
//                    }
//                    .padding(12)
//                    .background(Color.white)
//
//                    Button {
//                        handleAction()
//                    } label: {
//                        HStack {
//                            Spacer()
//                            Text(isLoginMode ? "Log In" : "Create Account")
//                                .foregroundColor(.white)
//                                .padding(.vertical, 10)
//                                .font(.system(size: 14, weight: .semibold))
//                            Spacer()
//                        }.background(Color.blue)
//
//                    }
//
//                    Text(self.loginStatusMessage)
//                        .foregroundColor(.red)
//                }
//                .padding()
//
//            }
//            .navigationTitle(isLoginMode ? "Log In" : "Create Account")
//            .background(Color(.init(white: 0, alpha: 0.05))
//                            .ignoresSafeArea())
//        }
//        .navigationViewStyle(StackNavigationViewStyle())
//        .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
//            ImagePicker(image: $image)
//        }
//    }
//
//    @State var image: UIImage?
//
//    private func handleAction() {
//        if isLoginMode {
////            print("Should log into Firebase with existing credentials")
//            loginUser()
//        } else {
//            createNewAccount()
////            print("Register a new account inside of Firebase Auth and then store image in Storage somehow....")
//        }
//    }
//
//    private func loginUser() {
//        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
//            if let err = err {
//                print("Failed to login user:", err)
//                self.loginStatusMessage = "Failed to login user: \(err)"
//                return
//            }
//
//            print("Successfully logged in as user: \(result?.user.uid ?? "")")
//
//            self.loginStatusMessage = "Successfully logged in as user: \(result?.user.uid ?? "")"
//        }
//    }
//
//    @State var loginStatusMessage = ""
//
//    private func createNewAccount() {
//        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
//            if let err = err {
//                print("Failed to create user:", err)
//                self.loginStatusMessage = "Failed to create user: \(err)"
//                return
//            }
//
//            print("Successfully created user: \(result?.user.uid ?? "")")
//
//            self.loginStatusMessage = "Successfully created user: \(result?.user.uid ?? "")"
//
//            self.persistImageToStorage()
//        }
//    }
//
//    private func persistImageToStorage() {
////        let filename = UUID().uuidString
//        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
//
//
//
//        //saving images in firebase with its own uid named collection
//        let ref = FirebaseManager.shared.storage.reference(withPath: uid)
//        guard let imageData = self.image?.jpegData(compressionQuality: 0.5) else { return }
//        ref.putData(imageData, metadata: nil) { metadata, err in
//
//            if let err = err {
//                self.loginStatusMessage = "Failed to push image to Storage: \(err)"
//                return
//            }
//
//            ref.downloadURL { url, err in
//                if let err = err {
//                    self.loginStatusMessage = "Failed to retrieve downloadURL: \(err)"
//                    return
//                }
//
//                self.loginStatusMessage = "Successfully stored image with url: \(url?.absoluteString ?? "")"
//                print(url?.absoluteString)
//            }
//        }
//    }
//}
//
//
//
