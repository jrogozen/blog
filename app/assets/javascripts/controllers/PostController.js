app.controller("PostController", ['$scope', '$routeParams', '$resource', function($scope, $routeParams, $resource) {
  var Post = $resource('/api/posts/:postId', { postId: "@id", format: 'json' });

  Post.get({recipeId: $routeParams.postId}, (function(post) {
    return $scope.post = post;
  }), (function(httpResponse) {
    return $scope.post = null;
  }));
}]);