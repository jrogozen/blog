app.factory('Comment', ['$resource', '$route', '$location', 'Post', 'flash', function($resource, $route, $location, Post, flash) {

  var models, comment, setup, addComment, deleteComment;

  models = {};

  comment = $resource('/api/posts/:post_id/comments/:id', {post_id: "@post_id", id: "@id", format: 'json'}, {

  });

  setup = function (postId) {
    models.comments = comment.query({post_id: postId});
  };

  addComment = function(data, postId) {
    comment_obj = {
      content: data["content"],
      post_id: postId
    }
    comment.save(comment_obj, function(successResult) {
      flash.success = "Comment posted!"
      $route.reload();
    });
  };

  deleteComment = function(commentId, postId) {
    comment_obj = {
      id: commentId,
      post_id: postId
    }
    comment.delete(comment_obj, function(successResult) {
      flash.success = "Comment deleted!"
      $route.reload();
    });
  };

  return {
    setup: setup,
    models: models,
    addComment: addComment,
    deleteComment: deleteComment
  }

}]);