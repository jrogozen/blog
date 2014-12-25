app.controller("PostController", ['$scope', '$routeParams', '$resource', 'Post', 'flash', function($scope, $routeParams, $resource, Post, flash) {
 
  if ($routeParams.id) {
    $scope.post = Post.currentPost($routeParams.id);
  }

  $scope.addPost = function(post) {
    Post.addPost(post);
  };

  $scope.editPost = function(post) {
    Post.editPost(post);
  };

}]);