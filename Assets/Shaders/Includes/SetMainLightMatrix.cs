using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteAlways]
public class SetMainLightMatrix : MonoBehaviour
{
    // Start is called before the first frame update
    /*void Start()
    {
        
    }*/
    private int property = Shader.PropertyToID("_WorldToMainLightMatrix");

    // Update is called once per frame
    void Update()
    {
        // Create Rotation Matrix from transform
        // Basically transform.localToWorldMatrix, but only rotation
        Matrix4x4 matrix = Matrix4x4.Rotate(transform.rotation);

        // Set Global Matrix shader property
        Shader.SetGlobalMatrix(property, matrix);
    }
}
