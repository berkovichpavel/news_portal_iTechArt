// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

jQuery(function($){
    $(".deleteAction").click(function (){
        const current_comment = $(this).parents('div')[0]
        const comment_div = $(this).parents(".media")[0]
        if(confirm("Are you sure?")){
            $.ajax({
                url: '/items/' + $(current_comment).attr('data-item_id') + '/comments/' +  $(current_comment).attr('data-comment_id'),
                type: 'POST',
                data: { _method: 'DELETE' },
                success: function (){
                    $(comment_div).html(
                        "<strong>[deleted]</strong> posted <br/>"+
                        "<p>[deleted]</p>")
                }
            })
        }
    })
})


