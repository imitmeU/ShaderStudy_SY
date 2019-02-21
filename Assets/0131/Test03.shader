  Shader "Example/Test03" {
    Properties {
      _MainTex("Texture", 2D) = "white" {}
     [Normal][NoScaleOffset]_BumpMap("Normal texture", 2D) = "white" {}
//_AlphaCut("AlphaCut", Range(0,1)) = 0.5
    }
    SubShader {
      Tags { "RenderType" = "Transparent" "Queue" = "Transparent" }
      CGPROGRAM
#pragma surface surf Lambert alpha keepalpha

      struct Input
{
    float2 uv_MainTex;
};

sampler2D _MainTex;
sampler2D _BumpMap;

void surf(Input IN, inout SurfaceOutput o)
{
    fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
    o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MainTex));

    o.Alpha = c.r * 0.5;
}
ENDCG
    }
    Fallback "Diffuse"
  }