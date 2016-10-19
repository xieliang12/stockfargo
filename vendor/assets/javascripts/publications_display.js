$(document).ready(function () {
  var pub = gon.publications;
    var tr;
    for (var i = 0; i < pub.length; i++) {
      tr = $('<tr/>');
      tr.append("<td>Pubmed ID:</td>")
      tr.append("<td>" + "<a target='_blank' href='https://www.ncbi.nlm.nih.gov/pubmed/" + pub[i].pmid + "'>" + pub[i].pmid + "</a>" + "</td>");
      $('table#publications').append(tr);
      tr = $('<tr/>');
      tr.append("<td>Title:</td>")
      tr.append("<td>" + pub[i].title + "</td>");
      $('table#publications').append(tr);
      tr = $('<tr/>');
      tr.append("<td>Magazine:</td>");
      tr.append("<td>" + pub[i].magazine + "</td>");
      $('table#publications').append(tr);
      tr = $('<tr/>');
      tr.append("<td>Publish Date:</td>");
      tr.append("<td>" + pub[i].publish_date + "</td>");
      $('table#publications').append(tr);
      tr = $('<tr/>');
      tr.append("<td>Abstract:</td>")
      tr.append("<td>" + pub[i].abstract + "</td>");
      $('table#publications').append(tr);
      tr = $('<tr/>');
      tr.append("<td colspan='2'></td>");
      $('table#publications').append(tr);
    }
});
