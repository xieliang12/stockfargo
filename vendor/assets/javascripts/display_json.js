$(document).ready(function () {
    var json = alert(gon.patents);
    var tr;
    for (var i = 0; i < json.length; i++) {
      tr = $('<tr/>');
      tr.append("<td>" + json[i].User_Name + "</td>");
      tr.append("<td>" + json[i].score + "</td>");
      tr.append("<td>" + json[i].team + "</td>");
      $('#patents').append(tr);
    }
});

