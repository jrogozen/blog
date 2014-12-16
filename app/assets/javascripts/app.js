var app = angular.module('blog', [
  'ngRoute',
  'templates',
  'controllers'
]);

app.config(['$routeProvider', function($routeProvider) {
  $routeProvider
  .when('/', {
    templateUrl: 'index.html',
    controller: 'PostController'
  })
}]);

var posts = [
  {
    id: 1,
    name: "Setting up Rails 4 & Angular"
  },
  {
    id: 2,
    name: "Testing a Rails/Angular App"
  },
  {
    id: 3,
    name: "Starting New Job as Web QA Analyst"
  },
  {
    id: 4,
    name: "Thanks MakerSquare"
  }
]

controllers = angular.module('controllers', [])

controllers.controller('PostController', ['$scope', '$routeParams', '$location', function($scope, $routeParams, $location) {
  $scope.search = function(keywords) {
    $location.path("/").search('keywords', keywords);

    if ($routeParams.keywords) {
      keywords = $routeParams.keywords.toLowerCase();
      $scope.posts = posts.filter(function(post) {
        return post.name.toLowerCase().indexOf(keywords) != -1
      });
    } else {
      $scope.posts = [];
    }
  };
}]);