import Foundation
import FirebaseFirestore


struct ScienceProtocol: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var description: String
    var steps: [String]?
    var reagents_objects: [String]?
    enum CodingKeys: CodingKey {
            case title, description, steps, reagents_objects
        }
    }

class ProtocolViewModel: ObservableObject {
    @Published var protocols: [ScienceProtocol] = []
    private var db = Firestore.firestore()
    private var userId: String? // Assuming you have a way to get the current user's ID
    init(userId: String) {
        self.userId = userId
        fetchData()
    }
    
    func fetchData() {
        // Ensure we have a valid `userId` before trying to fetch data
        guard let userId = self.userId else {
            print("Error: User ID is not set.")
            return
        }

        db.collection("users").document(userId).collection("protocols")
            .addSnapshotListener { (querySnapshot, error) in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.protocols = documents.map { (queryDocumentSnapshot) -> ScienceProtocol in
                    let data = queryDocumentSnapshot.data()
                    let title = data["title"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    return ScienceProtocol(id: queryDocumentSnapshot.documentID, title: title, description: description)
                }
            }
    }
    
    func addProtocol(_ newProtocol: ScienceProtocol) {
        // Ensure we have a valid `userId` before trying to add a protocol
        guard let userId = self.userId else {
            print("Error: User ID is not set.")
            return
        }

        // Add a new document to Firestore in the protocols collection for the current user
        db.collection("users").document(userId).collection("protocols").addDocument(data: [
            "title": newProtocol.title,
            "description": newProtocol.description,
            "timestamp": FieldValue.serverTimestamp() // It's often useful to have a timestamp
        ]) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document successfully added!")
            }
        }
    }

}
   
