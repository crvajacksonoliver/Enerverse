varying vec2 v_Texcoord;
varying vec4 v_Colour;

uniform float u_R;
uniform float u_G;
uniform float u_B;

void main()
{
    gl_FragColor = v_Colour * texture2D(gm_BaseTexture, v_Texcoord) * vec4(u_R, u_G, u_B, 1.0);
}
