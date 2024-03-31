import SwiftUI
import RealityKit
import RealityKitContent
import Firebase
import FirebaseAuth

    
struct LoginPage: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String? = nil
    @State private var navigateToSignup = false
    @State private var navigateToProtocolList = false
    @State private var userId: String? // State to store the logged in user ID

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                } else if let userId = authResult?.user.uid {
                    self.userId = userId // Store the user ID here
                    self.errorMessage = nil
                    self.navigateToProtocolList = true // Set this to true on successful login
                    print("User logged in successfully")
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                
                VStack {
                    
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button(action: {
                        login()
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.blue)
                            .cornerRadius(15.0)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        navigateToSignup = true
                    }) {
                        Text("Don't have an account? Sign Up")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.white)
                            .cornerRadius(15.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .background(
                        NavigationLink(destination: SignupPage(), isActive: $navigateToSignup) {
                            EmptyView()
                        }
                            .hidden()
                    )
                }
                .padding()
                .background(
                    NavigationLink(destination: userId != nil ? ProtocolListView(userId: userId!) : nil, isActive: $navigateToProtocolList) {
                        EmptyView()
                    }
                        .hidden()
                )
            }
        }
    }
    
    struct LoginPage_Previews: PreviewProvider {
        static var previews: some View {
            LoginPage()
        }
    }
    
}
