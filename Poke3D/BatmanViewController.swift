//  BatmanViewController.swift

import UIKit
import SceneKit
import ARKit

class BatmanViewController: UIViewController, ARSCNViewDelegate {


    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        sceneView.addGestureRecognizer(gestureRecognizer)
        sceneView.isUserInteractionEnabled = true
        
    }
    
    @objc func gestureFired(_ gesture:UITapGestureRecognizer) {

        performSegue(withIdentifier: "BatmanToQuestion", sender: gesture)

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "images", bundle: Bundle.main) {
            
            configuration.trackingImages = imageToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    

    // MARK: - ARSCNViewDelegate
 
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        DispatchQueue.main.async {
            if let imageAnchor = anchor as? ARImageAnchor {
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)

                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi / 2
                
                node.addChildNode(planeNode)
                
                if imageAnchor.referenceImage.name == "batman" {
                    if let triviaScene = SCNScene(named: "art.scnassets/Batman.scn") {
                        
                        if let triviaNode = triviaScene.rootNode.childNodes.first {
                            
                            triviaNode.eulerAngles.x = .pi / 2
                            
                            planeNode.addChildNode(triviaNode)
                        }
                    }
                }
 
                
                
            }
        }
        
        return node
        
    }
    
}
