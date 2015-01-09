app.controller("CategoryController", ['$scope', '$routeParams', '$resource', 'Category', 'flash', function($scope, $routeParams, $resource, Category, flash) {
 
  if ($routeParams.id) {
    $scope.category = Category.currentCategory($routeParams.id);
  }

  $scope.addCategory = function(cat) {
    Category.addCategory(cat);
  };

  $scope.deleteCategory = function(catId) {
    Category.deleteCategory(catId);
  }

}]);