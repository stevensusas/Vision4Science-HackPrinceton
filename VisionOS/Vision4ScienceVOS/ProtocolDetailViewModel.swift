import Firebase
import FirebaseFirestore
import RealityKit
import RealityKitContent

@Observable
class ProtocolDetailViewModel: ObservableObject {
    var protocolItem: ScienceProtocol?
    private var db = Firestore.firestore()
    private var userId: String  // Add a property for userId
    var progress: Int
    
    init(userId: String) {  // Initialize with a userId
        self.userId = userId
        self.progress = 0
    }
    
    func goToNextStep() {
            if let steps = self.protocolItem?.steps, self.progress < steps.count - 1 {
                self.progress += 1
            }
    }
    
    func setUserId(uid: String) {
        userId = uid
    }
    
    func setProtocolItem(pItem: ScienceProtocol?) {
        protocolItem = pItem
    }
    
    func getUserId() -> String {
        return userId
    }
    
    func getProtocolItem() -> ScienceProtocol? {
        return protocolItem
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
