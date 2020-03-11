//= require slimselect.min

var slidons = document.querySelector('#ex2') !== null;
if (slidons) {
  var slider = new Slider('#ex2', {
    formatter: function(value) {
  		return 'Prix min: ' + value[0] + '€'  + ' Prix max: ' + value[1] + '€';
  		// return 'Prix: ' +  value;
  	},
  });

};
