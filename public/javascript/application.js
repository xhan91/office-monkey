//= require jsapi
//= require chartkick
$(document).ready(function() {

    // voting up and down in main page
    $(".vote-btn").click(function() {
        var tmp = $(this)
        $.post("/votes", { 
            user_id: $(this).find("#user_id").val(), 
            critique_id: $(this).find("#critique_id").val() }, 
            function(result) {
                tmp.find("#vote-count").text(result);
                tmp.find(".icon").toggleClass("icon-voted");
        });
    });

    // something else
});
