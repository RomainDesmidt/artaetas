var btnDecouvrir = document.querySelector('#aa-decouvrir') !== null;
if (btnDecouvrir) {
document.getElementById('aa-decouvrir').onclick = function()
{
  window.location = this.querySelector("a").href;
}

};

var btnDeposer = document.querySelector('#aa-deposer') !== null;
if (btnDeposer) {
document.getElementById('aa-deposer').onclick = function()
{
  window.location = this.querySelector("a").href;
}

};

var btnUploadUn = document.querySelector('#previewPhoto') !== null;
if (btnUploadUn) {
  document.getElementById('previewPhoto').onclick = function()
{
  this.parentNode.querySelector("label").click();
}

};

var btnUploadDeux = document.querySelector('#previewPhotoUn') !== null;
if (btnUploadDeux) {
  document.getElementById('previewPhotoUn').onclick = function()
{
  this.parentNode.querySelector("label").click();
}

};

var btnUploadTrois = document.querySelector('#previewPhotoDeux') !== null;
if (btnUploadTrois) {
  document.getElementById('previewPhotoDeux').onclick = function()
{
  this.parentNode.querySelector("label").click();
}

};


var btnUploadQuatre = document.querySelector('#previewPhotoProfil') !== null;
if (btnUploadQuatre) {
  document.getElementById('previewPhotoProfil').onclick = function()
{
  this.parentNode.querySelector("label").click();
}

};

var btnUploadCinq = document.querySelector('#previewPhotoFond') !== null;
if (btnUploadCinq) {
  document.getElementById('previewPhotoFond').onclick = function()
{
  this.parentNode.querySelector("label").click();
}

};