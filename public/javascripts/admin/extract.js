document.observe("dom:loaded", function() {
  var page = location.pathname.match('/admin/pages/[0-9]+/edit'),
      link = $$('#edit_page .buttons a').first()

  if (page && link) {
    var parent_id = $('page_parent_id').readAttribute('value')
    link.writeAttribute('href', link.readAttribute('href') + '/' + parent_id + '/children')
  }
});
