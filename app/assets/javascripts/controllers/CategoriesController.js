app.controller('CategoriesController', ['$scope', '$routeParams', '$location', '$resource', 'Category', function($scope, $routeParams, $location, $resource, Category) {

  Category.setup();

  $scope.categories = Category.models.categories
  
}]);