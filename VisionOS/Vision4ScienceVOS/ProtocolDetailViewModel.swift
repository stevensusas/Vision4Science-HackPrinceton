import Firebase
import FirebaseFirestore
import RealityKit
import RealityKitContent

class ProtocolDetailViewModel: ObservableObject {
    @Published var protocolItem: ScienceProtocol?
    private var db = Firestore.firestore()
    private var userId: String  // Add a property for userId

    init(userId: String) {  // Initialize with a userId
        self.userId = userId
    }

    func fetchProtocolDetail(protocolId: String) {
        db.collection("users").document(userId).collection("protocols").document(protocolId)
            .getDocument { [weak self] (document, error) in
                guard let self = self else { return }
                if let document = document, document.exists {
                    do {
                        // Decode the document data into a ScienceProtocol object, excluding the id
                        var protocolItem = try document.data(as: ScienceProtocol.self)
                        // Manually set the id to the document's key
                        protocolItem.id = document.documentID
                        DispatchQueue.main.async {
                            self.protocolItem = protocolItem
                        }
                    } catch {
                        print("Error decoding protocol: \(error)")
                    }
                } else {
                    print("Document does not exist")
                }
            }
    }

    }
