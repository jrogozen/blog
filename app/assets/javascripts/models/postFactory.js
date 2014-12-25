app.factory('Post', ['$resource', '$location', 'flash', function($resource, $location, flash) {
  var models, post, queryPosts, setup, addPost, currentPost;

  models = {};

  post = $resource('/api/posts/:id', { id: "@id", format: 'json' }, {

  });

  setup = function(id) {
    models.posts = post.query();
  }
  
  addPost = function(data) {
    post.save(data, function(successResult) {
      $location.path('/posts/' + successResult.id);
    }, function(errorResult) {
      if (errorResult.status === 422) {
        flash.error = 'Oops, you forgot to add a name for the post.';
      }
    });
  }

  return {
    setup: setup,
    models: models,
    addPost: addPost,
    post: post
  };
}]);