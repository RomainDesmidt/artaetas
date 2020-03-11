//= require slimselect.min

var slidons = document.querySelector('#ex2') !== null;
if (slidons) {
  var slider = new Slider('#ex2', {
    formatter: function(value) {
  		return 'Min: ' + value[0] + '€'  + ' - Max: ' + value[1] + '€';
  		// return 'Prix: ' +  value;
  	},
  });

};
