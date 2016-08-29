varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;

void main(){
    UV = uv;
    nor = normal;

    vpos = position.xyz;
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}
