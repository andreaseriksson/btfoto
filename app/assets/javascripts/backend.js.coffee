jQuery ->
  $('#new_picture').fileupload
    dataType: "script"
    add: (e, data) ->
      data.context = $(tmpl("template-upload", data.files[0]))
      $('#new_picture').append(data.context)
      data.submit()
    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')

  $('.editor').each (i, elem) ->
    $(elem).wysihtml5
      html: true

  $('.filter').click (e) ->
    e.preventDefault
    filter = $(this).data('filter')
    value = $(this).data('value')
    $('[data-'+filter+'="'+value+'"]').toggle()
