app.controller("PostController", ['$scope', '$routeParams', '$resource', 'Post', 'Category', 'Comment', 'flash', function($scope, $routeParams, $resource, Post, Category, Comment, flash) {
 
  if ($routeParams.id) {
    Comment.setup($routeParams.id);
    $scope.post = Post.currentPost($routeParams.id);
    $scope.comments = Comment.models.comments;
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