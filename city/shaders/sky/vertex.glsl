varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;

void main(){
    UV = uv;
    nor = normal;
    
    // Put further
    vpos = position;
    
    gl_Position =
        projectionMatrix *
        modelViewMatrix *
        vec4(vpos, 1.0);
}
