app.factory('Comment', ['$resource', '$location', 'Post', 'flash', function($resource, $location, Post, flash) {

  var models, comment, setup;

  models = {};

  comment = $resource('/api/posts/:postId/comments/', {format: 'json'}, {

  });

  setup = function (postId) {
    models.comments = comment.query({postId: postId});
  }

  return {
    setup: setup,
    models: models
  }

}]);