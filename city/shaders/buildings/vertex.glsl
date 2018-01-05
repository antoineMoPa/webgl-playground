varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;
varying vec3 wpos;

void main(){
    UV = uv;
    nor = normal;

    vpos = position;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    wpos = gl_Position.xyz;
}
