app.controller('PostsController', ['$scope', '$routeParams', '$location', '$resource', 'Post', function($scope, $routeParams, $location, $resource, Post) {

  Post.setup();

  $scope.posts = Post.models.posts
  
}]);