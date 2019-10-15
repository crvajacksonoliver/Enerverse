varying vec2 v_Texcoord;
varying vec4 v_Colour;

uniform float u_Mul;

void main()
{
    gl_FragColor = u_Mul * v_Colour * texture2D(gm_BaseTexture, v_Texcoord);
}
