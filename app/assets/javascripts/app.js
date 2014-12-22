var app = angular.module('blog', [
  'ngRoute',
  'ngResource',
  'templates',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
]);

app.config(['$routeProvider', function($routeProvider) {
  $routeProvider
  .when('/', {
    templateUrl: 'index.html',
    controller: 'PostsController',
    reloadOnSearch: false
  })
  .when('/posts/:postId', {
    templateUrl: "show.html",
    controller: 'PostController'
  })
}]);
