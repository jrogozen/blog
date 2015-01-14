app.factory('Category', ['$resource', '$location', 'flash', function($resource, $location, flash) {
  var models, category, setup, addCategory, deleteCategory, getCategory, getDefaultId;

  models = {};

  category = $resource('/api/categories/:id', { id: "@id", format: 'json' }, {
    defaultId: {
      isArray: false,
      method: 'GET',
      url: '/api/categories/getdefault'
    }
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

  deleteCategory = function(catId) {
    category.delete({id: catId}, function(successResult) {
      $location.path('/');
      flash.success = "Category deleted succesffully."
    }, function(errorResult) {
      flash.error = "Error deleting category.";
    });
  };

  getCategory = function(catId) {
    return category.get({id: catId});
  }

  getDefaultId = function() {
    return category.defaultId();
  }

  return {
    setup: setup,
    models: models,
    addCategory: addCategory,
    getCategory: getCategory,
    getDefaultId: getDefaultId,
    deleteCategory: deleteCategory
  };
}]);