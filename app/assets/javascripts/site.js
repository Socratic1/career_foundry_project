$(document).on('ready', function(){
	$('.rating').raty( { path: '/assets', scoreName: 'comment[rating]' } );
	$('.rated').raty({ path: '/assets',
		readOnly: true,
		score: function() {
			return $(this).attr('data-score');
		}
	});

	$('.display_image').elevateZoom({
		zoomType:  "lens",
		lensShape: "round",
		lensSize:  200
	});

	$(".form_product_colour").chosen();

});