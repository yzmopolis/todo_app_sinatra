$(document).ready(function() {
    $(".done").click(function(evnt) {
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

});