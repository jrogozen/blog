app.controller('CategoriesController', ['$scope', '$routeParams', '$location', '$resource', '$anchorScroll', 'Category', function($scope, $routeParams, $location, $resource, $anchorScroll, Category) {

  Category.setup();

  $scope.categories = Category.models.categories

  $scope.scrollTo = function(id) {
    console.log('scrolling to ' + id);
    var old = $location.hash();
    $location.hash(id);
    $anchorScroll();
    $location.hash(old);
  }

  $scope.deleteCategory = function(catId) {
    Category.deleteCategory(catId);
  };
  
}]);