varying vec2 UV;
varying vec3 nor;
varying vec3 vpos;
varying vec3 wpos;

#define PI 3.1416

uniform float time;


void main(void){
	float x = UV.x;
	float y = UV.y;

	vec4 col;
	
	col.rgb = vec3(0.1, 0.1, 0.1);
	
	col -= 0.02 * cos(vpos.x * 0.4) + 0.02 * cos(vpos.y * 0.4);

	col *= 1.0 + 0.03 * cos(vpos.x * 10.0) + 0.04 * cos(vpos.x * 12.0);
	
	col.a = 1.0;
	
	gl_FragColor = col;
}
