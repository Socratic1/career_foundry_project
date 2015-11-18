var app = angular.module('shop', ['ngResource']);

app.factory('models', ['$resource', function($resource){
	var orders_model = $resource("/orders/:id.json", {id: "@id"});
	var products_model = $resource("/products/:id.json", {id: "@id"});
	var users_model = $resource("/users/:id.json", {id: "@id"});
	var x = {
		orders: orders_model,
		products: products_model,
		users: users_model
	};
	return x;
}]);

app.controller('OrdersCtrl', ['$scope', 'models', function($scope, models){
	$scope.orders = models.orders.query();
	$scope.products = models.products.query();
	$scope.users = models.users.query();
	$scope.addOrder = function(){
		order = models.orders.save($scope.newOrder, function(){
			recent_order = models.orders.get({id: order.id});
			$scope.orders.push(recent_order);
			$scope.newOrder = '';
		});
	}
	$scope.deleteOrder = function(order){
		models.orders.delete(order);
		$scope.orders.splice($scope.orders.indexOf(order), 1);
	}
}]);