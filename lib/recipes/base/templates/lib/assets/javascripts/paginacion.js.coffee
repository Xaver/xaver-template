jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination a[rel=next]').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
        $('.pagination').text("Buscando más...")
        $.getScript(url)
    $(window).scroll()