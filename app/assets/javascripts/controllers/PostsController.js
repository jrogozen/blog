app.controller('PostsController', ['$scope', '$routeParams', '$location', '$resource', 'Post', '$http', function($scope, $routeParams, $location, $resource, Post, $http) {

  Post.setup();

  $scope.posts = Post.models.posts
  
}]);