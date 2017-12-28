$(document).ready(function() {
    console.log("ika");
    $(".done").click(function(evnt) {
        console.log("Done");
        var item_id = $(this).parents('li').attr('id');
        console.log(item_id);
    })
});