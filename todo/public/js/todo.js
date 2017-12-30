$(document).ready(function() {
    console.log("ika");
    $(".done").click(function(evnt) {
        console.log("Done");
        var item_id = $(this).parents('li').attr('id');
        console.log(item_id);
        $.ajax({
            type: "POST",
            url: "/done",
            data: { id: item_id },
        }).done(function(data) {
            if(data.status == 'done') {
                $("#" + data.id + " a.done").text('Not ready yet')
                $("#" + data.id + " .item").wrapInner("<del>");
            }
            else {
                $("#" + data.id + " a.done").text('Done')
                $("#" + data.id + " .item").html(function(i, h) {
                    return h.replace("<del>", "");
                });
            }
        });
        evnt.preventDefault();
    });


    $(".removeItem").click(function (event) {
        if(confirm('Are you sure you want to delete this?')) {
         console.log("I m sure")
        }

    })
});