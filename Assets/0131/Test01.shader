Shader "Example/test01" {
    Properties {
      _TintColor("TintColor", Color) = (1,1,1,1)
	  _MainTex ("Texture", 2D) = "white" {}
      _MainTex02("Emissive Texture", 2D) = "white" {}
      _MainTex03("Emissive Texture", 2D) = "white" {}
      _EColor("Emissive Color", Color) = (1,1,1,1)
      _Tile("Tiling", Vector) = (1,1,1,1)

      _Inten ("Intensity", Range(0, 1)) = 1
    }
    SubShader {
      Tags { "RenderType" = "Opaque" "Queue" = "Geometry" }
      CGPROGRAM

      #pragma surface surf Unlit noambient
      half4 LightingUnlit(SurfaceOutput s, half3 lightDir, half atten)
{
    return fixed4(s.Albedo, 1);
}

      struct Input {

          float2 uv_MainTex;
          float2 uv_MainTex02;
    float3 worldPos;
    };

      sampler2D _MainTex;
sampler2D _MainTex02;
sampler2D _MainTex03;
fixed4 _TintColor;
fixed4 _EColor;
half _Inten;
float4 _Tile;

      void surf (Input IN, inout SurfaceOutput o) {

     fixed3 c = tex2D(_MainTex, float2(IN.worldPos.x * _Tile.x, IN.worldPos.z * _Tile.y)).rgb ;
    fixed3 e = tex2D(_MainTex02, IN.uv_MainTex02).rgb;
    fixed3 l = tex2D(_MainTex03, IN.uv_MainTex02).rgb;
    // o.Albedo = c.rgb * _TintColor;
    fixed3 final = lerp(c, e, l.r);
    o.Albedo = c;
    //o.Albedo = (final.r + final.g + final.b)/3;
    //o.Albedo = (0.2999 * final.r + 0.587 * final.b + 0.114 * final.g);

    o.Emission = e * _EColor * abs(sin(_Time.y));

}

ENDCG
    } 
        Fallback "VertexLit"
  }