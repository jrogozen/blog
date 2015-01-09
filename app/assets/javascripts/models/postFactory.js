app.factory('Post', ['$resource', '$location', 'flash', function($resource, $location, flash) {
  var models, post, queryPosts, setup, addPost, currentPost, editPost, deletePost;

  models = {};

  post = $resource('/api/posts/:id', { id: "@id", format: 'json' }, {
    update: {
      method: 'PUT'
    }
  });

  setup = function(id) {
    models.posts = post.query();
  };

  currentPost = function(postId) {
    return post.get({id: postId}, function(success) {}, function(error) {
      flash.error = 'No Post Found';
    });
  };

  addPost = function(data) {
    post.save(data, function(successResult) {
      $location.path('/posts/' + successResult.id);
    }, function(errorResult) {
      flash.error = errorResult.data.errors.join(", ")
    });
  };

  deletePost = function(postId) {
    post.delete({id: postId}, function(successResult) {
      $location.path('/');
      flash.success = "Post deleted succesffully."
    }, function(errorResult) {
      flash.error = errorResult.data.errors.join(", ")
    });
  };

  editPost = function(data) {
    post.update(data, function(successResult) {
      $location.path('/posts/' + successResult.id);
      flash.success = "Post successfully updated."
    }, function(errorResult) {
      flash.error = errorResult.data.errors.join(", ")
    });
  };

  return {
    setup: setup,
    models: models,
    addPost: addPost,
    editPost: editPost,
    deletePost: deletePost,
    currentPost: currentPost
  };
}]);