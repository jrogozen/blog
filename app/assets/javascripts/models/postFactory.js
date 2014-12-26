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
      if (errorResult.status === 422) {
        flash.error = 'Oops, you forgot to add a name for the post.';
      }
    });
  };

  deletePost = function(postId) {
    post.delete({id: postId}, function(success) {
      $location.path('/');
    }, function(error) {
      flash.error = "Error deleting post."
    })
  };

  editPost = function(data) {
    post.update(data, function(successResult) {
      $location.path('/posts/' + successResult.id);
    }, function(errorResult) {
      flash.error = 'Error updating post.'
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