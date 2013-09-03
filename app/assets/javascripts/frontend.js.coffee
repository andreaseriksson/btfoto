

#
getChecked = ->
  $("#delete_cart_items").val ""
  checked_list = []
  $("input:checked").each ->
    checked_list.push $(this).val()
  $("#delete_cart_items").val checked_list
  

$ ->
  $(".cart_item_row input[type=checkbox]").on 'click', getChecked

$ ->
  $("#checkout-table td#actions").append( $("#update-cart-button") )
  $("#update-cart-button").on 'click', ->
    $("#update-cart-form").submit()

$ ->
  $("a[data-toggle=tooltip]").tooltip()

$ ->
  $("#cart-content-container").effect "highlight", {}, 800  unless $("#add-to-cart-message").length is 0
  $(".carousel").carousel
    interval: 3500
    pause: false

  $(".submit input").addClass "btn btn-success"
  $("#update-cart").on "click", (event) ->
    event.preventDefault()
    $(".update-count").each ->
      item_id = $(this).data("id")
      image_nr = $(this).data("image")
      item_count = $(this).val()
      url = "/store/carts/update_cart/" + item_id + "/" + item_count + "/" + image_nr + "/?r=" + Math.random()
      $.get url

    setTimeout (->
      $("#ajax-filler").parent().load "/store/checkout #ajax-filler"
    ), 1500

  $("#delete-row").on "click", (event) ->
    event.preventDefault()
    $("#checkout-table input[type=checkbox]").each ->
      if $(this).is(":checked")
        image_nr = $(this).data("image")
        console.log image_nr
        url = "/store/carts/update_cart/" + $(this).data("id") + "/0/" + image_nr + "/?r=" + Math.random()
        $.get url
      setTimeout (->
        $("#ajax-filler").parent().load "/store/checkout #ajax-filler", ->
          window.location = "/store/"  if $("#update-cart").length is 0

      ), 1500

$ ->
  $('.img-modal a').magnificPopup
    type:'image'
    mainClass: 'mfp-fade'

  #$("form div.input, form div.submit").addClass "control-group"
  #$("form label").addClass "control-label"
  #$("select,input[type=text],textarea").wrap "<div class=\"controls\" /></div>"
  #$("form").addClass "form-horizontal"
  #$("form div.submit").prepend "<label class=\"control-label\"></label>"
  
  
  #$("div.thumbnail a").on "click", (event) ->
  #  event.preventDefault()
  #  url = $(this).attr("href") + "?ajax=1&r=" + Math.random()
  #  $("#modal-container").load url, ->
  #    $(".modal-footer #CartUrl").val "/startsida"
  #    $("#modal-container").modal "show"




#Ajaxifiera varukorgen - inte klart
#$("#CartAddToCartForm .btn-success").live('click', function(event){
#	  			event.preventDefault();
#	  			
#	  			var data = $(this).parent().parent().serialize();
#	  			var url = $(this).parent().parent().attr("action")+"?ajax=1&r="+Math.random();
#	  			var this_url = "/store";
#	  			
#	  			$.post(url, function(data) {
#					$('#modal-container').modal('hide');
#					$('#cart-content-container').load(this_url+" #cart-content", function() {
#				      $("#cart-content-container").effect('highlight', {}, 800);
#				    });
#				});
#	  			
#	  		});