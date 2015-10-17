$(document).on('ready page:load', function(){
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

	$(".product_colour").chosen({allow_single_deselect: true,
								 no results_text: 'No results matched',
								 width: '200px'
	});
});
