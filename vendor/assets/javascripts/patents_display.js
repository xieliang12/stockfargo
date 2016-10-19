$(document).ready(function () {
    var json = gon.patents;
      var tr;
      for (var i = 0; i < json.length; i++) {
        tr = $('<tr/>');
        tr.append("<td>Patent ID:</td>")
        tr.append("<td>" + "<a target='_blank' href='" + json[i].link + "'>" + json[i].patent_id + "</a>" + "</td>");
        $('table#patents').append(tr);
        tr = $('<tr/>');
        tr.append("<td>Inventors:</td>")
        tr.append("<td>" + json[i].inventor + "</td>");
        $('table#patents').append(tr);
        tr = $('<tr/>');
        tr.append("<td>Report Date:</td>")
        tr.append("<td>" + json[i].report_date + "</td>");
        $('table#patents').append(tr);
        tr = $('<tr/>');
        tr.append("<td>Title:</td>")
        tr.append("<td>" + json[i].title + "</td>");
        $('table#patents').append(tr);
        tr = $('<tr/>');
        tr.append("<td>Abstract:</td>");
        tr.append("<td>" + json[i].abstract + "</td>");
        $('table#patents').append(tr);
        tr = $('<tr/>');
        tr.append("<td colspan='2'></td>");
        $('table#patents').append(tr);
      }
});
  
