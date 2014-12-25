app.controller("PostController", ['$scope', '$routeParams', '$resource', 'Post', 'flash', function($scope, $routeParams, $resource, Post, flash) {
 
  if ($routeParams.id) {
    $scope.post = Post.post.get({id: $routeParams.id}, function(success) {}, function(error) {
      flash.error = 'No Post Found';
    });
  }

  $scope.addPost = function(post) {
    Post.addPost(post);
  };

}]);