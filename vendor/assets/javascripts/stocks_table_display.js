var Ctable;
$('#overview').click(function() {
  document.getElementById("overview").style.background='#808080';
  document.getElementById("valuation").style.background='#DCDCDC';
  document.getElementById("financial").style.background='#DCDCDC';
  $('#stocks2').hide();
  $('#stocks3').hide();
  $('#stocks1').show();
  Ctable = "table1";
  localStorage.setItem('Ctable', Ctable);
});
$('#valuation').click(function() {
  document.getElementById("overview").style.background='#DCDCDC';
  document.getElementById("valuation").style.background='#808080';
  document.getElementById("financial").style.background='#DCDCDC';
  $('#stocks1').hide();
  $('#stocks3').hide();
  $('#stocks2').show();
  Ctable = "table2";
  localStorage.setItem('Ctable', Ctable);
});
$('#financial').click(function() {
  document.getElementById("overview").style.background='#DCDCDC';
  document.getElementById("valuation").style.background='#DCDCDC';
  document.getElementById("financial").style.background='#808080';
  $('#stocks1').hide();
  $('#stocks2').hide();
  $('#stocks3').show();
  Ctable = "table3";
  localStorage.setItem('Ctable', Ctable);
});

var table_id = localStorage.getItem('Ctable');
if (table_id == "table2") {
  document.getElementById("overview").style.background='#DCDCDC';
  document.getElementById("valuation").style.background='#808080';
  document.getElementById("financial").style.background='#DCDCDC';
  $('#stocks2').show();
} else if (table_id == "table3") {
  document.getElementById("overview").style.background='#DCDCDC';
  document.getElementById("valuation").style.background='#DCDCDC';
  document.getElementById("financial").style.background='#808080';
  $('#stocks3').show();
} else {
  document.getElementById("overview").style.background='#808080';
  document.getElementById("valuation").style.background='#DCDCDC';
  document.getElementById("financial").style.background='#DCDCDC';
  $('#stocks1').show();
}
