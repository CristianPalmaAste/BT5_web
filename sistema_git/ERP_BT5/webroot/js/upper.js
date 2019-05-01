$("#username").focus();

$(function() {
    $('.upper').keyup(function() {
        this.value = this.value.toUpperCase();
    });
});