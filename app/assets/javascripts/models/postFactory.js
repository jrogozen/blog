app.factory('Post', ['$resource', function($resource) {
  var models, post, queryPosts, setup;

  models = {};

  post = $resource('/api/posts/:postId', { postId: "@id", format: 'json' });

  setup = function() {
    models.posts = post.query();
  }

  return {
    setup: setup,
    models: models
  };
}]);