google.load("language", "1");

Event.observe(window, 'load', function() { 		

	// Translate the phrase when the translator clicks on the text area
	// only fires if textarea is blank
	$$('textarea').invoke('observe', 'click', function(event) {
 		var phrase = this.up('tr').down('span.to_translate');
		var textarea = this;
		var target_language = $('target_language').innerHTML;
		
		if (phrase && textarea && $F(textarea).blank()){
			//translate it using google translate, autodetect source language			
			var to_trans = phrase.innerHTML;			
			google.language.translate(to_trans, "", target_language, function(result) {
			  if (!result.error) {
					textarea.setValue(result.translation);
					textarea.select();
			  }		
			});			
		}	  
	});		
});
