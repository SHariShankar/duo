$ ->
  $.ajax
    url: '/user/detail'
    method: 'GET'
    dataType: 'json'
    success: (data) ->
      $('.entry-editor').each (i, el) ->
        setupQuill(el, data.user.name)

quillOptions =
  theme: 'bubble'

setupQuill = (container, userName) ->
  editor = new Quill container, quillOptions
  editor.on 'text-change', DuoUtils.debounce (delta, oldDelta, source) ->
    $.ajax 
      url: container.getAttribute('data-url')
      data:
        entry:
          text: container.firstChild.innerHTML
      method: 'PUT'
      dataType: 'json'
  , 2000
  
  if container.getAttribute('current-user') != userName
    editor.enable false