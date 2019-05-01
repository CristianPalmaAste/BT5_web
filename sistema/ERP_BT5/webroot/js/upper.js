//$("#username").focus();

$(function() {
    $('.upper').keyup(function() {
          // store current positions in variables
    var start = this.selectionStart,
        end = this.selectionEnd;
		
	//alert(start+" "+end);	
    
    this.value = this.value.toUpperCase();
    
    // restore from variables...
    this.setSelectionRange(start, end);
    });
});