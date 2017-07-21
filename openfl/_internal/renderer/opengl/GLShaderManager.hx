package openfl._internal.renderer.opengl;


import lime.graphics.GLRenderContext;
import openfl._internal.renderer.AbstractShaderManager;
import openfl.display.Shader;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end

@:access(openfl.display.Shader)


class GLShaderManager extends AbstractShaderManager {
	
	
	private var gl:GLRenderContext;
	
	
	public function new (gl:GLRenderContext) {
		
		super ();
		
		this.gl = gl;
		
		defaultShader = new Shader ();
		initShader (defaultShader);
		
	}
	
	
	public override function initShader (shader:Shader):Shader {
		
		if (shader != null) {
			
			// TODO: Change of GL context?
			
			if (shader.gl == null) {
				
				shader.gl = gl;
				shader.__init ();
				
			}
			
			return shader;
			
		}
		
		return defaultShader;
		
	}
	
	
	public override function setShader (shader:Shader):Void {
		
		if (currentShader == shader) {
			
			if (currentShader != null) currentShader.__update ();
			return;
			
		}
		
		if (currentShader != null) {
			
			currentShader.__disable ();
			
		}
		
		if (shader == null) {
			
			currentShader = null;
			gl.useProgram (null);
			return;
			
		}
		
		currentShader = shader;
		
		if (currentShader.gl == null) {
			
			currentShader.gl = gl;
			currentShader.__init ();
			
		}
		
		gl.useProgram (shader.glProgram);
		currentShader.__enable ();
		currentShader.__update ();
		
	}
	
	
}