//= require jsapi
//= require chartkick
$(document).ready(function() {

    // voting up and down in main page
    $('#critique-wall-section').on('click', '.vote-btn', function() {
        var voteBtn = $(this);
        voteBtn.addClass("is-loading");
        $.post("/votes", { 
            user_id: $(this).find(".user_id").val(), 
            critique_id: $(this).find(".critique_id").val() }, 
            function(result) {
                voteBtn.find(".vote-count").text(result);
                voteBtn.removeClass("is-loading");
                voteBtn.toggleClass("is-outlined");
        });
    });

    // post new critique with ajax
    $("form.new-post-form").on("submit", function(event) {
        event.preventDefault();
        var form = $(this);
        $(this).find("button").addClass("is-loading");
        $.ajax({
            method: form.attr("method"),
            url: form.attr("action"),
            data: form.serialize(),
            success: function (data) {
                $(".search-box").after(data);
                $(".critique-wall").find(".box").fadeIn();
                $("form.new-post-form").find("button").removeClass("is-loading")
            }
        });
    });

    // something else
});
