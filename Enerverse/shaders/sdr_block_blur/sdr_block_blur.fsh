varying vec2 v_Texcoord;
varying vec4 v_Colour;

uniform int u_Horizontal;
uniform float u_TextureSizeX;
uniform float u_TextureSizeY;

const int Quality = 8;
const int Directions = 16;
const float Pi = 6.28318530718;//pi * 2

void main()
{
	vec2 radius = vec2(u_TextureSizeX, u_TextureSizeY);
	vec4 Color = texture2D(gm_BaseTexture, v_Texcoord);
	
	for (float d = 0.0; d < Pi; d += Pi / float(Directions))
	{
	    for (float i = 1.0 / float(Quality); i <= 1.0; i += 1.0 / float(Quality))
	    {
			Color += texture2D(gm_BaseTexture, v_Texcoord + vec2(cos(d), sin(d)) * radius * i);
	    }
	}
	
	Color /= float(Quality) * float(Directions) + 1.0;
	gl_FragColor = Color * v_Colour;
}
