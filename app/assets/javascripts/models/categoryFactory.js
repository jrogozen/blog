app.factory('Category', ['$resource', '$location', 'flash', function($resource, $location, flash) {
  var models, category, setup;

  models = {};

  category = $resource('/api/categories/:id', { id: "@id", format: 'json' }, {
  });

  setup = function(id) {
    models.categories = category.query();
  };

  addCategory = function(data) {
    category.save(data, function(successResult) {
      flash.success = "Category " + successResult.name + " created successfully.";
      $location.path('/categories');
    }, function(errorResult) {
      flash.error = errorResult.data.errors.join(", ")
    });
  };

  // deletePost = function(postId) {
  //   post.delete({id: postId}, function(successResult) {
  //     $location.path('/');
  //     flash.success = "Post deleted succesffully."
  //   }, function(errorResult) {
  //     flash.error = "Error deleting post.";
  //   });
  // };

  return {
    setup: setup,
    models: models,
    addCategory: addCategory
  };
}]);