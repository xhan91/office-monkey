//= require jsapi
//= require chartkick
$(document).ready(function() {

    // voting up and down in main page
    $(".vote-btn").click(function() {
        var voteBtn = $(this)
        voteBtn.addClass("is-loading")
        $.post("/votes", { 
            user_id: $(this).find(".user_id").val(), 
            critique_id: $(this).find(".critique_id").val() }, 
            function(result) {
                voteBtn.find(".vote-count").text(result);
                voteBtn.removeClass("is-loading");
                voteBtn.toggleClass("is-outlined");
        });
    });

    // something else
});
