//
//  ViewController.swift
//  Planet
//
//  Created by Z Tai on 9/2/18.
//  Copyright © 2018 Z Tai. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
       
        let sphereEarth = SCNSphere(radius: 0.1)
        let earthTexture = SCNMaterial()
        
        let sphereMoon = SCNSphere(radius: 0.02)
        let textureMoon = SCNMaterial()

        earthTexture.diffuse.contents = UIImage(named: "art.scnassets/earthDay.jpg")
        sphereEarth.materials = [earthTexture]
        
        textureMoon.diffuse.contents = UIImage(named: "art.scnassets/moon.jpg")
        sphereMoon.materials = [textureMoon]
        
        let nodeEarth = SCNNode()
        let positionEarth = SCNVector3(0, 0, -0.4)
        
        let helperNode = SCNNode()
        nodeEarth.addChildNode(helperNode)
        
        let nodeMoon = SCNNode()
        let positionMoon = SCNVector3(positionEarth.x, positionEarth.y, positionEarth.z)
        
        nodeEarth.position = positionEarth
        nodeEarth.geometry = sphereEarth
        
        nodeMoon.position = positionMoon
        nodeMoon.geometry = sphereMoon
        
        helperNode.addChildNode(nodeMoon)
        
        sceneView.scene.rootNode.addChildNode(nodeEarth)
        sceneView.scene.rootNode.addChildNode(nodeMoon)

        sceneView.autoenablesDefaultLighting = true
        
        //Slow Rotation around Y Axixs
        let rotateAnimation = SCNAction.rotate(by: CGFloat(Float.pi / 8), around: SCNVector3(0, 1, 0), duration: 1)
//        let rotateAnimation = SCNAction.rotateBy(x: 0, y: 0.2, z: 0, duration: 1)
        let rotateSequence = SCNAction.sequence([rotateAnimation])
        let moveLoop = SCNAction.repeatForever(rotateSequence)
        nodeEarth.runAction(moveLoop)
        
        nodeMoon.pivot = SCNMatrix4MakeTranslation(0.2, 0, 0)
        let circleAnimation = SCNAction.rotateBy(x: 0, y: 0.5, z: 0, duration: 1)
        let rotate = SCNAction.rotate(by: CGFloat(Float.pi / 8), around: SCNVector3(0, 1, 0), duration: 1)
        let circleSequence = SCNAction.sequence([circleAnimation])
        let circleLoop = SCNAction.repeatForever(circleSequence)
    
        nodeMoon.runAction(circleLoop)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
