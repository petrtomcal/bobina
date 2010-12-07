/*
*	Class: fileUploader
*	Use: Upload multiple files the jQuery way
*	Author: Michael Laniba (http://pixelcone.com)
*	Version: 1.0
*/

$.extend({URLEncode:function(c){var o='';var x=0;c=c.toString();var r=/(^[a-zA-Z0-9_.]*)/;
  while(x<c.length){var m=r.exec(c.substr(x));
    if(m!=null && m.length>1 && m[1]!=''){o+=m[1];x+=m[1].length;
    }else{if(c[x]==' ')o+='+';else{var d=c.charCodeAt(x);var h=d.toString(16);
    o+='%'+(h.length<2?'0':'')+h.toUpperCase();}x++;}}return o;},
URLDecode:function(s){var o=s;var binVal,t;var r=/(%[^%]{2})/;
  while((m=r.exec(o))!=null && m.length>1 && m[1]!=''){b=parseInt(m[1].substr(1),16);
  t=String.fromCharCode(b);o=o.replace(m[1],t);}return o;}
});

(function($) {
	$.fileUploader = {version: '1.0'};
	$.fn.fileUploader = function(config){

		config = $.extend({}, {
			imageLoader: '',
			buttonUpload: '#pxUpload',
			buttonClear: '#pxClear',
			successOutput: 'File Uploaded',
			errorOutput: 'Failed',
			inputName: 'userfile',
			inputSize: 30,
			allowedExtension: 'jpg|jpeg|gif|png'
		}, config);

		var itr = 0; //number of files to uploaded

		//public function
		$.fileUploader.change = function(e){
			var fname = px.validateFile( $(e).val() );
			if (fname == -1){
				alert ("Invalid file!");
				$(e).val("");
				return false;
			}
			$('#px_button input').removeAttr("disabled");
			var imageLoader = '';
			if ($.trim(config.imageLoader) != ''){
				imageLoader = '<img src="'+ config.imageLoader +'" alt="uploader" />';
			}
			var display = '<div class="uploadData" id="pxupload'+ itr +'_text" title="pxupload'+ itr +'">' +
				'<div class="close">&nbsp;</div>' +
				'<span class="fname">'+ fname +'</span>' +
				'<span class="loader" style="display:none">'+ imageLoader +'</span>' +
				'<div class="status">Pending...</div></div>';

			$("#px_display").append(display);
			px.appendForm();
			$(e).hide();
		}

		$(config.buttonUpload).click(function(){
			if (itr > 1){
				$('#px_button input').attr("disabled","disabled");
				$("#pxupload_form form").each(function(){
					e = $(this);
					var id = "#" + $(e).attr("id");
					var input_id = id + "_input";
					var input_val = $(input_id).val();
					if (input_val != ""){
						$(id + "_text .status").text("Uploading...");
						$(id + "_text").css("background-color", "#FFF0E1");
						$(id + "_text .loader").show();
						$(id + "_text .close").hide();

						$(id).submit();
						$(id +"_frame").load(function(){
							$(id + "_text .loader").hide();
							up_output = $(this).contents().find("#output").text();
							if (up_output == "success"){
								$(id + "_text").css("background-color", "#F0F8FF");
								up_output = config.successOutput;
							}else{
								$(id + "_text").css("background-color", "#FF0000");
								up_output = config.errorOutput;
							}
							up_output += '<br />' + $(this).contents().find("#message").text();
							$(id + "_text .status").html(up_output);
							$(e).remove();
							$(config.buttonClear).removeAttr("disabled");
						});
					}
				});
			}
		});

		$(".close").live("click", function(){
			var id = "#" + $(this).parent().attr("title");
			$(id+"_frame").remove();
			$(id).remove();
			$(id+"_text").fadeOut("slow",function(){
				$(this).remove();
			});
			return false;
		});

		$(config.buttonClear).click(function(){
			$("#px_display").fadeOut("slow",function(){
				$("#px_display").html("");
				$("#pxupload_form").html("");
				itr = 0;
				px.appendForm();
				$('#px_button input').attr("disabled","disabled");
				$(this).show();
			});
		});

		//private function
		var px = {
			init: function(e){
				var form = $(e).parents('form');
				px.formAction = $(form).attr('action');
				$(form).before(' \
					<div id="pxupload_form"></div> \
					<div id="px_display"></div> \
					<div id="px_button"></div> \
				');
				$(config.buttonUpload+','+config.buttonClear).appendTo('#px_button');
				if ( $(e).attr('name') != '' ){
					config.inputName = $(e).attr('name');
				}
				if ( $(e).attr('size') != '' ){
					config.inputSize = $(e).attr('size');
				}
				$(form).hide();
				this.appendForm();
			},
			appendForm: function(){
				itr++;
				var formId = "pxupload" + itr;
				var iframeId = "pxupload" + itr + "_frame";
				var inputId = "pxupload" + itr + "_input";
				var contents = '<form method="post" id="'+ formId +'" action="'+ px.formAction +'" enctype="multipart/form-data" target="'+ iframeId +'">' +
				'<input type="file" name="'+ config.inputName +'" id="'+ inputId +'" class="pxupload" size="'+ config.inputSize +'" onchange="$.fileUploader.change(this);" />' +
				'</form>' +
				'<iframe id="'+ iframeId +'" name="'+ iframeId +'" src="about:blank" style="display:none"></iframe>';

				$("#pxupload_form").append( contents );
			},
			validateFile: function(file) {
				if (file.indexOf('/') > -1){
					file = file.substring(file.lastIndexOf('/') + 1);
				}else if (file.indexOf('\\') > -1){
					file = file.substring(file.lastIndexOf('\\') + 1);
				}
				//var extensions = /(.jpg|.jpeg|.gif|.png)$/i;
				var extensions = new RegExp(config.allowedExtension + '$', 'i');
				if (extensions.test(file)){
					return file;
				} else {
					return -1;
				}
			}
		}

		px.init(this);

		return this;
	}
})(jQuery);

