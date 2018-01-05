varying vec2 UV;
varying vec3 nor;
varying vec3 vpos; // vertex pos modelspace
varying vec3 wpos; // vertex pos world

void main(){
	UV = uv;
	nor = normal;
	vpos = position;

	
	vpos.z += 0.3 *
	  (
	   cos(0.4 * vpos.x) +
	   cos(0.4 * vpos.y)
	   );
	
	gl_Position =
		projectionMatrix *
		modelViewMatrix *
		vec4(vpos, 1.0);
	
	wpos = gl_Position.xyz;
}
