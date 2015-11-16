$(document).ready( function(){

	$('.search_toggle').click(function() {
		$('.search').toggleClass("search_active");
	});


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

	$('.new_product_description').tagsInput();

	$('.chosen-select').chosen({
		width: "173px"
	});

});