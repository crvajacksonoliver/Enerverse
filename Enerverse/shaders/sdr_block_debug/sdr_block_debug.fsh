varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	gl_FragColor = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord) * (1 + (max(0.03125, v_vTexcoord.x) * -1));
}
