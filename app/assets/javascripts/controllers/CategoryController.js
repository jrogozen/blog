app.controller("CategoryController", ['$scope', '$routeParams', '$resource', '$anchorScroll', 'Category', 'Post', 'flash', function($scope, $routeParams, $resource, $anchorScroll, Category, Post, flash) {
 
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