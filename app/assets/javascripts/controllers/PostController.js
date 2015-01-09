app.controller("PostController", ['$scope', '$routeParams', '$resource', 'Post', 'Category', 'flash', function($scope, $routeParams, $resource, Post, Category, flash) {
 
  if ($routeParams.id) {
    $scope.post = Post.currentPost($routeParams.id);
  } else {
    Category.setup();
    $scope.categories = Category.models.categories;
  }

  $scope.addPost = function(post) {
    if (!post.category_id) {
      Category.getDefaultId().$promise.then(function(data) {
        post.category_id = data.id;
        Post.addPost(post);
      });
    } else {
      Post.addPost(post);
    }
  };

  $scope.editPost = function(post) {
    Post.editPost(post);
  };

  $scope.deletePost = function(postId) {
    Post.deletePost(postId);
  }

}]);