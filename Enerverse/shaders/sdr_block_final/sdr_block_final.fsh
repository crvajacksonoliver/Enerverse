varying vec2 v_Texcoord;
varying vec4 v_Colour;

uniform lowp int u_Box;
uniform lowp int u_Debug;

void main()
{
	if (u_Box == 1)
	{
		if (floor(v_Texcoord.x * 32.0) == 0.0 || floor(v_Texcoord.x * 32.0) == 31.0 || floor(v_Texcoord.y * 32.0) == 0.0 || floor(v_Texcoord.y * 32.0) == 31.0)
			gl_FragColor = vec4(vec3(0.5) - vec3(v_Colour * texture2D(gm_BaseTexture, v_Texcoord)), 1.0);
		else
			gl_FragColor = v_Colour * texture2D(gm_BaseTexture, v_Texcoord);
	}
	else
	{
		if (u_Debug == 1)
			gl_FragColor = texture2D(gm_BaseTexture, v_Texcoord) * vec4(1.0, 0.3, 0.3, 1.0);
		else
			gl_FragColor = texture2D(gm_BaseTexture, v_Texcoord);
	}
}
